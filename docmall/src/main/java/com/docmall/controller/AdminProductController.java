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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.docmall.domain.CommonCodeVO;
import com.docmall.service.AdminService;
import com.docmall.service.CommonCodeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/product/*")
@Controller
public class AdminProductController {
	
	@Resource(name = "uploadPath") //Bean중에 uploadPath bean 객체를 찾아, 아래 변수에 주입
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private CommonCodeService commonCodeService;
	
	//상품 등록 폼 
	@GetMapping("/adminProductInsert")
	public void productInsert(Model model) {
		
		model.addAttribute("cateList", commonCodeService.getCommonCode());//1차 카테고리 정보
	}
	
	//2차카테고리 정보
	@ResponseBody
	@GetMapping("/subCategoryList/{common_code}") ///subCategoryList/{1차카테고리코드(REST)}
	public ResponseEntity<List<CommonCodeVO>> subCategoryList(@PathVariable("common_code") Integer common_code){ //@PathVariable 경로 주소의 일부분을 파라미터로 참조시 사용
		
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
			
			uploadPath = uploadTomcatTempPath + fileName; //servlet-context.xml경로
			
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
	
	
	
	
	//상품 저장
	
	

}