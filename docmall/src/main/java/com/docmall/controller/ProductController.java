package com.docmall.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.docmall.domain.CommonCodeVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.CommonCodeService;
import com.docmall.service.ProductService;
import com.docmall.util.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user/product/*")
@Controller
public class ProductController {
	
	//공통코드 
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	@Setter(onMethod_ = {@Autowired})
	private ProductService service;
	
	@Resource(name = "uploadPath") //Bean중에 uploadPath bean 객체를 찾아, 아래 변수에 주입
	private String uploadPath; // C:/LYS/upload/
	
	//1차 카테고리는 GlobalControllerAdvice에서 처리
	
	
	//2차 카테고리
	
	@ResponseBody
	@GetMapping("/subCategoryList/{common_code}")
	public ResponseEntity<List<CommonCodeVO>> subCategoryList(@PathVariable("common_code") String common_code){
		
		
		ResponseEntity<List<CommonCodeVO>> entity = null;
		entity = new ResponseEntity<List<CommonCodeVO>>(commonCodeService.getSubCommonCode(common_code),HttpStatus.OK);
		
		
		return entity;
	}
	
	
	//상품리스트
	@GetMapping("/productList/{common_code_child}") // REST API 주소형태
	public String productList(@PathVariable("common_code_child") String cate_code_child, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("2차 카테고리 : " + cate_code_child);
		
		cri.setAmount(30);//페이지 상품수
		
		List<ProductVO> productList = service.getProductListBySubCategory(cate_code_child, cri);
		
		//gds_img_folder의 (\)를 (/)로 변환    \가 클라이언트에서 서버로 보내지는 데이터로 사용이 안됨.   
		for(int i=0; i<productList.size(); i++) {
			String gdsImgFolder = productList.get(i).getGds_img_folder().replace("\\", "/"); // File.separator운영체제 경로구분자
			productList.get(i).setGds_img_folder(gdsImgFolder);
		}
		
		log.info("list : " + productList);
		model.addAttribute("productList", productList);
		
		//총 갯수
		int total = service.getProductTotalCountBySubCategory(cate_code_child, cri);
		//페이징
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
		return  "user/product/productList";
	}
	
	
	
	//상품목록에서 이미지
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		
		String resultFileName = folderName + "\\" + fileName; 
		
		//이미지를 바이트 배열로 호출
		return UploadFileUtils.getFile(uploadPath, resultFileName);
		
	}
	
	//모달 대화상자 상품상제정보
	@ResponseBody
	@GetMapping("/productDetail/{gds_code}")
	public ResponseEntity<ProductVO> productDetail(@PathVariable("gds_code") Integer gds_code) {
		
		ResponseEntity<ProductVO> entity = null;
		
		ProductVO vo = service.getProductByCode(gds_code);
		vo.setGds_img_folder(vo.getGds_img_folder().replace("\\", "/"));
		
		entity = new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
		
		return entity;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
