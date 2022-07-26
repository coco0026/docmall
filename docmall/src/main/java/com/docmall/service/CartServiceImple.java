package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CartVO;
import com.docmall.mapper.CartMapper;

@Service
public class CartServiceImple implements CartService {
	
	@Autowired
	private CartMapper mapper;

	@Override
	public void cart_add(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.cart_add(vo);
	}

}
