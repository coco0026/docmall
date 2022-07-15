package com.docmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.docmall.domain.AdminVO;
import com.docmall.dto.AdminLoginDTO;
import com.docmall.mapper.AdminMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImple implements AdminService {
	
	@Autowired
	private AdminMapper mapper;

	@Override
	public AdminVO adminSel(AdminLoginDTO dto) {
		// TODO Auto-generated method stub
		log.info("AdminLoginDTO : " + dto);
		return mapper.adminSel(dto);
	}

	@Override
	public void login_date(String mngr_id) {
		// TODO Auto-generated method stub
		mapper.login_date(mngr_id);
		
	}

}
