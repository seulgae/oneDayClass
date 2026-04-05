package com.example.onedayclass.member.service;

import com.example.onedayclass.member.dto.MemberDto;

public interface MemberService {
    boolean checkId(String uId);

    boolean register(MemberDto memberDto);

    MemberDto login(String uId, String uPw);

    MemberDto getMember(String uId);

    boolean update(MemberDto memberDto);

    boolean delete(String uId);
}
