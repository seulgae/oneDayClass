package com.example.onedayclass.levelup.mapper;

import com.example.onedayclass.levelup.dto.LevelUpDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LevelUpMapper {
    List<LevelUpDto> findAll(@Param("uId") String uId, @Param("admin") boolean admin);

    List<LevelUpDto> findPending();

    LevelUpDto findById(int lvlNum);

    Integer findNextRef();

    int insert(LevelUpDto levelUpDto);

    int update(LevelUpDto levelUpDto);

    int updateStatus(@Param("lvlNum") int lvlNum, @Param("status") int status);

    int updateReplyPositions(@Param("lvlRef") int lvlRef, @Param("lvlPos") int lvlPos);
}
