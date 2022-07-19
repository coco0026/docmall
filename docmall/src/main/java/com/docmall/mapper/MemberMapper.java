package com.docmall.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;

public interface MemberMapper {
	
	//회원가입
	void join(MemberVO vo);
	
	//아이디중복 확인
	String idCheck(String mbr_id);
	
	//휴대폰 번호 중복확인
	String telNoCheck(String mbr_telno);
	
	//이메일 중복확인
	String mailCheck(String mbr_eml_addr);
	
	//로그인
	MemberVO login_ok(LoginDTO dto);
	
	//로그인 시간 업데이트
	void login_date(String mbr_id);
	
	//mapper인터페이스의 메서드가 파라미터가 2개 이상인 경우에는 @Param 사용
	//아이디 찾기
	String searchID(@Param("mbr_nm") String mbr_nm, @Param("mbr_eml_addr") String mbr_eml_addr); 
	
	//임시 비밀번호 발급을 위한 확인작업
	String getIdEmailExists(@Param("mbr_id") String mbr_id, @Param("mbr_eml_addr") String mbr_eml_addr);
	
	//임시 비밀번호를 암호화하여 업데이트
	void changeImsiPW(@Param("mbr_id") String mbr_id, @Param("enc_mbr_pw") String enc_mbr_pw);
	
	//회원정보 수정하기
	Boolean modify(MemberVO vo);
	
	
}
