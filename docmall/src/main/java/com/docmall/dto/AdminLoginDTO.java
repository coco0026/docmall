package com.docmall.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data 
@AllArgsConstructor //모든 파라미터를 이용한 생성자메서드 생성
public class AdminLoginDTO {

	private String mngr_id; //아이디
	private String mngr_pw; //비밀번호

}
