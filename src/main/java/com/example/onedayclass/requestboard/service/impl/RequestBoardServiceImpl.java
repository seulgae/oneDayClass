package com.example.onedayclass.requestboard.service.impl;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import com.example.onedayclass.requestboard.dto.RequestBoardDto;
import com.example.onedayclass.requestboard.mapper.RequestBoardMapper;
import com.example.onedayclass.requestboard.service.RequestBoardService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RequestBoardServiceImpl implements RequestBoardService {

    private final RequestBoardMapper requestBoardMapper;

    public RequestBoardServiceImpl(RequestBoardMapper requestBoardMapper) {
        this.requestBoardMapper = requestBoardMapper;
    }

    @Override
    public List<RequestBoardDto> getRequests(String keyField, String keyword, String viewerId) {
        return requestBoardMapper.findAll(keyword, normalizeField(keyField), isBoardManager(viewerId));
    }

    @Override
    public PageResult<RequestBoardDto> getRequestsPage(String keyField, String keyword, String viewerId, int page, int pageSize) {
        return PagingUtils.slice(
                requestBoardMapper.findAll(keyword, normalizeField(keyField), isBoardManager(viewerId)),
                page,
                pageSize
        );
    }

    @Override
    public RequestBoardDto getRequest(int reqNum) {
        return requestBoardMapper.findById(reqNum);
    }

    @Override
    public RequestBoardDto getRootRequest(int reqRef) {
        return requestBoardMapper.findRootByRef(reqRef);
    }

    @Override
    public List<RequestBoardDto> getReplies(int reqRef) {
        return requestBoardMapper.findRepliesByRef(reqRef);
    }

    @Override
    public boolean createRequest(RequestBoardDto requestBoardDto) {
        Integer nextRef = requestBoardMapper.findNextRef();
        requestBoardDto.setReqRef(nextRef == null ? 1 : nextRef);
        requestBoardDto.setReqPos(0);
        requestBoardDto.setReqDepth(0);
        requestBoardDto.setParentReqNum(null);
        if (requestBoardDto.getReqStatus() == null) {
            requestBoardDto.setReqStatus(1);
        }
        return requestBoardMapper.insert(requestBoardDto) > 0;
    }

    @Override
    public boolean updateRequest(RequestBoardDto requestBoardDto) {
        return requestBoardMapper.update(requestBoardDto) > 0;
    }

    @Override
    public boolean deleteRequest(int reqNum) {
        RequestBoardDto request = requestBoardMapper.findById(reqNum);
        if (request == null) {
            return false;
        }
        if (request.getReqDepth() != null && request.getReqDepth() == 0) {
            return requestBoardMapper.softDeleteThread(request.getReqRef()) > 0;
        }
        return requestBoardMapper.softDeleteOne(reqNum) > 0;
    }

    @Override
    public boolean replyRequest(RequestBoardDto requestBoardDto) {
        RequestBoardDto parent = requestBoardMapper.findById(requestBoardDto.getParentReqNum());
        if (parent == null) {
            return false;
        }

        RequestBoardDto root = parent.getReqDepth() != null && parent.getReqDepth() == 0
                ? parent
                : requestBoardMapper.findRootByRef(parent.getReqRef());
        if (root == null) {
            return false;
        }

        Integer maxPos = requestBoardMapper.findMaxPosByRef(root.getReqRef());
        requestBoardDto.setReqRef(root.getReqRef());
        requestBoardDto.setReqPos(maxPos == null ? 1 : maxPos + 1);
        requestBoardDto.setReqDepth(Math.min((parent.getReqDepth() == null ? 0 : parent.getReqDepth()) + 1, 2));
        requestBoardDto.setReqOriUid(parent.getReqUid());
        if (requestBoardDto.getReqStatus() == null) {
            requestBoardDto.setReqStatus(1);
        }
        return requestBoardMapper.insert(requestBoardDto) > 0;
    }

    private String normalizeField(String keyField) {
        if ("reqUid".equals(keyField) || "reqContent".equals(keyField)) {
            return keyField;
        }
        return "reqTitle";
    }

    private boolean isBoardManager(String viewerLevel) {
        return "3".equals(viewerLevel) || "4".equals(viewerLevel);
    }
}
