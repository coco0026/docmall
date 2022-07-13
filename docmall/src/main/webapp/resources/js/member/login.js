/* 로그인  */
//html 문서와 내용을 브러우저가 읽고 난 이후 동작되는 특징
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
				alert("asdf");
				location.href = "/member/lostpass";
			});











			

			
		

	});
