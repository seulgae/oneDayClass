package com.example.onedayclass.member.mapper;

import com.example.onedayclass.member.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {
    boolean existsById(String uId);

    int insert(MemberDto memberDto);

    MemberDto login(@Param("uId") String uId, @Param("uPw") String uPw);

    MemberDto findById(String uId);

    int update(MemberDto memberDto);

    int delete(String uId);

    int promoteToTeacher(@Param("uId") String uId, @Param("sName") String sName, @Param("sSns") String sSns);
}
