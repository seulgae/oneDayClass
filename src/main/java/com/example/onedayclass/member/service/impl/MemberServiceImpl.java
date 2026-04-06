package com.example.onedayclass.member.service.impl;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.mapper.MemberMapper;
import com.example.onedayclass.member.service.MemberService;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public boolean checkId(String uId) {
        return memberMapper.existsById(uId);
    }

    @Override
    public boolean register(MemberDto memberDto) {
        String userLevel = "2".equals(memberDto.getULevel()) ? "2" : "1";
        memberDto.setULevel(userLevel);
        if (!"2".equals(userLevel)) {
            memberDto.setSName(null);
            memberDto.setSSns(null);
        }
        return memberMapper.insert(memberDto) > 0;
    }

    @Override
    public MemberDto login(String uId, String uPw) {
        return memberMapper.login(uId, uPw);
    }

    @Override
    public MemberDto getMember(String uId) {
        return memberMapper.findById(uId);
    }

    @Override
    public boolean update(MemberDto memberDto) {
        return memberMapper.update(memberDto) > 0;
    }

    @Override
    public boolean delete(String uId) {
        return memberMapper.delete(uId) > 0;
    }
}
