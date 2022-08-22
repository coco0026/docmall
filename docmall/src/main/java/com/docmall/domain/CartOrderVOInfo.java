package com.docmall.domain;

import java.util.Date;

import lombok.Data;


@Data
public class CartOrderVOInfo {
	
	
	private Long  cart_code; //주문번호
	private String  mbr_id;                
	private int  cart_prchs_cnt; //구매수량
	private String  gds_nm; //상품명
	private String  gds_img; //이미지
	private String  gds_img_folder; //이미지폴더경로
	private int  gds_price; //가격
	private int  gds_dscnt; //할인율
	private int  grade_dscnt; //할인율
	
	

}
