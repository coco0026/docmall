/* 회원가입  */
//html 문서와 내용을 브러우저가 읽고 난 이후 동작되는 특징
		$(document).ready(function(){

			let joinForm =  $("#joinForm");

			//회원가입
			$("#joinSend").on("click", function(){

				//유효성 검사

				joinForm.submit();
			});

		

			// ID중복체크			
			let isIdCheck = false;
			$("#btnIdCheck").on("click", function(){				
				
				//아이디 입력 확인
				if($("#mbr_id").val() == "") {
					alert("아이디를 입력하세요");
					$("#mbr_id").focus();
					return;
				}
			

			$.ajax({
				url: '/member/idCheck',
				type: "get",
				dataType: 'text',
				data:{ mbr_id : $("#mbr_id").val()},
				success : function(result){

					console.log(result);
					$("#idCheckStatus").css({'display':'inline'});
					
					if(result == "yes"){ //ID사용 가능						
						$("#idCheckStatus").html("<p class='text-muted'><small>"+$("#mbr_id").val()+"는 사용 가능한 아이디입니다.</small></p>");
						isIdCheck = true;
					}else{ //ID사용 불가능
						$("#idCheckStatus").html("<p class='text-muted'><small>"+$("#mbr_id").val()+"는 사용 불가능한 아이디입니다.</small></p>");
						isIdCheck = false;
					}
				}
			})






			
		});

	});
