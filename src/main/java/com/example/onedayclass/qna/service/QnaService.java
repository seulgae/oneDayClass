package com.example.onedayclass.qna.service;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.qna.dto.QnaDto;

import java.util.List;

public interface QnaService {
    List<QnaDto> getQuestions(String keyField, String keyword, String viewerId);

    PageResult<QnaDto> getQuestionsPage(String keyField, String keyword, String viewerId, int page, int pageSize);

    List<QnaDto> getClassQuestions(int cNum, String keyField, String keyword);

    QnaDto getQuestion(int qNum);

    QnaDto getRootQuestion(int qRef);

    List<QnaDto> getReplies(int qRef);

    boolean createQuestion(QnaDto qnaDto);

    boolean updateQuestion(QnaDto qnaDto);

    boolean deleteQuestion(int qNum);

    boolean replyQuestion(QnaDto qnaDto);
}
