package com.example.onedayclass.security;

import com.example.onedayclass.member.dto.MemberDto;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class MemberPrincipal implements UserDetails {

    private final MemberDto member;

    public MemberPrincipal(MemberDto member) {
        this.member = member;
    }

    public MemberDto getMember() {
        return member;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        if ("2".equals(member.getULevel()) || "3".equals(member.getULevel())) {
            authorities.add(new SimpleGrantedAuthority("ROLE_TEACHER"));
        }
        if ("3".equals(member.getULevel())) {
            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        }
        return authorities;
    }

    @Override
    public String getPassword() {
        return member.getUPw();
    }

    @Override
    public String getUsername() {
        return member.getUId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
