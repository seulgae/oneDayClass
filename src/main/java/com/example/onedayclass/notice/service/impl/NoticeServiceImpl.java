package com.example.onedayclass.notice.service.impl;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import com.example.onedayclass.notice.service.NoticeService;
import com.example.onedayclass.qna.dto.QnaDto;
import com.example.onedayclass.qna.mapper.QnaMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    private final QnaMapper qnaMapper;

    public NoticeServiceImpl(QnaMapper qnaMapper) {
        this.qnaMapper = qnaMapper;
    }

    @Override
    public List<QnaDto> getNotices() {
        return qnaMapper.findNotices();
    }

    @Override
    public PageResult<QnaDto> getNoticesPage(int page, int pageSize) {
        return PagingUtils.slice(qnaMapper.findNotices(), page, pageSize);
    }

    @Override
    public QnaDto getNotice(int qNum) {
        return qnaMapper.findNoticeById(qNum);
    }
}
