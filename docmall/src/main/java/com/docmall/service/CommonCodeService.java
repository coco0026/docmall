package com.docmall.service;

import com.docmall.domain.CommonCodeVO;

public interface CommonCodeService {
	
	//자식코드로 셀렉트
	CommonCodeVO commonCodeDetailSel(Long common_code_detail);

}
