package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	
	//MEMBER_TBL
	private String mbr_id; //아이디
	private String mbr_nm; //이름
	private String mbr_pw; //비밀번호
	private String mbr_zip; //우편번호
	private String mbr_addr; //기본주소
	private String mbr_daddr; //상세주소
	private String mbr_telno; //휴대폰번호
	private String mbr_eml_addr; //이메일
	private String mbr_eml_addr_yn; //메일 수신여부
	private Date mbr_reg_date; //가입일
	private Date mbr_update_date; //수정일
	private Date mbr_cntn_date; //최근 접속시간(로그인시간)
	
	//MEMBER_DETAIL_TBL
	private int mbr_point_ny; //적립금
	private Long mbr_grade_code; //회원등급
	private int mbr_accumulate_my; //누적금액
	
	//프로시저 에러 OUT변수
	private String p_errcode; //에러코드
	private String p_errmsg;  //에러명
	
}
