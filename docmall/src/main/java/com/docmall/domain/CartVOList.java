package com.docmall.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartVOList {
	
	private Long cart_code;      // 장바구니 코드
	private Integer gds_code;  //상품코드
	private String mbr_id;     //회원아이디
	private int cart_prchs_cnt;  //구매수량
	
	private String gds_nm; // 상품명
	private String gds_img; // 상품이미지 파일 이름
	private String gds_img_folder; // 상품이미지 날짜 폴더이름
	private int gds_price; // 상품가격
	private int gds_dscnt; // 할인율
	
	private int mbr_point_ny; // 적립금
	private String mbr_grade_code;//회원등급
	
	//상품 이미지 파일
	private MultipartFile uploadFile;

}
