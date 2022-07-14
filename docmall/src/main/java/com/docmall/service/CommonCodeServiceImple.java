package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CommonCodeVO;
import com.docmall.mapper.CommonCodeMapper;

@Service
public class CommonCodeServiceImple implements CommonCodeService {
	
	@Autowired
	private CommonCodeMapper mapper;

	//자식코드로 자식테이블 정보
	@Override
	public CommonCodeVO commonCodeDetailSel(Long common_code_detail) {
		// TODO Auto-generated method stub
		return mapper.commonCodeDetailSel(common_code_detail);
	}

}
