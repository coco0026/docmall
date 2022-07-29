package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;
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

	@Override
	public List<CartVOList> cart_list(String mbr_id) {
		// TODO Auto-generated method stub
		return mapper.cart_list(mbr_id);
	}

	@Override
	public void cartCntUpdate(Long cart_code, int cart_prchs_cnt) {
		// TODO Auto-generated method stub
		mapper.cartCntUpdate(cart_code, cart_prchs_cnt);
	}

	@Override
	public void cartDelete(Long cart_code) {
		// TODO Auto-generated method stub
		mapper.cartDelete(cart_code);
	}

	@Override
	public void cartAllDelete(String mbr_id) {
		// TODO Auto-generated method stub
		mapper.cartAllDelete(mbr_id);
	}


}
