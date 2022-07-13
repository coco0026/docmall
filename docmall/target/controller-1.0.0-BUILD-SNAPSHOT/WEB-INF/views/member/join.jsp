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
    
    
    <!-- 다음API Script -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	    
	    
	</script>
	<!-- 다음API Script -->

    
  </head>
  
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<h3>회원가입</h3> 

<div class="container">
  <div class="mb-3 text-center">
	  <form id="joinForm" action="join" method="post">
		  <div class="form-group row">
		    <label for="mbr_id" class="col-sm-2 col-form-label">아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="mbr_id" name="mbr_id" placeholder="아이디를  8~15이내로 입력하세요">
		    </div>
		    <div class="col-sm-1-left">
		      <button type="button" class="btn btn-outline-info" id="btnIdCheck">ID중복체크</button>
		    </div>
		    <label for="mbr_pw" class="col-sm-4 col-form-label" id="idCheckStatus">
		    	
		    </label>
		  </div>
		  <div class="form-group row">
		    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="mbr_pw" name="mbr_pw">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="mbr_pw_chck" class="col-sm-2 col-form-label">비밀번호확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="mbr_pw_chck">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="mbr_nm" class="col-sm-2 col-form-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="mbr_nm" name="mbr_nm">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="mbr_eml_addr" class="col-sm-2 col-form-label">전자우편</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="mbr_eml_addr" name="mbr_eml_addr">
		    </div>
		    <div class="col-sm-1-left">
		      <button type="button" class="btn btn-outline-info" id="btnAuthcode">인증요청</button>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="staticEmail" class="col-sm-2 col-form-label">인증코드</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="mailAuthcode">
		    </div>
		    <div class="col-sm-1-left">
		      <button type="button" class="btn btn-outline-info" id="btnMailConfirm">인증확인</button>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="mbr_telno" class="col-sm-2 col-form-label">휴대폰 번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="mbr_telno" name="mbr_telno">
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="sample6_postcode" class="col-sm-2 col-form-label">우편번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="sample6_postcode" name="mbr_zip" placeholder="우편번호" readonly>
		    </div>
		    <div class="col-sm-1-left">
		      <button type="button"  class="btn btn-outline-info" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="sample6_address" class="col-sm-2 col-form-label">주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="sample6_address" name="mbr_addr" readonly>
		    </div>
		  </div>
		  <div class="form-group row">
		    <label for="sample6_detailAddress" class="col-sm-2 col-form-label">상세주소</label>
		    <div class="col-sm-5">
		      <input type="text" class="form-control" id="sample6_detailAddress" name="mbr_daddr">
		      <input type="hidden" id="sample6_extraAddress">
		    </div>
		  </div>
		  <div class="form-group row">
		      <label class="form-check-label col-sm-2" for="defaultCheck1">메일 수신동의</label>
			  <div class="col-sm-10 text-left">
			  	<input class="form-check-input" type="checkbox" value="Y" id="mbr_eml_addr_yn" name="mbr_eml_addr_yn">
			  </div>			
		  </div>
		  <div class="form-group row">
			  <div class="col-sm-12 text-center">
			  	<button type="button" class="btn btn-dark" id="btnJoin">회원가입</button>
			  </div>			
		  </div>
	 </form>
  </div>


</div>
  <!--  footer.jsp -->
<%@include file="/WEB-INF/views/include/footer.jsp" %>

<%@include file="/WEB-INF/views/include/common.jsp" %>



	<script type="text/javascript" src="/js/member/join.js"></script>

  </body>
</html>
    