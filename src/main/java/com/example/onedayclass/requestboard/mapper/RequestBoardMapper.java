package com.example.onedayclass.requestboard.mapper;

import com.example.onedayclass.requestboard.dto.RequestBoardDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RequestBoardMapper {
    List<RequestBoardDto> findAll(@Param("keyword") String keyword,
                                  @Param("keyField") String keyField,
                                  @Param("includeDeleted") boolean includeDeleted);

    RequestBoardDto findById(int reqNum);

    RequestBoardDto findRootByRef(int reqRef);

    List<RequestBoardDto> findRepliesByRef(int reqRef);

    Integer findNextRef();

    Integer findMaxPosByRef(int reqRef);

    int insert(RequestBoardDto requestBoardDto);

    int update(RequestBoardDto requestBoardDto);

    int softDeleteThread(int reqRef);

    int softDeleteOne(int reqNum);
}
