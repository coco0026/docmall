/* 회원가입  */
//html 문서와 내용을 브러우저가 읽고 난 이후 동작되는 특징
		$(document).ready(function(){

			let joinForm =  $("#joinForm");

			//회원가입
			$("#btnJoin").on("click", function(){

				//유효성 검사

				//아이디 중복 체크 사용여부.
				if(!isIdCheck){
					alert("아이디 중복확인을 해주세요")
					return;

				}

				//메일 인증 확인 여부
		//		if(!isAuthCode){
		//			alert("메일 인증확인을 해주세요")
		//			return;
					
		//		}


				joinForm.submit();
			});

		

			// ID중복체크			
			let isIdCheck = false; // ID중복체크 플래그 변수
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

			//메일인증 확인
			let isAuthCode = false; //메일 인증확인 플래그 변수
			$("#btnMailConfirm").on("click",function(){

				let authCode = $("#mailAuthcode").val();

				$.ajax({
					url: '/member/confirmAuthCode',
					type: 'post',
					dataType: 'text',
					data:{ userAuthCode : authCode},
					success : function(result){
						if(result == 'success'){
							alert("인증이 완료되었습니다.");
							isAuthCode = true;
						}else if(result == 'fail'){
							alert("인증코드를 확인하세요.");
							isAuthCode = false;
						}
					}
						

				});


			});
				









			
		

	});
