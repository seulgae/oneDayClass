package com.example.onedayclass.clazz.service;

import com.example.onedayclass.clazz.dto.ClassDto;
import com.example.onedayclass.common.paging.PageResult;

import java.util.List;

public interface ClassService {
    List<ClassDto> getClasses(String keyField, String keyword, String onoff, boolean includeHidden);

    PageResult<ClassDto> getClassesPage(String keyField, String keyword, String onoff, boolean includeHidden, int page, int pageSize);

    List<ClassDto> getFeaturedClasses(String keyField, String keyword, String onoff, int limit);

    List<ClassDto> getPendingClasses();

    ClassDto getClass(int cNum);

    boolean createClass(ClassDto classDto);

    boolean updateClass(ClassDto classDto);

    boolean approveClass(int cNum);

    boolean deleteClass(int cNum);

    boolean likeClass(String uId, int cNum);
}
