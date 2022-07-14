<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>DocMall Shopping</title>

<meta name="theme-color" content="#563d7c">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="pricing.css" rel="stylesheet">
    
    
    
  </head>
  
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="mb-5 text-center">
	<h3>아이디/비밀번호 찾기 결과</h3> 
</div>

<div class="container">
  <div class="mb-3 text-center">
  	
  	
  	<!-- 아이디 찾기 -->
  	<c:if test="${mbrID != null}">
	  	<p>ID : ${mbrID} </p>
	  	전체 아이디는 고객센터로 문의해 주세요
  	</c:if>
  	
  	<!-- 임시비밀번호 발급 -->
  	<c:if test="${mail != null }">
	  	<p>메일 발송을 완료했습니다.</p>
  	</c:if>
  
  </div>
</div>
  <!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>

<%@include file="/WEB-INF/views/include/common.jsp" %>



	<script>
		$(document).ready(function(){
			
	
				
		});

	</script>

  </body>
</html>
    