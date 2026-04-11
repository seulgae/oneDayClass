package com.example.onedayclass.common.controller;

import com.example.onedayclass.member.dto.MemberDto;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@Slf4j
@ControllerAdvice
public class GlobalControllerAdvice {

    @ModelAttribute("loginMember")
    public MemberDto loginMember(HttpServletRequest request) {
        Object member = request.getAttribute("loginMember");
        return member instanceof MemberDto memberDto ? memberDto : null;
    }

    @ExceptionHandler({
            IllegalArgumentException.class,
            IllegalStateException.class,
            BindException.class,
            MethodArgumentNotValidException.class,
            MissingServletRequestParameterException.class,
            HttpRequestMethodNotSupportedException.class
    })
    public String handleBadRequest(Exception exception,
                                   HttpServletRequest request,
                                   RedirectAttributes redirectAttributes) {
        log.warn("Handled bad request on {} {}", request.getMethod(), request.getRequestURI(), exception);
        redirectAttributes.addFlashAttribute("message", resolveUserMessage(exception));
        return "redirect:" + resolveRedirectPath(request);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public String handleAccessDenied(AccessDeniedException exception,
                                     HttpServletRequest request,
                                     RedirectAttributes redirectAttributes) {
        log.warn("Access denied on {} {}", request.getMethod(), request.getRequestURI(), exception);
        redirectAttributes.addFlashAttribute("message", "해당 기능에 접근할 권한이 없습니다.");
        return "redirect:" + resolveRedirectPath(request);
    }

    @ExceptionHandler(NoResourceFoundException.class)
    public ModelAndView handleNotFound(NoResourceFoundException exception, HttpServletRequest request) {
        log.warn("Resource not found on {} {}", request.getMethod(), request.getRequestURI(), exception);
        ModelAndView modelAndView = new ModelAndView("error/common");
        modelAndView.setStatus(org.springframework.http.HttpStatus.NOT_FOUND);
        modelAndView.addObject("errorTitle", "페이지를 찾을 수 없습니다.");
        modelAndView.addObject("errorMessage", "요청하신 주소가 없거나 이동되었을 수 있습니다.");
        modelAndView.addObject("backUrl", resolveRedirectPath(request));
        return modelAndView;
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception exception, HttpServletRequest request) {
        log.error("Unhandled exception on {} {}", request.getMethod(), request.getRequestURI(), exception);
        ModelAndView modelAndView = new ModelAndView("error/common");
        modelAndView.setStatus(org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR);
        modelAndView.addObject("errorTitle", "요청을 처리하는 중 문제가 발생했습니다.");
        modelAndView.addObject("errorMessage", "잠시 후 다시 시도해 주세요. 문제가 계속되면 관리자에게 문의해 주세요.");
        modelAndView.addObject("backUrl", resolveRedirectPath(request));
        return modelAndView;
    }

    private String resolveUserMessage(Exception exception) {
        if (exception instanceof MissingServletRequestParameterException) {
            return "필수 요청 값이 누락되었습니다.";
        }
        if (exception instanceof HttpRequestMethodNotSupportedException) {
            return "지원하지 않는 요청 방식입니다.";
        }
        return "요청 값을 다시 확인해 주세요.";
    }

    private String resolveRedirectPath(HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        if (referer == null || referer.isBlank()) {
            return "/";
        }

        String contextPath = request.getContextPath();
        int hostIndex = referer.indexOf("://");
        if (hostIndex >= 0) {
            int pathStart = referer.indexOf('/', hostIndex + 3);
            if (pathStart >= 0) {
                referer = referer.substring(pathStart);
            }
        }

        if (contextPath != null && !contextPath.isEmpty() && referer.startsWith(contextPath)) {
            referer = referer.substring(contextPath.length());
        }

        if (referer.isBlank() || referer.startsWith("/members/login")) {
            return "/";
        }

        return referer;
    }
}
