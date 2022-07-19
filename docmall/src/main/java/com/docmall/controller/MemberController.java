package com.docmall.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.MemberVO;
import com.docmall.dto.EmailDTO;
import com.docmall.dto.LoginDTO;
import com.docmall.service.CommonCodeService;
import com.docmall.service.EmailService;
import com.docmall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@Controller
public class MemberController {
	
	//스프링시큐리티 암호화 클래스 
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Setter(onMethod_ = {@Autowired})
	private MemberService service;
	
	//메일서비스
	@Setter(onMethod_ = {@Autowired})
	private EmailService mailService;
	
	//공통코드 
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;

	
	
	
	
	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
	}
	
	//회원정보 저장
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr)throws Exception { //RedirectAttributes는 Excepption
		
		String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMbr_pw());//vo에 담긴 패스워드값을 암호화한다.
		
		vo.setMbr_pw(cryptEncoderPW);//암호화한 패스워드값을 vo에 저장
		
		log.info("call join...");
		
		//Mber_eml_addr_yn의 파라미터가 Y가 아닐시 N
		if(vo.getMbr_eml_addr_yn() == null) {
			vo.setMbr_eml_addr_yn("N");
		}
				
		log.info(vo);
		
		//service 호출시 메서드 int형으로 변경하여 로그인성공, 실패 나누는 작업 해야함, 현재 void
		
		service.join(vo);		
		
		rttr.addFlashAttribute("msg", "joinSuccess");//로그인 완료시 메시지
		
		return "redirect:/";
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
	
	//휴대폰번호 중복체크
	@ResponseBody
	@GetMapping("/telNoCheck")
	public ResponseEntity<String> telNoCheck(@RequestParam("mbr_telno") String mbr_telno){
		
		ResponseEntity<String> entity = null;
		
		//아이디 존재여부작업
		String isUseTelNo = "";
		
		if(service.telNoCheck(mbr_telno) != null) {
			isUseTelNo = "no"; // 중복된 비번 존재, 사용 불가능
		}else {
			isUseTelNo = "yes"; // 중복된 비번 없음, 사용 가능
		}
		
		entity = new ResponseEntity<String>(isUseTelNo, HttpStatus.OK);
		
		return entity;
	}
	
	
	//이메일중복체크
	@ResponseBody
	@GetMapping("/mailCheck")
	public ResponseEntity<String> mailCheck(@RequestParam("mbr_eml_addr") String mbr_eml_addr){
		
		ResponseEntity<String> entity = null;
		
		//아이디 존재여부작업
		String isUseMail = "";
		
		if(service.mailCheck(mbr_eml_addr) != null) {
			isUseMail = "no"; // 중복된 비번 존재, 사용 불가능
		}else {
			isUseMail = "yes"; // 중복된 비번 없음, 사용 가능
		}
		
		entity = new ResponseEntity<String>(isUseMail, HttpStatus.OK);
		
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
			
			session.removeAttribute("authCode");//인증 완료 후 세션 제거
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
	
	//로그인
	/* @Transactional */
	@PostMapping("/login")
	public String login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		//1) rttr.addFlashAttribute(attributeName, attributeValue) : 페이지 이동주소의 jsp에서 참조할 경우
		//2) rttr.addAttribute(attributeName, attributeValue) : 리다이렉트 주소에 파라미터로 사용. /member/login?pageNum=값&amount=값
		
		log.info("로그인 정보 : " + dto);
		
		
		//로그인 정보 인증작업
		MemberVO loginVo = service.login_ok(dto); //로그인정보 MemberVo에 담는다.
		
		String url ="";
		String msg ="";
		
		log.info("loginVo : " + loginVo);
		
		if(loginVo != null) { //아이디가 존재하는 경우
			
			String passwd = dto.getMbr_pw(); // 사용자가 입력한 비밀번호
			String db_passwd = loginVo.getMbr_pw(); //db에서 가져온 비밀번호
			
			//사용자가 입력한 평문텍스트와 DB암호화된 비밀번호 비교작업
			if(bCryptPasswordEncoder.matches(passwd, db_passwd)) {
				//1)비번이 일치되는경우
				url ="/"; //main화면
				session.setAttribute("loginStatus", loginVo); //인증성공시 서버측에 세션을 통한 정보 저장.
				service.login_date(loginVo.getMbr_id()); //로그인 성공시 로그인 시간 UPDATE
				msg = "loginSuccess";
				log.info("로그인성공");
			}else {
				//2)비번이 일치되지 안흔 경우
				url ="/member/login";
				msg = "passwdFail";
				log.info("비번다름");
			}
			
		}else {//아이디가 존재하지 않는 경우
			url ="/member/login";
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
		
		return "redirect:/";
	}
	
	
	//아이디,비밀번호 찾기 폼
	@GetMapping("/lostpass")
	public void lostpass() {
		
	}
	
	//아이디 찾기
	@PostMapping("/searchID")
	public String searchID(@RequestParam("mbr_nm") String mbr_nm, @RequestParam("mbr_eml_addr") String mbr_eml_addr, Model model, RedirectAttributes rttr) {
		
		String result = service.searchID(mbr_nm, mbr_eml_addr);
		String url = "";
		
		if(result != null) {//ID가 존재할경우
			/* ------------------글자수에 따른 hide 작업-------------------- */
			
			int viewString = 4; //표기할 자릿수
			
			String mbrID = result.substring(0, viewString);//받아온 값을 표기할 자릿수만큼 자름
			int mbrIdLeng = (result.length() - viewString);//값의 사이즈에 표기할자릿수 빼기
			
			//나머지 글자 수만큼 *표시
			for(int i = 0; i<mbrIdLeng; i++) {
				mbrID += "*";
			}
			/* ------------------글자수에 따른 hide 작업-------------------- */
			
			model.addAttribute("mbrID", mbrID);
			url = "/member/searchID";
			
		}else { //ID가 존재하지 않을 경우
			url = "redirect:/member/lostpass";
			rttr.addFlashAttribute("msg", "noID");
		}
		return url;
		
	}
	
	//임시비밀번호 발급
	@PostMapping("/searchImsiPW")
	public String searchImsiPW(@RequestParam("mbr_id") String mbr_id, @RequestParam("mbr_eml_addr") String mbr_eml_addr, Model model, RedirectAttributes rttr) {
		
		String url = "";
		
		//db에서 아이디와 메일존재여부를 확인
		String mbrID = service.getIdEmailExists(mbr_id, mbr_eml_addr);
		String temp_mbrPW = "";
		
		log.info("mbrID :  "+ mbrID);
		
		if(mbrID != null) {
			//메일보내기 작업
			
			//임시비밀번호 생성
			UUID uid = UUID.randomUUID();
			temp_mbrPW = uid.toString().substring(0, 6); //6자리 문자열
			
			log.info("temp_mbrPW : " + temp_mbrPW);
			log.info("bCryptPasswordEncoder.encode(temp_mbrPW)  :  "+ bCryptPasswordEncoder.encode(temp_mbrPW));
			
			//UUID로 만든6자리 임시 비밀번호를 암호화하여 비밀번호 변경
			service.changeImsiPW(mbr_id, bCryptPasswordEncoder.encode(temp_mbrPW));
			
			
			//메일발송
			EmailDTO dto = new EmailDTO("EzenShop", "EzenShop", mbr_eml_addr, "EzenShop 임시 비밀번호 입니다.", "");
			
			
			try {
				mailService.sendMain(dto, temp_mbrPW);
				model.addAttribute("mail", "mail");
				url = "/member/searchID";
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}else {
			url = "redirect:/member/lostpass";
			rttr.addFlashAttribute("msg", "noID");
		}
		
		return url;
	}
	
	
	
	//회원정보 수정폼 들어가기전 비밀번호 재확인폼
	@GetMapping("/confirmPw")
	public void confirmPw() {
		
	}
	
	//비밀번호 재확인
	@PostMapping("/confirmPw")
	public String confirmPw(@RequestParam("mbr_pw") String mbr_pw, HttpSession session, RedirectAttributes rttr) {
		
		String url = "";
		
		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		
		
		//로그인에 사용하던 메서드 재사용
		LoginDTO dto = new LoginDTO(mbr_id, mbr_pw);
		MemberVO vo =  service.login_ok(dto);
		
		String passwd = mbr_pw; // 사용자가 입력한 비밀번호
		String db_passwd = vo.getMbr_pw(); //db에서 가져온 비밀번호
		
		
		if(vo != null) { // 아이디 존재
			//사용자가 입력한 평문텍스트와 DB암호화된 비밀번호 비교작업
			if(bCryptPasswordEncoder.matches(passwd, db_passwd)) {
				url = "/member/modify";
			}else {
				url = "/member/confirmPw";
				rttr.addFlashAttribute("msg", "noPW");
			}
		}else {	//아이디 존재 하지 않았을때
			
		}
		
		return "redirect:" + url;
	}
	
	
	//회원정보 수정 폼
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) {//로그인 상태에서 세션정보 가져오기
		
		//세션 정보
		String mbr_id = ((MemberVO) session.getAttribute("loginStatus")).getMbr_id();
		LoginDTO dto = new LoginDTO(mbr_id, "");//pw는 쿼리에 사용하지 않음
		
		//로그인 쿼리가 회원정보수정폼 쿼리와 동일하여 사용
		MemberVO vo = service.login_ok(dto);
		
		model.addAttribute("memberVO", vo);
		
		
		
		
	}
	
	//회원정보 수정
	@PostMapping("/modify")
	public String modify(MemberVO vo, RedirectAttributes rttr) {
		
		log.info("vo : " + vo);
		
		//파라미터가 일치하지 않는경우 null
		//파라미터가 일치하는경우 값이 없으면 공백
		
		if(vo.getMbr_pw().equals("")) log.info("공백문자열");
		
		//pw가 null이 아닐경우
		if(vo.getMbr_pw() != null || !vo.getMbr_pw().equals("")) {
			String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMbr_pw());//vo에 담긴 패스워드값을 암호화한다.
			vo.setMbr_pw(cryptEncoderPW);//암호화한 패스워드값을 vo에 저장
			log.info("vo : " + vo);
		}
		
		//Mber_eml_addr_yn의 파라미터가 Y가 아닐시 N
		if(vo.getMbr_eml_addr_yn() == null) {
			vo.setMbr_eml_addr_yn("N");
		}
		
		
		if(service.modify(vo)) {
			rttr.addFlashAttribute("msg", "modifySuccess");//로그인 완료시 메시지
		}else {
			rttr.addFlashAttribute("msg", "modifyFail");//로그인 완료시 메시지
		}
		
		
		return "redirect:/member/modify";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
