package com.docmall.mapper;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;

public interface MemberMapper {
	
	//회원가입
	void join(MemberVO vo);
	
	//아이디중복 확인
	String idCheck(String mbr_id);
	
	//로그인
	MemberVO login_ok(LoginDTO dto);

}
