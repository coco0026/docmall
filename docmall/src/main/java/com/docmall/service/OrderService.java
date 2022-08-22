package com.docmall.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.CartOrderVOInfo;
import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;

public interface OrderService {
	
	
	//주문리스트
	List<CartOrderVOInfo> cartOrderList(String mbr_id);
	
	//다이렉트 주문목록
	List<CartOrderVOInfo> directOrderList(Integer gds_code, Integer cart_prchs_cnt);
	
	void orderbuy(OrderVO orderVo, PayMentVO payMentVo);
	

}
