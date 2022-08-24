package com.docmall.interceptor;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.docmall.domain.MemberVO;

import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Log4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		boolean result = false;
		
		//인증된 사용자인지 여부를 체크. 세션객체를 확인.
		HttpSession session = request.getSession();
		MemberVO user =  (MemberVO)session.getAttribute("loginStatus");
		
		if(user == null) { //인증정보 존재하지 않음. 비로그인
			result = false;
			
			if(isAjaxRequest(request)) {
				response.sendError(400); //ajax요청시 400에러 리턴
			}else {
				getDestination(request);///요청한 주소 저장
				response.sendRedirect("/member/login");
			}
			
		}else { //인증정보 존재. 로그인
			result = true;
		}
		
		log.info("result : " + result);
		return result; // true면, 다음진행은 컨트롤러로 제어가 넘어간다.
	}

	/**
	 * ajax요청을 체크
	 * @param request 요청한 주소
	 * @return
	 */
	private boolean isAjaxRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		boolean isAjax = false;
		
		// ajax구문에서 요청시 헤더에 AJAX : "true"를 작업해두어야 한다.
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			isAjax = true;
		}
		
		return isAjax;
	}

	/**
	 * 
	 * @param request 요청한 주소
	 */
	private void getDestination(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
											   ///product/cart?gds_code=10
		String uri = request.getRequestURI(); // 브라우저가 요청한 주소. /product/cart
		String query = request.getQueryString(); // 파라메터값.   gds_code=10
		
		log.info("uri : " + uri);
		log.info("query : " + query);
		
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		String destination = uri + query;
		
		log.info("destination : " + destination);
		
		if(request.getMethod().equals("GET")) {
			// 사용자가 비로그인 상태에서 요청한 원래 주소를 세션으로 저장
			request.getSession().setAttribute("dest", destination);
		}
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	
	

}
