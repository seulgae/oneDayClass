package com.example.onedayclass.qna.service.impl;

import com.example.onedayclass.qna.dto.QnaDto;
import com.example.onedayclass.qna.mapper.QnaMapper;
import com.example.onedayclass.qna.service.QnaService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QnaServiceImpl implements QnaService {

    private final QnaMapper qnaMapper;

    public QnaServiceImpl(QnaMapper qnaMapper) {
        this.qnaMapper = qnaMapper;
    }

    @Override
    public List<QnaDto> getQuestions(String keyField, String keyword, String viewerId) {
        return qnaMapper.findAll(keyword, normalizeField(keyField), "admin".equals(viewerId));
    }

    @Override
    public List<QnaDto> getClassQuestions(int cNum, String keyField, String keyword) {
        return qnaMapper.findByClass(cNum, keyword, normalizeField(keyField));
    }

    @Override
    public QnaDto getQuestion(int qNum) {
        return qnaMapper.findById(qNum);
    }

    @Override
    public boolean createQuestion(QnaDto qnaDto) {
        Integer nextRef = qnaMapper.findNextRef();
        qnaDto.setQRef(nextRef == null ? 1 : nextRef);
        qnaDto.setQPos(0);
        qnaDto.setQDepth(0);
        if (qnaDto.getQStatus() == null) {
            qnaDto.setQStatus(1);
        }
        return qnaMapper.insert(qnaDto) > 0;
    }

    @Override
    public boolean updateQuestion(QnaDto qnaDto) {
        return qnaMapper.update(qnaDto) > 0;
    }

    @Override
    public boolean deleteQuestion(int qRef) {
        return qnaMapper.softDeleteThread(qRef) > 0;
    }

    @Override
    @Transactional
    public boolean replyQuestion(QnaDto qnaDto) {
        qnaMapper.updateReplyPositions(qnaDto.getQRef(), qnaDto.getQPos());
        qnaDto.setQPos(qnaDto.getQPos() + 1);
        qnaDto.setQDepth(qnaDto.getQDepth() + 1);
        return qnaMapper.insert(qnaDto) > 0;
    }

    private String normalizeField(String keyField) {
        if ("qUid".equals(keyField) || "qContent".equals(keyField)) {
            return keyField;
        }
        return "qTitle";
    }
}
