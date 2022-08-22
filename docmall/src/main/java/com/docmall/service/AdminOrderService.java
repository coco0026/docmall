package com.docmall.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;
import com.docmall.dto.Criteria;

public interface AdminOrderService {
	
	List<OrderVO> getOrderList(Criteria cri, String startDate, String endDate);
	int getOrderTotalCount(Criteria cri, String startDate, String endDate);
	
	void orderProcessChange(Long order_code,  String order_process);
	
	void orderDel(Long order_code);
	
	/* 선택삭제 db where in처리 */
	/* void orderDel(List<Long> orderCodeArr); */
	
	//주문정보
	OrderVO getOrderInfo(Long order_code);
	
	//결제정보
	PayMentVO getPaymentInfo(Long order_code);
	
	//주문상세정보
	List <Map<String, Object>> getOrderDetailInfo(Long order_code);
	
	
	void orderUnitProductCancel(Long order_code,  Integer gds_code, int order_dtl_amt);
	
	
	

}
