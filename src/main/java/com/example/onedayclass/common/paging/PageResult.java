package com.example.onedayclass.common.paging;

import java.util.List;

public class PageResult<T> {

    private final List<T> items;
    private final int currentPage;
    private final int pageSize;
    private final int totalItems;
    private final int totalPages;
    private final int startPage;
    private final int endPage;
    private final boolean hasPrevious;
    private final boolean hasNext;

    public PageResult(List<T> items,
                      int currentPage,
                      int pageSize,
                      int totalItems,
                      int totalPages,
                      int startPage,
                      int endPage,
                      boolean hasPrevious,
                      boolean hasNext) {
        this.items = items;
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalItems = totalItems;
        this.totalPages = totalPages;
        this.startPage = startPage;
        this.endPage = endPage;
        this.hasPrevious = hasPrevious;
        this.hasNext = hasNext;
    }

    public List<T> getItems() {
        return items;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public int getStartPage() {
        return startPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public boolean isHasPrevious() {
        return hasPrevious;
    }

    public boolean isHasNext() {
        return hasNext;
    }
}
