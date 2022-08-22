package com.docmall.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.AdminOrderMapper;

@Service
public class AdminOrderServiceImple implements AdminOrderService {
	
	@Autowired
	AdminOrderMapper mapper;

	@Override
	public List<OrderVO> getOrderList(Criteria cri, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mapper.getOrderList(cri, startDate, endDate);
	}

	@Override
	public int getOrderTotalCount(Criteria cri, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mapper.getOrderTotalCount(cri, startDate, endDate);
	}

	@Override
	public void orderProcessChange(Long order_code, String order_process) {
		// TODO Auto-generated method stub
		mapper.orderProcessChange(order_code, order_process);
	}

	@Override
	public void orderDel(Long order_code) {
		// TODO Auto-generated method stub
		mapper.orderDel(order_code);
	}

	@Override
	public OrderVO getOrderInfo(Long order_code) {
		// TODO Auto-generated method stub
		return mapper.getOrderInfo(order_code);
	}

	@Override
	public PayMentVO getPaymentInfo(Long order_code) {
		// TODO Auto-generated method stub
		return mapper.getPaymentInfo(order_code);
	}

	@Override
	public List<Map<String, Object>> getOrderDetailInfo(Long order_code) {
		// TODO Auto-generated method stub
		return mapper.getOrderDetailInfo(order_code);
	}
	
	
	/**
	 * 주문상품 개별취소기능
	 * @param order_code 주문코드
	 * @param gds_code 상품코드
	 * @param order_dtl_amt 상품 가격 (수량*가격)
	 */
	@Transactional
	@Override
	public void orderUnitProductCancel(Long order_code, Integer gds_code,  int order_dtl_amt) {
		
		mapper.orderDetailProductDelete(order_code, gds_code);
		mapper.orderTotalPriceChange(order_code, order_dtl_amt);
		mapper.paymentTotalPriceChange(order_code, order_dtl_amt);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
