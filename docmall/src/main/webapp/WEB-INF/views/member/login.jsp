<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	<script>
		/* 프로세스 완료 메시지 */
		let msg = "${msg}";
		if(msg == "idFail"){
			alert("아이디를 확인하세요.");
		}else if(msg == "passwdFail"){
			alert("비밀번호를 확인하세요.");
		}else 
	</script>
    
  </head>
  
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="mb-5 text-center">
	<h3>로그인</h3> 
</div>

<div class="my-5 container">
  <div class="mb-3 text-center">
	  <form id="loginForm" action="login" method="post">
		  <div class="form-group row">
		    <label for="mbr_id" class="col-sm-6 col-form-label">아이디</label>
		    <div class="col-sm-6">
		      <input type="text" class="form-control" id="mbr_id" name="mbr_id" placeholder="아이디를  8~15이내로 입력하세요">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-6 col-form-label">비밀번호</label>
		    <div class="col-sm-6">
		      <input type="password" class="form-control" id="mbr_pw" name="mbr_pw">
		    </div>
		  </div>
		  <div class="form-group row">
			  <div class="col-sm-12 text-center">
			  	<button type="submit" class="btn btn-dark" id="btnLogin">로그인</button>
			  	<button type="button" class="btn btn-dark" id="btnSearchIdPw">아이디/비밀번호 찾기</button>
			  </div>
		  </div>
	 </form>
  </div>


</div>
  <!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>

<%@include file="/WEB-INF/views/include/common.jsp" %>



	<script>
	/* 로그인  */
	/* html 문서와 내용을 브러우저가 읽고 난 이후 동작되는 특징 */
	$(document).ready(function(){

		let loginForm =  $("#loginForm");

		//로그인
		$("#loginForm").on("submit", function(){

			//유효성 검사
			//아이디 입력 확인
			if($("#mbr_id").val() == "") {
				alert("아이디를 입력하세요");
				$("#mbr_id").focus();
				return false;
			}

			//패스워드 입력 확인
			if($("#mbr_pw").val() == "") {
				alert("비밀번호를 입력하세요");
				$("#mbr_pw").focus();
				return false;
			}


			return true;				
		});




		//아이디,비번 찾기 폼
		$("#btnSearchIdPw").on("click", function(){
			location.href = "/member/lostpass";
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	});
	</script>

  </body>
</html>
    