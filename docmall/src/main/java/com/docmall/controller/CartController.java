package com.docmall.controller;

import javax.print.attribute.standard.Severity;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartVO;
import com.docmall.domain.MemberVO;
import com.docmall.service.CartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user/cart/*")
@Controller
public class CartController {
	

	@Setter(onMethod_ = {@Autowired})
	private CartService service;
	
	//장바구니 담기
	@ResponseBody
	@GetMapping("/cart_add")
	public ResponseEntity<String> cart_add(CartVO vo, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		log.info("장바구니 : " + vo);
		
		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		vo.setMbr_id(mbr_id);
		
		service.cart_add(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
