package com.docmall.service;

import java.util.List;

import com.docmall.domain.CommonCodeVO;

public interface CommonCodeService {
	
	//그룹코드
	List<CommonCodeVO> getCommonCode();
	
	//자식코드
	List<CommonCodeVO> getSubCommonCode(String common_code);
	
	List<CommonCodeVO> getSubCommonCodeTmp(String tmp);

}
