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

	@Transactional
	@Override
	public void orderDel(Long order_code) {
		// TODO Auto-generated method stub
		
		//주문삭제기능 : 관련된 작업을 모두 삭제. 트렌젝션 설정
		
		//주문상세테이블 삭제
		mapper.orderDetailDel(order_code);
		//결제테이블 삭제
		mapper.paymentDel(order_code);
		//주문테이블 삭제
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
		
		//주문상세 테이블에 데이터가 1개이면 
		//주문상품중 마지막 상품을 취소시 주문테이블, 결제테이블 주문정보 삭제
		if( mapper.getOrderDetailProductCount(order_code) == 1) {
			mapper.orderDel(order_code);
			mapper.paymentDel(order_code);
		}
		
		mapper.orderDetailProductDelete(order_code, gds_code);
		
		//주문테이블의 총 주문금액 변경
		mapper.orderTotalPriceChange(order_code, order_dtl_amt);
		
		//결제테이블의 총 주문금액 변경
		mapper.paymentTotalPriceChange(order_code, order_dtl_amt);
		
	}
	
	
	/**
	 * 주문 변경 히스토리
	 * @param cri 페이징관련 클래스
	 * @param startDate 검색 조건 시작일
	 * @param endDate 검색조건 마지막일
	 */
	@Override
	public List<OrderVO> getOrderHistory(Criteria cri, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mapper.getOrderHistory(cri, startDate, endDate);
	}

	/**
	 * 주문 변경 히스토리 count
	 * @param cri 페이징관련 클래스
	 * @param startDate 검색 조건 시작일
	 * @param endDate 검색조건 마지막일
	 */
	@Override
	public int getOrderHistoryTotalCount(Criteria cri, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mapper.getOrderHistoryTotalCount(cri, startDate, endDate);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
