package com.docmall.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.OrderVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.AdminOrderService;
import com.docmall.service.CommonCodeService;
import com.docmall.util.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/order/*")
@Controller
public class AdminOrderController {
	
	@Resource(name = "uploadPath") //Bean중에 uploadPath bean 객체를 찾아, 아래 변수에 주입
	private String uploadPath; // C:/LYS/upload/
	
	@Setter(onMethod_ = {@Autowired})
	private AdminOrderService Service;
	
	//공통코드 
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	//상품목록에서 이미지
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		
		String resultFileName = folderName + "\\" + fileName; 
		
		//이미지를 바이트 배열로 호출
		return UploadFileUtils.getFile(uploadPath, resultFileName);
		
	}
	
	
	@GetMapping("/adminOrderList")
	public void orderList(Criteria cri, @RequestParam(value = "startDate", required = false) String startDate, @RequestParam(value = "endDate", required = false) String endDate,  Model model) {
		
		log.info("startDate : " + startDate);
		log.info("endDate : " + endDate);
		
		
		List<OrderVO> orderList =  Service.getOrderList(cri, startDate, endDate);
		log.info("orderList : " + orderList);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		// 배송상태프로세스 공통코드		
		model.addAttribute("commonCode", commonCodeService.getSubCommonCodeTmp("B00"));
		
		//총 갯수
		int total = Service.getOrderTotalCount(cri, startDate, endDate);
		
		//페이징
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
	}
	
	@ResponseBody
	@GetMapping("/orderProcessChange")
	public ResponseEntity<String> orderProcessChange(Long order_code, String order_process){
		ResponseEntity<String> entity = null;
		
		Service.orderProcessChange(order_code, order_process);
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		
		
		return entity;
	}
	
	//선택된 주문정보 삭제 ajax 배열값
	@ResponseBody
	@PostMapping("/orderCheckedDel")
	public ResponseEntity<String> orderCheckedDel(@RequestParam("orderCodeArr[]") List<Long> orderCodeArr){
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<orderCodeArr.size(); i++) {
			Service.orderDel(orderCodeArr.get(i));
		}
		//다른 방법으로는 mybatis에서 where 주문번호 in(1,2,3,4,5)
		
		entity = new ResponseEntity<String>("success",HttpStatus.OK);
		
		return entity;
	}
	
	
	/* 주문상세 */
	@GetMapping("/adminOrderDetail")
	public void adminOrderDetail(Long order_code, Model model) {
		
		
		log.info("order_code : " + order_code);
		
		//vo.setGds_img_folder(vo.getGds_img_folder().replace("\\", "/")); //수정폼 이미지 출력시
		
		// 배송상태프로세스 공통코드		
		model.addAttribute("commonCodeVO", commonCodeService.getSubCommonCodeTmp("B00"));
		
		//주문정보
		model.addAttribute("orderVO", Service.getOrderInfo(order_code));
		//결제정보
		model.addAttribute("payMentVO", Service.getPaymentInfo(order_code));
		//주문상세정보
		List<Map<String, Object>> orderDetailMap =  Service.getOrderDetailInfo(order_code);
		Map<String, Object> orderDetail;
		String gdsImgFolder;
		
		//Map에서 GDS_IMG_FOLDER 컬럼 /변환 \
		for(int i=0; i<orderDetailMap.size(); i++) {
			orderDetail = orderDetailMap.get(i);
			gdsImgFolder = String.valueOf(orderDetail.get("GDS_IMG_FOLDER")).replace("\\", "/");
			orderDetail.put("GDS_IMG_FOLDER", gdsImgFolder);
		}
		
		model.addAttribute("orderDetailMap", orderDetailMap);
		
		
	}
	
	
	/**
	 * 주문상품 개별 취소
	 * @return 주문상세화면
	 */
	@GetMapping("/orderUnitProductCancelCancel")
	public String orderUnitProductCancelCancel(Long order_code, Integer gds_code, int order_dtl_amt, RedirectAttributes rttr) {
		
		Service.orderUnitProductCancel(order_code, gds_code, order_dtl_amt);
		
		rttr.addAttribute("order_code", order_code);
		
		return "redirect:/admin/order/adminOrderDetail";
	}
	
	
	
	
	
	
	
	
	

}
