package com.docmall.domain;

import java.util.Date;

import org.springframework.web.bind.annotation.RequestParam;

import lombok.Data;

@Data
public class OrderVO {
	
	private Long  order_code; //주문번호
	private String  mbr_id;                
	private String  order_mbr_nm; //회원이름
	private String  order_mbr_zip; //회원의 우편번호
	private String  order_mbr_addr; //기본주소
	private String  order_mbr_daddr; //상세주소
	private	String  order_mbr_telno;  // 전화번호
	private	int  order_tot_amt;  // 총가격
	private	Date  order_date; //주문날짜
	
	private	String order_process; //주문프로세스
	private	String payment_process;  //결제프로세스
	private	String cs_process;  //cs프로세스
	
	private	Date order_event_date; 
	private	String event_name;
	
		
}
