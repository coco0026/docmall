package com.docmall.service;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;

public interface MemberService {
	
	/* 회원가입 */
	void join(MemberVO vo);
	
	/* 아이디 중복확인 */
	String idCheck(String mbr_id);
	
	/* 로그인 */
	MemberVO login_ok(LoginDTO dto);
	
	

}
