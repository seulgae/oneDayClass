package com.example.onedayclass.review.service.impl;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import com.example.onedayclass.review.dto.ReviewDto;
import com.example.onedayclass.review.mapper.ReviewMapper;
import com.example.onedayclass.review.service.ReviewService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;

    public ReviewServiceImpl(ReviewMapper reviewMapper) {
        this.reviewMapper = reviewMapper;
    }

    @Override
    public List<ReviewDto> getReviews(String viewerId) {
        return reviewMapper.findAll("admin".equals(viewerId));
    }

    @Override
    public PageResult<ReviewDto> getReviewsPage(String viewerId, int page, int pageSize) {
        return PagingUtils.slice(reviewMapper.findAll("admin".equals(viewerId)), page, pageSize);
    }

    @Override
    public List<ReviewDto> getClassReviews(int cNum, String viewerId) {
        return reviewMapper.findByClass(cNum);
    }

    @Override
    public List<ReviewDto> getRecentReviews(int limit) {
        return reviewMapper.findRecent(limit);
    }

    @Override
    @Transactional
    public ReviewDto getReview(int rNum, boolean increaseCount) {
        if (increaseCount) {
            reviewMapper.increaseReadCount(rNum);
        }
        return reviewMapper.findById(rNum);
    }

    @Override
    public boolean createReview(ReviewDto reviewDto) {
        if (reviewDto.getRStatus() == null) {
            reviewDto.setRStatus(2);
        }
        return reviewMapper.insert(reviewDto) > 0;
    }

    @Override
    public boolean updateReview(ReviewDto reviewDto) {
        return reviewMapper.update(reviewDto) > 0;
    }

    @Override
    public boolean deleteReview(int rNum) {
        return reviewMapper.updateStatus(rNum, 3) > 0;
    }

    @Override
    @Transactional
    public boolean likeReview(String uId, int rNum) {
        if (reviewMapper.existsLike(uId, rNum)) {
            return false;
        }
        return reviewMapper.insertLike(uId, rNum) > 0 && reviewMapper.increaseLikes(rNum) > 0;
    }
}
