package com.docmall.mapper;

import com.docmall.domain.CartVO;

public interface CartMapper {
	
	//장바구니 담기
	void cart_add(CartVO vo);

}
