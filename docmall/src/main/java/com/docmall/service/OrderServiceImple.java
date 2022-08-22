package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.CartOrderVOInfo;
import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;
import com.docmall.mapper.CartMapper;
import com.docmall.mapper.OrderMapper;

@Service
public class OrderServiceImple implements OrderService {
	
	@Autowired
	private OrderMapper mapper;
	@Autowired
	private CartMapper cartMapper;
	
	

	@Override
	public List<CartOrderVOInfo> cartOrderList(String mbr_id) {
		// TODO Auto-generated method stub
		return mapper.cartOrderList(mbr_id);
	}


	@Override
	public void orderbuy(OrderVO orderVo, PayMentVO payMentVo) {
		//1)주문테이블
		mapper.orderSave(orderVo);
		
		//2)주문상세테이블
		Long order_code = orderVo.getOrder_code();//시퀀스
		String mbr_id = orderVo.getMbr_id();
		mapper.orderDetailSave(order_code, mbr_id);
		
		//3)장바구니 삭제
		cartMapper.cartAllDelete(mbr_id);
		
		//4)결제정보 저장
		
		payMentVo.setOrder_code(order_code);
		System.out.println("payMentVo : " + payMentVo);
		mapper.paymentSave(payMentVo);
	}


	@Override
	public List<CartOrderVOInfo> directOrderList(Integer gds_code, Integer cart_prchs_cnt) {
		// TODO Auto-generated method stub
		return mapper.directOrderList(gds_code, cart_prchs_cnt);
	}
	
	
	

}
