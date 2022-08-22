package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.CommonCodeVO;

public interface CommonCodeMapper {

	//공통코드 카테고리
	List<CommonCodeVO> getCommonCode();
	
	//자식코드 카테고리
	List<CommonCodeVO> getSubCommonCode(String common_code);
	
	List<CommonCodeVO> getSubCommonCodeTmp(String tmp);
	
}
