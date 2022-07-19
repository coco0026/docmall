package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CommonCodeVO;
import com.docmall.mapper.CommonCodeMapper;

@Service
public class CommonCodeServiceImple implements CommonCodeService {
	
	@Autowired
	private CommonCodeMapper mapper;


	@Override
	public List<CommonCodeVO> getCommonCode() {
		// TODO Auto-generated method stub
		return mapper.getCommonCode();
	}

	@Override
	public List<CommonCodeVO> getSubCommonCode(String common_code) {
		// TODO Auto-generated method stub
		return mapper.getSubCommonCode(common_code);
	}

}
