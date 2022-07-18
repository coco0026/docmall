package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.CommonCodeVO;

public interface CommonCodeMapper {

	
	//자식코드로 셀렉트
	CommonCodeVO commonCodeDetailSel(Long common_code_detail);
	
	//공통코드 카테고리
	List<CommonCodeVO> getCommonCode();
	
	//자식코드 카테고리
	List<CommonCodeVO> getSubCommonCode(Integer common_code);
}
