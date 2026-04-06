package com.example.onedayclass.levelup.service.impl;

import com.example.onedayclass.common.paging.PageResult;
import com.example.onedayclass.common.paging.PagingUtils;
import com.example.onedayclass.levelup.dto.LevelUpDto;
import com.example.onedayclass.levelup.mapper.LevelUpMapper;
import com.example.onedayclass.levelup.service.LevelUpService;
import com.example.onedayclass.member.mapper.MemberMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LevelUpServiceImpl implements LevelUpService {

    private final LevelUpMapper levelUpMapper;
    private final MemberMapper memberMapper;

    public LevelUpServiceImpl(LevelUpMapper levelUpMapper, MemberMapper memberMapper) {
        this.levelUpMapper = levelUpMapper;
        this.memberMapper = memberMapper;
    }

    @Override
    public List<LevelUpDto> getRequests(String uId, boolean admin) {
        return levelUpMapper.findAll(uId, admin);
    }

    @Override
    public PageResult<LevelUpDto> getRequestsPage(String uId, boolean admin, int page, int pageSize) {
        return PagingUtils.slice(levelUpMapper.findAll(uId, admin), page, pageSize);
    }

    @Override
    public List<LevelUpDto> getPendingRequests() {
        return levelUpMapper.findPending();
    }

    @Override
    public LevelUpDto getRequest(int lvlNum) {
        return levelUpMapper.findById(lvlNum);
    }

    @Override
    public boolean createRequest(LevelUpDto levelUpDto) {
        Integer nextRef = levelUpMapper.findNextRef();
        levelUpDto.setLvlRef(nextRef == null ? 1 : nextRef);
        levelUpDto.setLvlPos(0);
        levelUpDto.setLvlDepth(0);
        if (levelUpDto.getLvlStatus() == null) {
            levelUpDto.setLvlStatus(1);
        }
        return levelUpMapper.insert(levelUpDto) > 0;
    }

    @Override
    public boolean updateRequest(LevelUpDto levelUpDto) {
        return levelUpMapper.update(levelUpDto) > 0;
    }

    @Override
    public boolean deleteRequest(int lvlNum) {
        return levelUpMapper.updateStatus(lvlNum, 3) > 0;
    }

    @Override
    @Transactional
    public boolean replyRequest(LevelUpDto levelUpDto) {
        levelUpMapper.updateReplyPositions(levelUpDto.getLvlRef(), levelUpDto.getLvlPos());
        levelUpDto.setLvlPos(levelUpDto.getLvlPos() + 1);
        levelUpDto.setLvlDepth(levelUpDto.getLvlDepth() + 1);
        return levelUpMapper.insert(levelUpDto) > 0;
    }

    @Override
    @Transactional
    public boolean approveRequest(int lvlNum) {
        LevelUpDto request = levelUpMapper.findById(lvlNum);
        if (request == null) {
            return false;
        }
        memberMapper.promoteToTeacher(request.getLvlUid(), request.getLvlName(), request.getLvlSns());
        return levelUpMapper.updateStatus(lvlNum, 2) > 0;
    }
}
