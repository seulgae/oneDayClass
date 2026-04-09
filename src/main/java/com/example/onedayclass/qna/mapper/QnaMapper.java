package com.example.onedayclass.qna.mapper;

import com.example.onedayclass.qna.dto.QnaDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface QnaMapper {
    List<QnaDto> findAll(@Param("keyword") String keyword, @Param("keyField") String keyField, @Param("includeDeleted") boolean includeDeleted);

    List<QnaDto> findByClass(@Param("cNum") int cNum, @Param("keyword") String keyword, @Param("keyField") String keyField);

    QnaDto findById(int qNum);

    QnaDto findRootByRef(int qRef);

    List<QnaDto> findRepliesByRef(int qRef);

    Integer findNextRef();

    Integer findMaxPosByRef(int qRef);

    int insert(QnaDto qnaDto);

    int update(QnaDto qnaDto);

    int softDeleteThread(int qRef);

    int softDeleteOne(int qNum);
}
