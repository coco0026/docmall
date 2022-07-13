package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.docmall.domain.MemberVO;
import com.docmall.dto.LoginDTO;
import com.docmall.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImple implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	//회원가입
	@Override
	public void join(MemberVO vo) { //인트로 바꾸자
		// TODO Auto-generated method stub
		log.info("MemberServiceImple 동작함");
		mapper.join(vo);
		
	}
	
	
	//아이디 중복확인
	@Override
	public String idCheck(String mbr_id) {
		// TODO Auto-generated method stub
		return mapper.idCheck(mbr_id);
	}
	
	//로그인
	@Override
	public MemberVO login_ok(LoginDTO dto) {
		// TODO Auto-generated method stub
		return mapper.login_ok(dto);
	}

	//로그인시간 업데이트
	@Override
	public void login_date(String mbr_id) {
		// TODO Auto-generated method stub
		mapper.login_date(mbr_id);		
	}

}
