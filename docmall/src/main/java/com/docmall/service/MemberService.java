package com.docmall.service;

import com.docmall.domain.MemberVO;

public interface MemberService {
	
	void join(MemberVO vo);
	
	String idCheck(String mbr_id);

}
