package com.docmall.domain;

import lombok.Data;

@Data
public class CommonCodeVO {

	private Long common_code; //그룹코드(부모코드)
	private Long common_code_child; //자식코드
	private String common_code_nm; //코드명
	
}