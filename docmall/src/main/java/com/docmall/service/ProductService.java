package com.docmall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;

public interface ProductService {
	
	//상품리스트
	List<ProductVO> getProductListBySubCategory(@Param("cate_code_child") String cate_code_child, @Param("cri") Criteria cri);
		
	//갯수
	int getProductTotalCountBySubCategory(@Param("cate_code_child") String cate_code_child, @Param("cri") Criteria cri);
	
	//상품코드로 GOODS_TBL SEL
	ProductVO getProductByCode(Integer gds_code);

}
