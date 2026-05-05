package com.example.onedayclass.qna.service.impl;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import com.example.onedayclass.qna.dto.QnaDto;
import com.example.onedayclass.qna.mapper.QnaMapper;
import com.example.onedayclass.qna.service.QnaService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QnaServiceImpl implements QnaService {

    private final QnaMapper qnaMapper;

    public QnaServiceImpl(QnaMapper qnaMapper) {
        this.qnaMapper = qnaMapper;
    }

    @Override
    public List<QnaDto> getQuestions(String keyField, String keyword, String viewerId) {
        return qnaMapper.findAll(keyword, normalizeField(keyField), isBoardManager(viewerId));
    }

    @Override
    public PageResult<QnaDto> getQuestionsPage(String keyField, String keyword, String viewerId, int page, int pageSize) {
        return PagingUtils.slice(
                qnaMapper.findAll(keyword, normalizeField(keyField), isBoardManager(viewerId)),
                page,
                pageSize
        );
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
    public QnaDto getRootQuestion(int qRef) {
        return qnaMapper.findRootByRef(qRef);
    }

    @Override
    public List<QnaDto> getReplies(int qRef) {
        return qnaMapper.findRepliesByRef(qRef);
    }

    @Override
    public boolean createQuestion(QnaDto qnaDto) {
        Integer nextRef = qnaMapper.findNextRef();
        qnaDto.setQRef(nextRef == null ? 1 : nextRef);
        qnaDto.setQPos(0);
        qnaDto.setQDepth(0);
        qnaDto.setParentQNum(null);
        qnaDto.setQOriUid(qnaDto.getQUid());
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
    public boolean deleteQuestion(int qNum) {
        QnaDto question = qnaMapper.findById(qNum);
        if (question == null) {
            return false;
        }
        if (question.getQDepth() != null && question.getQDepth() == 0) {
            return qnaMapper.softDeleteThread(question.getQRef()) > 0;
        }
        return qnaMapper.softDeleteOne(qNum) > 0;
    }

    @Override
    public boolean replyQuestion(QnaDto qnaDto) {
        QnaDto parent = qnaMapper.findById(qnaDto.getParentQNum());
        if (parent == null) {
            return false;
        }

        QnaDto root = parent.getQDepth() != null && parent.getQDepth() == 0
                ? parent
                : qnaMapper.findRootByRef(parent.getQRef());
        if (root == null) {
            return false;
        }

        Integer maxPos = qnaMapper.findMaxPosByRef(root.getQRef());
        qnaDto.setQRef(root.getQRef());
        qnaDto.setQPos(maxPos == null ? 1 : maxPos + 1);
        qnaDto.setQDepth(Math.min((parent.getQDepth() == null ? 0 : parent.getQDepth()) + 1, 2));
        qnaDto.setQOriUid(parent.getQUid());
        qnaDto.setCNum(root.getCNum());
        qnaDto.setQCategory(root.getQCategory());
        if (qnaDto.getQStatus() == null) {
            qnaDto.setQStatus(1);
        }
        return qnaMapper.insert(qnaDto) > 0;
    }

    private String normalizeField(String keyField) {
        if (keyField == null) {
            return "qnaBBS.qTitle";
        }
        return switch (keyField) {
            case "qUid" -> "qnaBBS.qUid";
            case "qContent" -> "qnaBBS.qContent";
            case "qCategory" -> "qnaBBS.qCategory";
            case "cTitle" -> "classBBS.cTitle";
            default -> "qnaBBS.qTitle";
        };
    }

    private boolean isBoardManager(String viewerLevel) {
        return "3".equals(viewerLevel) || "4".equals(viewerLevel);
    }
}
