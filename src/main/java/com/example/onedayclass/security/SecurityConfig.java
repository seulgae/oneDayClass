package com.example.onedayclass.security;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.service.MemberService;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpSession;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new LegacyAwarePasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http,
                                                   UserDetailsService userDetailsService,
                                                   AuthenticationSuccessHandler authenticationSuccessHandler,
                                                   AuthenticationFailureHandler authenticationFailureHandler) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()))
                .userDetailsService(userDetailsService)
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
                        .requestMatchers("/", "/error", "/css/**", "/uploads/**", "/h2-console/**").permitAll()
                        .requestMatchers("/members/login", "/members/join", "/members/logout").permitAll()
                        .requestMatchers(HttpMethod.GET, "/classes", "/classes/*", "/reviews", "/reviews/*", "/notices", "/notices/*", "/qna", "/qna/*", "/levelups", "/levelups/*", "/requests", "/requests/*").permitAll()
                        .requestMatchers(HttpMethod.POST, "/classes/*/like", "/reviews/*/like").authenticated()
                        .requestMatchers(HttpMethod.POST, "/reviews", "/reviews/*/delete", "/qna", "/qna/*/reply", "/qna/*/delete", "/levelups", "/levelups/*/reply", "/levelups/*/delete", "/requests", "/requests/*/reply", "/requests/*/delete").authenticated()
                        .requestMatchers(HttpMethod.POST, "/members/edit", "/members/delete").authenticated()
                        .requestMatchers(HttpMethod.GET, "/members/mypage", "/members/edit").authenticated()
                        .requestMatchers("/payments/**").authenticated()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.POST, "/admin/classes/*/approve").hasRole("ADMIN")
                        .requestMatchers("/classes/new", "/classes/*/edit", "/classes/*/delete").hasAnyRole("TEACHER", "ADMIN")
                        .requestMatchers(HttpMethod.POST, "/classes", "/classes/*/edit", "/classes/*/delete").hasAnyRole("TEACHER", "ADMIN")
                        .requestMatchers("/levelups/*/approve").hasRole("ADMIN")
                        .requestMatchers(HttpMethod.GET, "/reviews/new", "/qna/new", "/levelups/new", "/requests/new").authenticated()
                        .requestMatchers(HttpMethod.GET, "/qna/*/reply", "/levelups/*/reply", "/requests/*/reply").authenticated()
                        .anyRequest().denyAll()
                )
                .formLogin(form -> form
                        .loginPage("/members/login")
                        .loginProcessingUrl("/members/login")
                        .usernameParameter("uId")
                        .passwordParameter("uPw")
                        .successHandler(authenticationSuccessHandler)
                        .failureHandler(authenticationFailureHandler)
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/members/logout", "GET"))
                        .logoutSuccessUrl("/")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                );

        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler(MemberService memberService) {
        return (request, response, authentication) -> {
            HttpSession session = request.getSession();
            MemberDto member = memberService.getMember(authentication.getName());
            session.setAttribute("loginMember", member);
            response.sendRedirect("/");
        };
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return (request, response, exception) -> response.sendRedirect("/members/login?error");
    }
}
