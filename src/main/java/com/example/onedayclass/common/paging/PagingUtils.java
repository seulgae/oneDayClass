package com.example.onedayclass.common.paging;

import java.util.Collections;
import java.util.List;

public final class PagingUtils {

    private static final int PAGE_GROUP_SIZE = 5;

    private PagingUtils() {
    }

    public static <T> PageResult<T> slice(List<T> source, int requestedPage, int pageSize) {
        List<T> safeSource = source == null ? Collections.emptyList() : source;
        int safePageSize = Math.max(pageSize, 1);
        int totalItems = safeSource.size();
        int totalPages = Math.max((int) Math.ceil((double) totalItems / safePageSize), 1);
        int currentPage = Math.min(Math.max(requestedPage, 1), totalPages);
        int fromIndex = Math.min((currentPage - 1) * safePageSize, totalItems);
        int toIndex = Math.min(fromIndex + safePageSize, totalItems);
        List<T> items = fromIndex >= toIndex ? Collections.emptyList() : safeSource.subList(fromIndex, toIndex);

        int startPage = ((currentPage - 1) / PAGE_GROUP_SIZE) * PAGE_GROUP_SIZE + 1;
        int endPage = Math.min(startPage + PAGE_GROUP_SIZE - 1, totalPages);

        return new PageResult<>(
                items,
                currentPage,
                safePageSize,
                totalItems,
                totalPages,
                startPage,
                endPage,
                startPage > 1,
                endPage < totalPages
        );
    }
}
