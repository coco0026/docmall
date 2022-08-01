package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;
import com.docmall.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImple implements ReviewService {
	
	@Setter(onMethod_ = {@Autowired})
	private ReviewMapper mapper;

	@Override
	public void create(ReviewVO vo) {
		// TODO Auto-generated method stub
		mapper.create(vo);
	}

	@Override
	public List<ReviewVO> reviewList(Integer gds_code, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.reviewList(gds_code, cri);
	}

	@Override
	public int listCount(Integer gds_code) {
		// TODO Auto-generated method stub
		return mapper.listCount(gds_code);
	}

}
