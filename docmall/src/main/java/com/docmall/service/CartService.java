package com.docmall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;

public interface CartService {

	//장바구니 담기
	void cart_add(CartVO vo);
	
	//장바구니 목록
	List<CartVOList> cart_list(String mbr_id);
	
	//장바구니 구매수량 변경
	void cartCntUpdate(Long cart_code, int cart_prchs_cnt);
	
	//장바구니 취소
	void cartDelete(Long cart_code);
	
	//장바구니 전체 취소
	void cartAllDelete(String mbr_id);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
