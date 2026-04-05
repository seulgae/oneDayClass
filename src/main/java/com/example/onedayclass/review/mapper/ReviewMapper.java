package com.example.onedayclass.review.mapper;

import com.example.onedayclass.review.dto.ReviewDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReviewMapper {
    List<ReviewDto> findAll(@Param("includeDeleted") boolean includeDeleted);

    List<ReviewDto> findByClass(int cNum);

    List<ReviewDto> findRecent(int limit);

    ReviewDto findById(int rNum);

    int insert(ReviewDto reviewDto);

    int update(ReviewDto reviewDto);

    int increaseReadCount(int rNum);

    int updateStatus(@Param("rNum") int rNum, @Param("status") int status);

    boolean existsLike(@Param("uId") String uId, @Param("rNum") int rNum);

    int insertLike(@Param("uId") String uId, @Param("rNum") int rNum);

    int increaseLikes(int rNum);
}
