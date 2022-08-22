package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CartOrderVOInfo;
import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;

public interface OrderMapper {
	
	//장바구니 주문리스트
	List<CartOrderVOInfo> cartOrderList(String mbr_id);
	
	//다이렉트 주문목록
	List<CartOrderVOInfo> directOrderList(@Param("gds_code") Integer gds_code, @Param("cart_prchs_cnt") Integer cart_prchs_cnt);
	
	//주문 : 주문테이블, 주문상세테이블, 장바구니테이블삭제
	void orderSave(OrderVO orderVo);
	void orderDetailSave(@Param("order_code") Long order_code, @Param("mbr_id") String mbr_id);// 주문상세테이블
	
	
	//결제정보 저장하기
	void paymentSave(PayMentVO payMentVo);
	
	
	
	
	
	
	
	
	
	
	
	
	

}
