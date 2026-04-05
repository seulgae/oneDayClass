package com.example.onedayclass.review.service;

import com.example.onedayclass.review.dto.ReviewDto;

import java.util.List;

public interface ReviewService {
    List<ReviewDto> getReviews(String viewerId);

    List<ReviewDto> getClassReviews(int cNum, String viewerId);

    List<ReviewDto> getRecentReviews(int limit);

    ReviewDto getReview(int rNum, boolean increaseCount);

    boolean createReview(ReviewDto reviewDto);

    boolean updateReview(ReviewDto reviewDto);

    boolean deleteReview(int rNum);

    boolean likeReview(String uId, int rNum);
}
