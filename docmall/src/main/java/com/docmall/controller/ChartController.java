package com.docmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.docmall.domain.ChartVO;
import com.docmall.service.ChartService;
import com.docmall.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/chart/*")
@Controller
public class ChartController {
	
	

	@Setter(onMethod_ = {@Autowired})
	private ChartService service;
	
	
	@GetMapping("overall")
	public void overall(Model model) {
		
		
		
		List<ChartVO> primary_list = service.primaryChart();
		
		String primaryData = "[";
		primaryData += "['1차 카테고리', '매출'],";
		
		int i=0;
		for(ChartVO vo : primary_list) {
			
			primaryData += "['" + vo.getPrimary_cd() + "'," + vo.getSales_p() + "]";
			i++;
			
			//마지막 데이터 처리시 ,추가안함
			if(i < primary_list.size()) primaryData += ",";
			
		}
		
		primaryData += "]";
		
		model.addAttribute("primaryData", primaryData);
		
		
		
	}
	
	
	
	
	
	
	
	
	
	

}
