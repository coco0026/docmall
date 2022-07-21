package com.docmall.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.docmall.domain.CommonCodeVO;
import com.docmall.domain.ProductVO;
import com.docmall.dto.Criteria;
import com.docmall.dto.PageDTO;
import com.docmall.service.AdminProductService;
import com.docmall.service.AdminService;
import com.docmall.service.CommonCodeService;
import com.docmall.util.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/product/*")
@Controller
public class AdminProductController {
	
	@Resource(name = "uploadPath") //Bean중에 uploadPath bean 객체를 찾아, 아래 변수에 주입
	private String uploadPath; // C:/LYS/upload/
	
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	@Setter(onMethod_ = {@Autowired})
	private AdminProductService Service;
	
	//상품 등록 폼 
	@GetMapping("/adminProductInsert")
	public void productInsert(Model model) {
		
		model.addAttribute("cateList", commonCodeService.getCommonCode());//1차 카테고리 정보
	}
	
	//정적 상수
	private static final int ONE = 1;
	
	//2차카테고리 정보
	@ResponseBody
	@GetMapping("/subCategoryList/{common_code}") ///subCategoryList/{1차카테고리코드(REST)}
	public ResponseEntity<List<CommonCodeVO>> subCategoryList(@PathVariable("common_code") String common_code){ //@PathVariable 경로 주소의 일부분을 파라미터로 참조시 사용
		
		ResponseEntity<List<CommonCodeVO>> entity = null;
		
		entity = new ResponseEntity<List<CommonCodeVO>>(commonCodeService.getSubCommonCode(common_code), HttpStatus.OK);
		
		
		return entity;
	}
	
	//CKEditor 웹에디터를 통한 이미지 업로드
	@PostMapping("/imageUpload")
	public void imageUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload){
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		//클라이언트의 브라우저에게 보내는 정보
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename(); // 클라이언트에서 업로드한 원본파일명.
			byte[] bytes = upload.getBytes(); //업로드파일
			
			//서버측의 업로드폴더경로 작업, 1) 프로젝트 내부   2) 외부
			
			//1)프로젝트 내부 : 톰켓이 war 파일로 배포를 할 경우, 톰캣이 재시작하면 기존 upload폴더를 삭제한다.
			//String uploadPath = req.getSession().getServletContext().getRealPath("/")+"response\\upload\\";
			
			//2)외부폴더(프로젝트 관리하는 폴더가 아님) //server.xml  <Context docBase="c:\\LYS\\upload\\ckeditor" path="/upload/" reloadable="true"  />추가
			String uploadTomcatTempPath = "C:\\LYS\\upload\\ckeditor\\"; 
			
			log.info("외부 물리적 경로 : " + uploadTomcatTempPath);
			
			String uploadPath = uploadTomcatTempPath + fileName; //servlet-context.xml경로
			
			out = new FileOutputStream(new File(uploadPath)); //파일 입출력스트림 객체 생성(실제 폴더에 파일생성됨). 0byte
			out.write(bytes); // 출력스트림에 업로드된 파일을 가르키는 바이트 배열을 쓴다. 업로드된 파일크기
			
			//CK에디터에 보낼 파일정보작업
			printWriter = res.getWriter();
			
			//클라이언트에서 요청할 이미지 주소정보
			String fileUrl = "/upload/" + fileName;
			
			// {"filename":"abc.gif", "uploaded":1, "url":"/upload/abc.gif"} json포맷
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송 (return과 같은 역할: 클라이언트로 보냄)

			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {
					out.close();
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
			if(printWriter != null) {
				printWriter.close();
			}
		}
		
	}
	
	

	//상품저장
	@PostMapping("/adminProductInsert")
	public String adminProductInsert(ProductVO vo, RedirectAttributes rttr) {
		
		log.info("uploadPath " + uploadPath);
		//파일 업로드 작업
		String uploadDateFolderPath = UploadFileUtils.getFolder();
		vo.setGds_img_folder(uploadDateFolderPath); //날자 폴더명
		log.info("uploadDateFolderPath : " + uploadDateFolderPath);
		vo.setGds_img(UploadFileUtils.uploadFile(uploadPath, uploadDateFolderPath, vo.getUploadFile()));
		
		
		//Gds_prchs_yn의 파라미터가 Y가 아닐시 N
		if(vo.getGds_prchs_yn() == null) {
			vo.setGds_prchs_yn("N");
		}
		
		log.info("상품등록 정보 : " + vo); 
		
		
		//상품정보 저장
		if(Service.productInsert(vo) == ONE) {
			rttr.addFlashAttribute("msg", "GoodsSuccess");//로그인 완료시 메시지
		}else{
			rttr.addFlashAttribute("msg", "GoodsFail");//로그인 완료시 메시지
		}
		
		
		return "redirect:/admin/product/adminProductInsert";
	}
	
	//상품 목록
	@GetMapping("/adminProductList")
	public void adminProductList(Criteria cri, Model model ) {
		
		model.addAttribute("cateList", commonCodeService.getCommonCode());//1차 카테고리 정보
		
		log.info("cri : " + cri);

		//리스트
		List<ProductVO> list = Service.getProductList(cri);
		
		//gds_img_folder의 (\)를 (/)로 변환    \가 클라이언트에서 서버로 보내지는 데이터로 사용이 안됨.   
		for(int i=0; i<list.size(); i++) {
			String gdsImgFolder = list.get(i).getGds_img_folder().replace("\\", "/"); // File.separator운영체제 경로구분자
			list.get(i).setGds_img_folder(gdsImgFolder);
		}
		
		log.info("list : " + list);
		model.addAttribute("adminProductList", list);
		
		//총 갯수
		int total = Service.getProductTotalCount(cri);
		
		//페이징
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
		
		
	}
	
	
	
	
	//상품목록에서 이미지
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName){
		
		String resultFileName = folderName + "\\" + fileName; 
		
		//이미지를 바이트 배열로 호출
		return UploadFileUtils.getFile(uploadPath, resultFileName);
		
	}
	
	//상품수정 폼
	@GetMapping("/adminProductModify")
	public void adminProductModify(@RequestParam("gds_code") Integer gds_code, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("gds_code : " + gds_code);
		log.info("cri : " + cri);
		
		//1차카테고리 작업
		model.addAttribute("cateList", commonCodeService.getCommonCode());
		
		//상품정보
		ProductVO vo = Service.getProductByCode(gds_code);
		model.addAttribute("productVO", vo);
		
		//상품정보에서 1차카테고리 코드를  참조
		String cate_code = vo.getCate_code();
		model.addAttribute("subCateList", commonCodeService.getSubCommonCode(cate_code));
		
		
	}
	
	//상품수정
	@PostMapping("/adminProductModify")
	public String adminProductModify(ProductVO vo, Criteria cri ,RedirectAttributes rttr) {
		
		//상품 이미지 변경 여부 확인
		//상품 이미지를 변경한 경우
		if(!vo.getUploadFile().isEmpty()) {
			
			//상품등록 이미지 파일삭제
			UploadFileUtils.deleteFile(uploadPath, vo.getGds_img_folder() + "\\s_" + vo.getGds_img());
			
			
			//파일 업로드 작업
			String uploadDateFolderPath = UploadFileUtils.getFolder();
			vo.setGds_img_folder(uploadDateFolderPath); //날자 폴더명
			vo.setGds_img(UploadFileUtils.uploadFile(uploadPath, uploadDateFolderPath, vo.getUploadFile()));
		}
		
		//Gds_prchs_yn의 파라미터가 Y가 아닐시 N
		if(vo.getGds_prchs_yn() == null) {
			vo.setGds_prchs_yn("N");
		}
		
		log.info("상품등록 정보 : " + vo); 
		
		//상품정보 저장
		if(Service.getProductModify(vo) == ONE) {
			rttr.addFlashAttribute("msg", "mdifySuccess");//로그인 완료시 메시지
		}else{
			rttr.addFlashAttribute("msg", "mdifyFail");//로그인 완료시 메시지
		}
		
		return "redirect:/admin/product/adminProductList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
