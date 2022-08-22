package com.docmall.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CartOrderVOInfo;
import com.docmall.domain.CartVO;
import com.docmall.domain.CartVOList;
import com.docmall.domain.CommonCodeVO;
import com.docmall.domain.MemberVO;
import com.docmall.domain.OrderVO;
import com.docmall.domain.PayMentVO;
import com.docmall.domain.ProductVO;
import com.docmall.kakaopay.ApproveResponse;
import com.docmall.kakaopay.ReadyResponse;
import com.docmall.service.CartService;
import com.docmall.service.CommonCodeService;
import com.docmall.service.OrderService;
import com.docmall.service.kakaoPayServiceImple;
import com.docmall.util.UploadFileUtils;

import lombok.Setter;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/order/*")
public class OrderController {
	
	@Setter(onMethod_ = {@Autowired})
	private OrderService service;
	
	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;
	
	@Resource(name = "uploadPath") //Bean중에 uploadPath bean 객체를 찾아, 아래 변수에 주입
	private String uploadPath; // C:/LYS/upload/
	
	//공통코드 
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	@Setter(onMethod_ = {@Autowired})
	private kakaoPayServiceImple kakaoPayServiceImpl;
	
	
	
	//상품목록에서 이미지
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		
		String resultFileName = folderName + "\\" + fileName; 
		
		//이미지를 바이트 배열로 호출
		return UploadFileUtils.getFile(uploadPath, resultFileName);
		
	}	
	
	
	
	
	//주문 내역
	@GetMapping("/orderListInfo")
	public void orderListInfo(@RequestParam("type") String type, Integer gds_code, Integer cart_prchs_cnt, HttpSession session, Model model) {
		
		
		
		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		
		
		List<CartOrderVOInfo> cartOrderList = null;
		
		if(type.equals("cartOrder")) {//장바구구니 에서 구매 Integer gds_code, int cart_prchs_cnt사용x
			cartOrderList = service.cartOrderList(mbr_id);
		}else if(type.equals("direct")) {//직접구매 Integer gds_code, int cart_prchs_cnt
			cartOrderList = service.directOrderList(gds_code, cart_prchs_cnt);
			//직접구매시 장바구니 데이터를 저장한다.
			//주문할때 장바구니에 있는 데이터를 orderTBL에 insert하기에 직접주문시에 장바구니테이블에 임시저장
			
			CartVO vo = new CartVO();
			vo.setMbr_id(mbr_id);
			vo.setGds_code(gds_code);
			vo.setCart_prchs_cnt(cart_prchs_cnt);
			
			cartService.cart_add(vo);
		}
		
		
		for(int i=0; i<cartOrderList.size(); i++) {
			String gdsImgFolder = cartOrderList.get(i).getGds_img_folder().replace("\\", "/"); // File.separator운영체제 경로구분자
			cartOrderList.get(i).setGds_img_folder(gdsImgFolder);
			
			log.info("((MemberVO) session.getAttribute(\"loginStatus\")).getMbr_grade_code() : " + ((MemberVO) session.getAttribute("loginStatus")).getMbr_grade_code());
			
			/* 회원 등급별 적립금률 */
			if(((MemberVO) session.getAttribute("loginStatus")).getMbr_grade_code().equals("A01")) {
				cartOrderList.get(i).setGrade_dscnt(3);
			}else if(((MemberVO) session.getAttribute("loginStatus")).getMbr_grade_code().equals("A02")) {
				cartOrderList.get(i).setGrade_dscnt(5);
			}else if(((MemberVO) session.getAttribute("loginStatus")).getMbr_grade_code().equals("A03")) {
				cartOrderList.get(i).setGrade_dscnt(7);
			}else if(((MemberVO) session.getAttribute("loginStatus")).getMbr_grade_code().equals("A04")){
				cartOrderList.get(i).setGrade_dscnt(10);
			}
			
			log.info("cartOrderList.get(i) : " + cartOrderList.get(i).getGrade_dscnt());
			
			
		}
		
		
		
		model.addAttribute("cartOrderList", cartOrderList);
		
	}
	
	//주문저장하기
	@PostMapping("/orderSave")
	public String orderSave(OrderVO orderVo, PayMentVO payMentVO, String type,  HttpSession session) {
		
		log.info("orderVO : " + orderVo);
		log.info("payMentVO : " + payMentVO);
		

		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		orderVo.setMbr_id(mbr_id);
		
		//무통장입금인경우
		if(type.equals("무통장")) {
			
			orderVo.setPayment_process("B11");//입금전 코드
			
			payMentVO.setPay_tot_price(orderVo.getOrder_tot_amt()); // 총결제금액
			payMentVO.setPay_rest_price(0); //추가 입금액
		}
		//카카오페이 결제인경우
		/*
		 * if(type.equals("카카오페이")) {
		 * 
		 * orderVo.setPayment_process("B11");//입금전 코드
		 * 
		 * payMentVO.setPay_tot_price(orderVo.getOrder_tot_amt()); // 총결제금액
		 * payMentVO.setPay_rest_price(0); //추가 입금액 }
		 */
		
		
		//주문,주문상세테이블  insert 장바구니 테이블delete
		service.orderbuy(orderVo,payMentVO);
		
		
		
		return "redirect:/user/order/orderComplete";
	}
	
	@GetMapping("/orderPay")//카카오페이
	public @ResponseBody ReadyResponse orderPay(OrderVO orderVo, PayMentVO payMentVO, int totalAmount, HttpSession session, Model model) {
		
		
		//장바구니테이블에서 상품정보(상품명, 상품코드, 수량, 상품가격*수량=단위별 금액)
		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		//장바구니에서 주문이 진행될 때
		List<CartVOList> cartList = cartService.cart_list(mbr_id);
		String itemName = cartList.get(0).getGds_nm() + "외 " + String.valueOf(cartList.size() - 1) + " 개";
		int quantity = cartList.size() - 1;
		
		
		// 카카오페이서버에서 보낸온 정보.
		ReadyResponse readyResponse = kakaoPayServiceImpl.payReady(itemName, quantity, mbr_id, totalAmount);
		
		//model.addAttribute("tid", readyResponse.getTid());
		
		session.setAttribute("tid", readyResponse.getTid());
		log.info("결제고유번호: " + readyResponse.getTid());
		
		orderVo.setMbr_id(mbr_id);
		session.setAttribute("order", orderVo);
		session.setAttribute("payment", payMentVO);
		
		
		return readyResponse;
	}
	
	
	@GetMapping("/orderComplete")
	public void orderComplete() {
		
	}
	
	//결제승인요청 : 큐알코드를 찍고(결제요청) 카카오페이 서버에서 결제가 성공적으로 끝나면, 카카오페이 서버에서 호출하는 주소
	@GetMapping("/orderApproval")
	public String orderApproval(@RequestParam("pg_token") String pgToken, HttpSession session ) {
		
		log.info("결제 승인요청 인증토큰: " + pgToken);
		//log.info("주문정보: " + o_vo);
		
		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		
		String tid = (String) session.getAttribute("tid");
		OrderVO orderVO = (OrderVO) session.getAttribute("order");
		PayMentVO paymentVO = (PayMentVO) session.getAttribute("payment");
		
		session.removeAttribute("tid");//세션제거.
		session.removeAttribute("order");//세션제거.
		session.removeAttribute("payment");//세션제거.
		
		log.info("결제고유번호: " + tid);
		
		//카카오페이 결제하기
		ApproveResponse approveResponse =kakaoPayServiceImpl.payApprove(tid, pgToken, mbr_id);
		
		log.info("approveResponse: " + approveResponse);
		
		log.info("orderVO: " + orderVO);
		log.info("paymentVO: " + paymentVO);
		
		//카카오페이 결제정보 db저정 : approveResponse 제외
		service.orderbuy(orderVO, paymentVO);

		return "redirect:/user/order/orderComplete";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
