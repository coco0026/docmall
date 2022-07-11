package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.docmall.domain.MemberVO;
import com.docmall.mapper.MemberMapper;

@Service
public class MemberServiceImple implements MemberService {
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public void join(MemberVO vo) {
		// TODO Auto-generated method stub
		
		mapper.join(vo);
		
	}

	@Override
	public String idCheck(String mbr_id) {
		// TODO Auto-generated method stub
		return mapper.idCheck(mbr_id);
	}

}
