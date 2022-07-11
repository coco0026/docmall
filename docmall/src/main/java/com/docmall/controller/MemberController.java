package com.docmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.MemberVO;
import com.docmall.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;

	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	
	//회원가입 기능
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr)throws Exception { //RedirectAttributes는 Excepption
		
		log.info("call join...");
		
		//Mber_eml_addr_yn의 파라미터가 Y가 아닐시 N
		if(vo.getMbr_eml_addr_yn() == null) {
			vo.setMbr_eml_addr_yn("N");
		}
		
		log.info(vo);
		
		service.join(vo);
		
		return "";
	}
	
	
	//아이디 중복체크
	@ResponseBody
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestParam("mbr_id") String mbr_id){
		
		ResponseEntity<String> entity = null;
		
		//아이디 존재여부작업
		String isUseID = "";
		
		if(service.idCheck(mbr_id) != null) {
			isUseID = "no"; // 중복된 아이디가 존재, 사용 불가능
		}else {
			isUseID = "yes"; // 중복된 아이디가 없음, 사용 가능
		}
		
		entity = new ResponseEntity<String>(isUseID, HttpStatus.OK);
		
		return entity;
	}
	
	
	
	
	
	
	
	
	
	
}
