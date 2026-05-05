package com.example.onedayclass.notice.service.impl;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import com.example.onedayclass.notice.service.NoticeService;
import com.example.onedayclass.qna.dto.QnaDto;
import com.example.onedayclass.qna.mapper.QnaMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Override
    public boolean createNotice(QnaDto noticeDto) {
        noticeDto.setQTitle(normalizeTitle(noticeDto.getQTitle()));
        noticeDto.setQDepth(0);
        noticeDto.setQPos(0);
        noticeDto.setQStatus(1);
        noticeDto.setQCategory("공지");
        noticeDto.setCNum(null);
        noticeDto.setParentQNum(null);
        noticeDto.setQOriUid(noticeDto.getQUid());
        noticeDto.setQRef(qnaMapper.findNextRef());
        return qnaMapper.insert(noticeDto) > 0;
    }

    @Override
    public boolean updateNotice(QnaDto noticeDto) {
        QnaDto source = qnaMapper.findNoticeById(noticeDto.getQNum());
        if (source == null) {
            return false;
        }
        source.setQTitle(normalizeTitle(noticeDto.getQTitle()));
        source.setQContent(noticeDto.getQContent());
        source.setQStatus(1);
        source.setQCategory("공지");
        source.setQUid(source.getQUid());
        source.setUpdatedBy(noticeDto.getUpdatedBy());
        return qnaMapper.update(source) > 0;
    }

    @Override
    @Transactional
    public boolean deleteNotice(int qNum) {
        QnaDto source = qnaMapper.findNoticeById(qNum);
        if (source == null) {
            return false;
        }
        return qnaMapper.softDeleteOne(qNum) > 0;
    }

    private String normalizeTitle(String title) {
        String trimmed = title == null ? "" : title.trim();
        return trimmed.startsWith("[공지]") ? trimmed : "[공지] " + trimmed;
    }
}
