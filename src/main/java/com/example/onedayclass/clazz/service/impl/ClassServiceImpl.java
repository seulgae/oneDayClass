package com.example.onedayclass.clazz.service.impl;

import com.example.onedayclass.clazz.dto.ClassDto;
import com.example.onedayclass.clazz.mapper.ClassMapper;
import com.example.onedayclass.clazz.service.ClassService;
import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ClassServiceImpl implements ClassService {

    private final ClassMapper classMapper;

    public ClassServiceImpl(ClassMapper classMapper) {
        this.classMapper = classMapper;
    }

    @Override
    public List<ClassDto> getClasses(String category, String onoff, boolean includeHidden) {
        return classMapper.findAll(category, onoff, includeHidden);
    }

    @Override
    public PageResult<ClassDto> getClassesPage(String category, String onoff, boolean includeHidden, int page, int pageSize) {
        return PagingUtils.slice(classMapper.findAll(category, onoff, includeHidden), page, pageSize);
    }

    @Override
    public List<ClassDto> getFeaturedClasses(String category, String onoff, int limit) {
        return classMapper.findFeatured(category, onoff, limit);
    }

    @Override
    public List<ClassDto> getPendingClasses() {
        return classMapper.findPending();
    }

    @Override
    public ClassDto getClass(int cNum) {
        return classMapper.findById(cNum);
    }

    @Override
    public boolean createClass(ClassDto classDto) {
        classDto.setCCode(UUID.randomUUID().toString());
        if (classDto.getCStatus() == null) {
            classDto.setCStatus(1);
        }
        if (classDto.getCApplyStu() == null) {
            classDto.setCApplyStu(0);
        }
        if (classDto.getCLikes() == null) {
            classDto.setCLikes(0);
        }
        return classMapper.insert(classDto) > 0;
    }

    @Override
    public boolean updateClass(ClassDto classDto) {
        return classMapper.update(classDto) > 0;
    }

    @Override
    public boolean approveClass(int cNum) {
        return classMapper.updateStatus(cNum, 2) > 0;
    }

    @Override
    public boolean deleteClass(int cNum) {
        return classMapper.updateStatus(cNum, 3) > 0;
    }

    @Override
    public boolean likeClass(String uId, int cNum) {
        if (classMapper.existsLike(uId, cNum)) {
            return false;
        }
        return classMapper.insertLike(uId, cNum) > 0 && classMapper.increaseLikes(cNum) > 0;
    }
}
