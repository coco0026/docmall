<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"  id="bootstrap-css">
<link rel="stylesheet" href="/css/adminLogin.css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<script>
	/* 프로세스 완료 메시지 */
	let msg = "${msg}";
	if(msg == "idFail"){
		alert("아이디를 확인하세요.");
	}else if(msg == "passwdFail"){
		alert("비밀번호를 확인하세요.");
	}else if(msg == "logout"){
		alert("로그아웃 되었습니다.");
	}
		
</script>

</head>
<body>
	<div>
		<form id="adminLoginForm" action="adminLogin" method="post">
			<div class="sidenav">
	        	<div class="login-main-text">
	            	<h2>Manager<br> Login Page</h2>
	            	<p>Login from here to access.</p>
	         	</div>
	      	</div>
	        <div class="main">
	         <div class="col-md-6 col-sm-12">
	            <div class="login-form">
	               <form>
	                  <div class="form-group">
	                     <label>Manager ID</label>
	                     <input type="text" class="form-control" id="mngr_id" name="mngr_id" placeholder="Manager ID">
	                  </div>
	                  <div class="form-group">
	                     <label>Password</label>
	                     <input type="password" class="form-control" id="mngr_pw" name="mngr_pw" placeholder="Password">
	                  </div>
	                  <button type="button" class="btn btn-black" id="btnAdminLogin">Login</button>
	                  <!-- <button type="submit" class="btn btn-secondary">Register</button> -->
	               </form>
	            </div>
	         </div>
	        </div>
    	</form>  
    </div>
    
    <script>
    
    $(document).ready(function(){
		let adminLoginForm =  $("#adminLoginForm");

		//로그인
		$("#btnAdminLogin").on("click", function(){

			//유효성 검사
			//아이디 입력 확인
			if($("#mngr_id").val() == "") {
				alert("아이디를 입력하세요");
				$("#mngr_id").focus();
				return false;
			}

			//패스워드 입력 확인
			if($("#mngr_pw").val() == "") {
				alert("비밀번호를 입력하세요");
				$("#mngr_pw").focus();
				return false;
			}
			
			adminLoginForm.submit();


		});















		
	});
    
    </script>
    
 </body>
 
 </html>