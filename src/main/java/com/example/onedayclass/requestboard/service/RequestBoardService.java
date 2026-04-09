package com.example.onedayclass.requestboard.service;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.requestboard.dto.RequestBoardDto;

import java.util.List;

public interface RequestBoardService {
    List<RequestBoardDto> getRequests(String keyField, String keyword, String viewerId);

    PageResult<RequestBoardDto> getRequestsPage(String keyField, String keyword, String viewerId, int page, int pageSize);

    RequestBoardDto getRequest(int reqNum);

    RequestBoardDto getRootRequest(int reqRef);

    List<RequestBoardDto> getReplies(int reqRef);

    boolean createRequest(RequestBoardDto requestBoardDto);

    boolean updateRequest(RequestBoardDto requestBoardDto);

    boolean deleteRequest(int reqNum);

    boolean replyRequest(RequestBoardDto requestBoardDto);
}
