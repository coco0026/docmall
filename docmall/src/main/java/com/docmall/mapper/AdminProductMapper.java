package com.docmall.mapper;

import java.util.List;

import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface AdminProductMapper {

	//상품등록
	int productInsert(ProductVO vo);
	
	//상품list
	List<ProductVO> getProductList(Criteria cri);
	
	//상품총갯수
	int getProductTotalCount(Criteria cri);
	
	//상품코드로 GOODS_TBL SEL
	ProductVO getProductByCode(Integer gds_code);
	
	//상품수정
	int getProductModify(ProductVO vo);
	

	
}
