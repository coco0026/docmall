package com.docmall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;
import com.docmall.dto.Criteria;

public interface AdminOrderMapper {
	
	//관리자 주문목록
	List<OrderVO> getOrderList(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	int getOrderTotalCount(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	void orderProcessChange(@Param("order_code") Long order_code, @Param("order_process") String order_process);
	
	/* 선택삭제 */
	void orderDel(Long order_code);
	
	/* 선택삭제 db where in처리 */
	/* void orderDel(List<Long> orderCodeArr); */
	
	//주문정보
	OrderVO getOrderInfo(Long order_code);
	
	//결제정보
	PayMentVO getPaymentInfo(Long order_code);
	
	//주문상세정보
	List <Map<String, Object>> getOrderDetailInfo(Long order_code);
	
	
	/**
	 * 주문상품 개별취소 기능
	 * 1) 주문상세 테이블 데이터 삭제
	 * 2) 주문테이블 : 총주문가격 수정
	 * 3)결제테이블 : 결제총금액 수정
	 */
	void orderDetailProductDelete(@Param("order_code") Long order_code, @Param("gds_code") Integer gds_code);
	
	void orderTotalPriceChange(@Param("order_code") Long order_code, @Param("order_dtl_amt") int order_dtl_amt);
	
	void paymentTotalPriceChange(@Param("order_code") Long order_code, @Param("order_dtl_amt") int order_dtl_amt);
	
	
	
	
}
