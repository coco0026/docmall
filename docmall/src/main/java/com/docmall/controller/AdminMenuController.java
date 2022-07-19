package com.docmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.service.CommonCodeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/menu/*")
@Controller
public class AdminMenuController {

	//공통코드
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	
	//메뉴 추가 폼
	@GetMapping("/adminMenuInsert")
	public void adminMenuInsert() {
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
