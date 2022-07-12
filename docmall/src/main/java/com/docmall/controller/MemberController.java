package com.docmall.controller;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

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
import com.docmall.dto.LoginDTO;
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
	
	
	//메일 인증확인작업
	@PostMapping("/confirmAuthCode")
	@ResponseBody
	public ResponseEntity<String> confirmAuthCode(String userAuthCode, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		String authCode = (String) session.getAttribute("authCode"); //object를 string으로 형변환
		
		if(userAuthCode.equals(authCode)) { //user가 받은 인증코드와 java에서 만든 인증코드 비교
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return entity;
		
	}
	
	
	//로그인 폼
	@GetMapping("/login")
	public void login() {
		
		log.info("call login form.....");
		
	}
	
	
	@PostMapping("/login")
	public String login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		//1) rttr.addFlashAttribute(attributeName, attributeValue) : 페이지 이동주소의 jsp에서 참조할 경우
		//2) rttr.addAttribute(attributeName, attributeValue) : 리다이렉트 주소에 파라미터로 사용. /member/login?pageNum=값&amount=값
		
		log.info("로그인 정보 : " + dto);
		
		//로그인 정보 인증작업
		MemberVO loginVo = service.login_ok(dto); //로그인정보 MemberVo에 담는다.
		
		String url ="";
		String msg ="";
		
		if(loginVo != null) { //아이디가 존재하는 경우
			
			String passwd = dto.getMbr_pw(); // 사용자가 입력한 비밀번호
			String db_passwd = loginVo.getMbr_pw(); //db에서 가져온 비밀번호
			
			
			//사용자가 입력한 평문텍스트와 DB암호화된 비밀번호 비교작업
			if(passwd.equals(db_passwd)) {
				//1)비번이 일치되는경우
				url ="/"; 
				session.setAttribute("loginStatus", loginVo); //인증성공시 서버측에 세션을 통한 정보 저장.
				msg = "loginSuccess";
				log.info("session.getAttributeNames() : " + session.getAttributeNames());
			}else {
				//2)비번이 일치되지 안흔 경우
				url ="/member/login";
				msg = "passwdFail";
			}
			
		}else {//아이디가 존재하지 않는 경우
			url ="/member/login";
			msg = "idNull";
			
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:"+url;
	}
	
	
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(RedirectAttributes rttr, HttpSession session) {
		
		if(session.getAttributeNames() != null) {
			
			session.invalidate();
		}
		
		return "redirect:/";
	}
	
	
	
	
	
	
	
	
	
	
}
