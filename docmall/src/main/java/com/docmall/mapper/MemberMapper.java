package com.docmall.mapper;

import com.docmall.domain.MemberVO;

public interface MemberMapper {
	
	void join(MemberVO vo);
	
	String idCheck(String mbr_id);

}
