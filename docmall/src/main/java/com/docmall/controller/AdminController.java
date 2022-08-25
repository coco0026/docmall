package com.docmall.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdminLoginDTO;
import com.docmall.service.AdminService;
import com.docmall.service.CommonCodeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	//스프링시큐리티 암호화 클래스 
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	//공통코드 
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	@Setter(onMethod_ = {@Autowired})
	private AdminService service;
	

	/* 관리자 로그인화면 */
	@GetMapping("")
	public String adminLogin() {
		
		return "/admin/adminLogin";
	}
	
	/* 관리자 메인화면 */
	@GetMapping("/adminMain")
	public void adminMain() {


	}
	
	
	/* 관리자 로그인 */
	@PostMapping("/adminLogin")
	public String adminLogin(AdminLoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		log.info("로그인 정보 : " + dto);
		
		//id로 정보 불러오기
		AdminVO loginVo = service.adminSel(dto);
		
		log.info("DB 로그인 정보 : " + loginVo);
		
		String url = "";
		String msg = "";
		
		if(loginVo != null) {
			
			String pw = dto.getMngr_pw();	//사용자가 입력한 비밀번호
			String db_pw = loginVo.getMngr_pw();	//DB에서 가져온 비밀번호
			
			/* 사용자가 입력한 비밀번호와 db의 암호화된 비밀번호 비교 */
			if(bCryptPasswordEncoder.matches(pw, db_pw)) {
				//1)비밀번호일치
				url="";//완료후 경로
				session.setAttribute("adminStatus", loginVo);//세션 정보 저장.
				
				
				
				String dest = (String)session.getAttribute("dest"); //LoginInterceptor preHandle()메서드에서 세션 형대로 저장
				
				System.out.println("dest : " + dest);

				url = (dest != null)? dest : "/admin/";
				
				service.login_date(loginVo.getMngr_id()); //로그인 시간 업데이트
				
				msg = "loginSuceess";
				log.info("로그인성공");
			}else {
				//2)비밀번호다름
				url = "/admin/";
				msg = "passwdFail";
				log.info("비번다름");
			}
			
		}else {
			//3)아이디 없음
			url = "/admin/";
			msg = "idFail";
			log.info("아디다름");
		}
		
		rttr.addFlashAttribute("msg", msg);
		return "redirect:"+url;
	}
	
	//로그아웃
	@GetMapping("/logout")//대부분 보안 때문에 POST방식을 사용함
	public String logout(RedirectAttributes rttr, HttpSession session) {
		
		//세션 제거
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "logout"); //로그아웃 완료 메시지
		
		return "redirect:/admin/adminLogin";
	}
	
	
}
