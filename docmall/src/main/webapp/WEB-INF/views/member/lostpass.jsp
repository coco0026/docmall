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
    
  </head>
  
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>
<div class="mb-5 text-center">
	<h3></h3> 
</div>

<div class="container">
  <div class="mb-3 text-center row">
  	<div class="row">
  		<!-- 아이디찾기 -->
		<div class="col-6">
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
						<button type="submit" class="btn btn-dark" id="btnLogin">아이디 찾기</button>
						<button type="button" class="btn btn-dark" id="btnSearchIdPw">로그인</button>
					</div>
				</div>
	 		</form>
 		</div>
 		
 		<!-- 임시비밀번호 발급 -->
 		<div class="col-6">
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
						<button type="submit" class="btn btn-dark" id="btnLogin">임시 비밀번호 발급</button>
						<button type="button" class="btn btn-dark" id="btnSearchIdPw">로그인</button>
					</div>
				</div>
	 		</form>
 		</div>
	</div>
  </div>


</div>
  <!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>

<%@include file="/WEB-INF/views/include/common.jsp" %>



	<script>
		$(document).ready(function(){
	
			//메일 인증코드 요청
			$("#btnAuthcode").on("click",function(){
				
				if($("#mbr_eml_addr").val() == ""){
					alert("메일주소를 입력하세요.");
					return;
				}


				$.ajax({
					url: '/email/send',
					type: 'get',
					dataType: 'text',
					data:{ receiveMail : $("#mbr_eml_addr").val()},
					success : function(result){
						if(result == "success"){
							alert("메일이 발송되었습니다. 인증코드를 확인하세요.");
						}else{
							alert("메일발송이 실패되어, 메일주소 확인 또는 관리자에게 문의 바랍니다.");
						}
					}
						

				});

			});
	
	
				
		});

	</script>

  </body>
</html>
    