package com.docmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.docmall.domain.MemberVO;
import com.docmall.domain.ReviewVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.ReviewService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user/review/*")
@RestController
public class ReviewController {
	
	@Setter(onMethod_ = {@Autowired})
	private ReviewService service;
	
	
	//리뷰 쓰기
	//consumes:클라이언트에서 보내는 데이터 타입지정.
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReviewVO vo, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		vo.setMbr_id(mbr_id);
		log.info("ReviewVO : " + vo);
		
		service.create(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//리뷰 수정.  resp api개발
	@PatchMapping(value = "/modify", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReviewVO vo, HttpSession session) {
		
		ResponseEntity<String> entity = null;

		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		vo.setMbr_id(mem_id);
		
		log.info("상품후기: " + vo);
		
		service.modify(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	
	//리뷰 리스트
	@GetMapping("/list/{gds_code}/{page}")
	public ResponseEntity<Map<String, Object>> reviewList(@PathVariable("gds_code") Integer gds_code, @PathVariable("page") Integer page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		Criteria cri = new Criteria();
		cri.setPageNum(page);
		
		
		log.info("cri : " + cri);
		
		List<ReviewVO> list =  service.reviewList(gds_code, cri);
		map.put("list", list);
		
		PageDTO pageMaker = new PageDTO(cri, service.listCount(gds_code));
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		
		return entity;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
