package com.docmall.domain;

import lombok.Data;

@Data
public class CommonCodeVO {

	private String common_code; //그룹코드(부모코드)
	private String common_code_child; //자식코드
	private String common_code_nm; //코드명
	private String common_code_child_nm; //코드명
	private String common_code_child_use_yn; //코드사용여부
	private String common_code_use_yn; //코드사용여부
	
}
