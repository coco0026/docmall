package com.docmall.domain;

import lombok.Data;

@Data
public class CartVO {
	
	private Long cart_code;      // 장바구니 코드
	private Integer gds_code;  //상품코드
	private String mbr_id;     //회원아이디
	private int cart_prchs_cnt;  //구매수량

}
