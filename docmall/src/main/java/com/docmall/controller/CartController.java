package com.docmall.controller;

import java.util.List;

import javax.print.attribute.standard.Severity;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;
import com.docmall.domain.MemberVO;
import com.docmall.domain.ProductVO;
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
	
	
	
	
	@GetMapping("/cart_list")
	public void cart_list(HttpSession session, Model model) {
		
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		
		List<CartVOList> cartList = service.cart_list(mbr_id);
		
		for(int i=0; i<cartList.size(); i++) {
			String gdsImgFolder = cartList.get(i).getGds_img_folder().replace("\\", "/"); // File.separator운영체제 경로구분자
			cartList.get(i).setGds_img_folder(gdsImgFolder);
		}
		
		model.addAttribute("cartList", cartList);
		
	}
	
	@ResponseBody
	@GetMapping("/cartCntUpdate")
	public ResponseEntity<String> cartCntUpdate(@RequestParam("cart_code") Long cart_code, @RequestParam("cart_prchs_cnt") int cart_prchs_cnt){
		
		ResponseEntity<String> entity = null;
		
		service.cartCntUpdate(cart_code, cart_prchs_cnt);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	//장바구니 취소
	@GetMapping("/cartDelete")
	public String cartDelete(Long cart_code) {
		
		service.cartDelete(cart_code);
		
		
		return "redirect:/user/cart/cart_list";
	}
	
	
	//장바구니 전체 비우기
	@GetMapping("/cartAllDelete")
	public String cartAllDelete(HttpSession session) {
		
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		
		service.cartAllDelete(mbr_id);
		
		return "redirect:/user/cart/cart_list";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
