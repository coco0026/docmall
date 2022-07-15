package com.docmall.service;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;

public interface MemberService {
	
	/* 회원가입 */
	void join(MemberVO vo);
	
	/* 아이디 중복확인 */
	String idCheck(String mbr_id);
	
	//휴대폰번호 중복확인
	String telNoCheck(String mbr_telno);
	
	//이메일 중복확인
		String mailCheck(String mbr_eml_addr);
	
	/* 로그인 */
	MemberVO login_ok(LoginDTO dto);
	
	
	/* 로그인시간 업데이트 */
	void login_date(String mbr_id);
	
	/* 아이디 찾기 */
	String searchID(String mbr_nm, String mbr_eml_addr);
	
	//임시 비밀번호 발급을 위한 확인작업
	String getIdEmailExists(String mbr_id, String mbr_eml_addr);
	
	//임시 비밀번호를 암호화하여 업데이트
	void changeImsiPW(String mbr_id, String enc_mbr_pw);
	
	//회원정보 업데이트
	void modify(MemberVO vo);
	

}
