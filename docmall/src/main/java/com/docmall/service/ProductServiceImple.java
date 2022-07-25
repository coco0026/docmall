package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.MemberMapper;
import com.docmall.mapper.ProductMapper;

@Service
public class ProductServiceImple implements ProductService {
	
	@Autowired
	private ProductMapper mapper;


	@Override
	public List<ProductVO> getProductListBySubCategory(String common_code_child, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getProductListBySubCategory(common_code_child, cri);
	}

	@Override
	public int getProductTotalCountBySubCategory(String cate_code_child, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getProductTotalCountBySubCategory(cate_code_child, cri);
	}

}
