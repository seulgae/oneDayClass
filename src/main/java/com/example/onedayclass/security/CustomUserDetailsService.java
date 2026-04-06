package com.example.onedayclass.security;

import com.example.onedayclass.member.dto.MemberDto;
import com.example.onedayclass.member.service.MemberService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberService memberService;

    public CustomUserDetailsService(MemberService memberService) {
        this.memberService = memberService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberDto member = memberService.getMember(username);
        if (member == null) {
            throw new UsernameNotFoundException(username);
        }
        return new MemberPrincipal(member);
    }
}
