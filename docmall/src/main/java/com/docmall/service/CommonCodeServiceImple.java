package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CommonCodeVO;
import com.docmall.mapper.CommonCodeMapper;

@Service
public class CommonCodeServiceImple implements CommonCodeService {
	
	@Autowired
	private CommonCodeMapper mapper;

	@Override
	public CommonCodeVO commonCodeChildSel(Long common_code) {
		// TODO Auto-generated method stub
		return mapper.commonCodeChildSel(common_code);
	}

}
