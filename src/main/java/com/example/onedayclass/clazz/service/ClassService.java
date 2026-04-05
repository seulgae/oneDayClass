package com.example.onedayclass.clazz.service;

import com.example.onedayclass.clazz.dto.ClassDto;

import java.util.List;

public interface ClassService {
    List<ClassDto> getClasses(String category, String onoff, boolean includeHidden);

    List<ClassDto> getFeaturedClasses(String category, String onoff, int limit);

    List<ClassDto> getPendingClasses();

    ClassDto getClass(int cNum);

    boolean createClass(ClassDto classDto);

    boolean updateClass(ClassDto classDto);

    boolean approveClass(int cNum);

    boolean deleteClass(int cNum);

    boolean likeClass(String uId, int cNum);
}
