package com.docmall.mapper;

import com.docmall.domain.CommonCodeVO;

public interface CommonCodeMapper {

	
	//자식코드로 셀렉트
	CommonCodeVO commonCodeDetailSel(Long common_code_detail);
}
