package com.example.onedayclass.levelup.service;

import com.example.onedayclass.levelup.dto.LevelUpDto;

import java.util.List;

public interface LevelUpService {
    List<LevelUpDto> getRequests(String uId, boolean admin);

    List<LevelUpDto> getPendingRequests();

    LevelUpDto getRequest(int lvlNum);

    boolean createRequest(LevelUpDto levelUpDto);

    boolean updateRequest(LevelUpDto levelUpDto);

    boolean deleteRequest(int lvlNum);

    boolean replyRequest(LevelUpDto levelUpDto);

    boolean approveRequest(int lvlNum);
}
