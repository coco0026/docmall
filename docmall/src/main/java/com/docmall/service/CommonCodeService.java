package com.docmall.service;

import java.util.List;

import com.docmall.domain.CommonCodeVO;

public interface CommonCodeService {
	
	//자식코드로 셀렉트
	CommonCodeVO commonCodeDetailSel(Long common_code_detail);
	
	//그룹코드
	List<CommonCodeVO> getCommonCode();
	
	//자식코드
	List<CommonCodeVO> getSubCommonCode(Integer common_code);

}
