<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white">
	  <h5 class="my-0 mr-md-auto font-weight-normal">
	  	<!-- <a class="nav-link text-dark" href="/">EzenShop</a> -->
	  </h5>
	  
	    <!-- Session정보 없을때 (비로그인시) -->
	  	<c:if test="${sessionScope.loginStatus == null }">
		  <nav class="my-2 my-md-0 mr-md-3">
		    <a class="p-2 text-dark" href="/member/join">JOIN</a>
		  </nav>
		 	<a class="btn btn-outline-primary" href="/member/login">LOGIN</a>
		 </c:if>
		 
		 <!-- Session정보 있을때 (로그인시) -->
		 <c:if test="${sessionScope.loginStatus != null }">
			  <nav class="my-2 my-md-0 mr-md-3">
			  	${loginStatus.mbr_nm}님 환영합니다.
			  	
			    <a class="p-2 text-dark" href="/member/confirmPw">MODIFY</a> |
			    <a class="p-2 text-dark" href="#">MYPAGE</a> |
			    <a class="p-2 text-dark" href="#">ORDER</a> |
			    <a class="p-2 text-dark" href="/user/cart/cart_list">CART</a>
			  </nav>
			  <a class="btn btn-outline-primary" href="/member/logout">LOGOUT</a>
		 </c:if>
		 
		 
	</div>
