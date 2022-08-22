package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PayMentVO {
	
	
	private Integer pay_code;//결제 코드
	private Long order_code;//주문번호
	private String pay_method;//결제수단 무통장/신용카드/페이코/휴대폰/카카오페이 등
	private Date pay_date;//DATE            NOT NULL,--결제(입금)일자
	private int pay_tot_price;//총 결제금액
	private int pay_rest_price;//추가입금액
	private int pay_nobank_price;//입금액
	private String pay_nobank_user_nm;//입금자명
	private String pay_nobank;//입금은행

}
