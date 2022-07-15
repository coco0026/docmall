package com.docmall.mapper;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdminLoginDTO;

public interface AdminMapper {

	/* 로그인을 위한 아이디 검색 */
	AdminVO adminSel(AdminLoginDTO dto);
	
	/* 로그인 시간 업데이트 */
	public void login_date(String mngr_id);
}
