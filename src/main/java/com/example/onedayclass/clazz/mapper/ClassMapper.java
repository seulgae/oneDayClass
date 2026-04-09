package com.example.onedayclass.clazz.mapper;

import com.example.onedayclass.clazz.dto.ClassDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ClassMapper {
    List<ClassDto> findAll(@Param("keyword") String keyword,
                           @Param("keyField") String keyField,
                           @Param("onoff") String onoff,
                           @Param("includeHidden") boolean includeHidden);

    List<ClassDto> findFeatured(@Param("keyword") String keyword,
                                @Param("keyField") String keyField,
                                @Param("onoff") String onoff,
                                @Param("limit") int limit);

    List<ClassDto> findPending();

    ClassDto findById(int cNum);

    int insert(ClassDto classDto);

    int update(ClassDto classDto);

    int updateStatus(@Param("cNum") int cNum, @Param("status") int status);

    int increaseLikes(int cNum);

    boolean existsLike(@Param("uId") String uId, @Param("cNum") int cNum);

    int insertLike(@Param("uId") String uId, @Param("cNum") int cNum);

    int increaseApplyStu(@Param("cNum") int cNum, @Param("amount") int amount);
}
