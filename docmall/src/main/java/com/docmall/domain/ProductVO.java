package com.docmall.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {
	
	//gds_code, cate_code, cate_code_prt, gds_nm, gds_cn, gds_img, gds_price, gds_dscnt, gds_cnt, gds_prchs_yn, gds_sale_cnt, gds_reg_date, gds_update_date
	
	private Integer gds_code; // 상품번호
	private String cate_code; // 카테고리1
	private String cate_code_prt; // 카테고리2
	private String gds_nm; // 상품명
	private String gds_cn; // 상품소개
	private String gds_img; // 상품이미지 파일 이름
	private String gds_img_folder; // 상품이미지 날짜 폴더이름
	private int gds_price; // 상품가격
	private int gds_dscnt; // 할인율
	private int gds_cnt; // 상품수
	private String gds_prchs_yn; // 구매가능 여부
	private int gds_sale_cnt; // 판매수량
	private Date gds_reg_date; // 등록일
	private Date gds_update_date; // 수정일
	
	//상품 이미지 파일
	private MultipartFile uploadFile;
	
 
}
