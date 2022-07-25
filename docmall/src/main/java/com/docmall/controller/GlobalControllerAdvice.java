package com.docmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.docmall.service.CommonCodeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ControllerAdvice(basePackages = {"com.docmall.controller"}) // "com.docmall.controller" 패키지에서 공통적인 model을 재사용하고자 할떄 ControllerAdvice사용
public class GlobalControllerAdvice {
	

	//공통코드 
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	
	//1차 카테고리 MOdel
	@ModelAttribute
	public void categoryList(Model model) {
		
		log.info("Category1 call..");
		
		model.addAttribute("mainCategoryList", commonCodeService.getCommonCode());
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
