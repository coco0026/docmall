package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {

	
	private String mngr_id; //관리자 아이디
	private String mngr_pw; //관리자 비번
	private String mngr_nm; //관리자 이름
	private Date mngr_cntn_date; //접속시간
	
}
