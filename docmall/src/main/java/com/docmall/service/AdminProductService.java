package com.docmall.service;

import java.util.List;

import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface AdminProductService {
	
	//상품등록
	int productInsert(ProductVO vo);
	
	//상품list
	List<ProductVO> getProductList(Criteria cri);
	
	//상품총갯수
	int getProductTotalCount(Criteria cri);

}
