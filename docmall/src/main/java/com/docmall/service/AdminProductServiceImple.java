package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.AdminProductMapper;

import lombok.extern.log4j.Log4j;

@Service
public class AdminProductServiceImple implements AdminProductService {
	
	@Autowired
	AdminProductMapper mapper;
	
	@Override
	public int productInsert(ProductVO vo) {
		// TODO Auto-generated method stub
		return mapper.productInsert(vo);
	}

	@Override
	public List<ProductVO> getProductList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getProductList(cri);
	}

	@Override
	public int getProductTotalCount(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getProductTotalCount(cri);
	}

}
