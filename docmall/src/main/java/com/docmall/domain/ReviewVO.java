package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	
	private Integer review_no; //리뷰번호
	private String mbr_id; //아이디
	private Integer gds_code; //상품번호
	private String review_cn; //리뷰내용
	private int review_score; //평점
	private Date review_reg_date; //등록일
	private Date review_update_date; //수정일

}
