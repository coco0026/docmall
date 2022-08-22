package com.docmall.domain;

import lombok.Data;

@Data
public class OrderDetailVO {
	
	private	Integer   gds_code;  //상품번호
	private	Long   order_code; //주문번호
	private	int   order_dtl_cnt;  //주문수량
	private	int   order_dtl_amt;  //주문가격
	private	int  order_dtl_tot_amt;  //총금액
	private	String   order_dtl_process;   //주문 처리 상태

}
