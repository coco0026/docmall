package com.docmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;

public interface ReviewMapper {
	
	//리뷰등록
	void create(ReviewVO vo);
	
	//리뷰 리스트
	List<ReviewVO> reviewList(@Param("gds_code") Integer gds_code,  @Param("cri") Criteria cri);
	int listCount(Integer gds_code);//리스트 수

	//상품수정
	void modify(ReviewVO vo);
}
