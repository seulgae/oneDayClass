package com.example.onedayclass.notice.service;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.qna.dto.QnaDto;

import java.util.List;

public interface NoticeService {
    List<QnaDto> getNotices();

    PageResult<QnaDto> getNoticesPage(int page, int pageSize);

    QnaDto getNotice(int qNum);
}
