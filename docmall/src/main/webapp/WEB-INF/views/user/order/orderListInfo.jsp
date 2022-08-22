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
    <title>DocMall Shop</title>

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
    
    <%@include file="/WEB-INF/views/include/common.jsp" %>
    
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
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>



	<div class="container">
	
		<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
						<div class="box-header">
							LIST CART				
						</div>
						<div class="box-body">
						
							<div class="col-sm-12">
								<table class="table table-hover" id="cartlistresult">
									<thead>
										<tr>
										<th scope="col">상품</th>
										<th scope="col">수량</th>
										<!-- <th scope="col">할인</th> -->
										<th scope="col">적립금</th>
										<th scope="col">주문금액</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cartOrderList }" var="cartOrderInfoVO">
										
											<c:set var="price" value="${cartOrderInfoVO.gds_price * cartOrderInfoVO.cart_prchs_cnt }"></c:set>
											<%--<c:set var="discount" value="${(cartOrderInfoVO.gds_price * cartOrderInfoVO.gds_dscnt)/100}"></c:set><!-- 수량당 할인금액 -->
											<c:set var="totDiscount" value="${discount*cartOrderInfoVO.cart_prchs_cnt}"></c:set><!-- 할인금액*수량 -->
											<c:set var="resultDiscount" value="${price-totDiscount}"></c:set><!-- 할인율 적용한 주문금액 --> --%>
											
											<c:set var="gradeDiscount" value="${ (cartOrderInfoVO.grade_dscnt*price)/100}"></c:set><!-- 등급별 적립금 -->
											<tr>
											<td scope="row">
												<a class="move" href="">
													<img src="/user/order/displayFile?folderName=${cartOrderInfoVO.gds_img_folder}&fileName=s_${cartOrderInfoVO.gds_img}" 
													style="height: 80px; width: 55px;" onerror="this.onerror=null; this.src='/img/noIMG.png'" /><!-- onerror 네트웍 상황에따라 이미지를 불러올 수 없을경우 대체이미지 -->
												</a>
												<c:out value="${cartOrderInfoVO.gds_nm}" />
											</td>
											<td>
												<c:out value="${cartOrderInfoVO.cart_prchs_cnt }"></c:out>
											</td>
											<%-- <td>
												-<fmt:formatNumber value="${totDiscount}" /><!-- 총 할인금액(수량) -->
											</td> --%>
											<td>
												<fmt:formatNumber value="${gradeDiscount}" />
											</td>
											<td>
												<span class="unitprice"><fmt:formatNumber type="number" maxFractionDigits="3"  value="${price }" /></span>
											</td>
											</tr>
											<c:set var="sum" value="${sum + price }"></c:set>
											<c:set var="sumPoint" value="${sumPoint + gradeDiscount }"></c:set>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<c:if test="${!empty cartOrderList}">
												<td colspan="4" style="text-align: right;">
													총 금액 :<span id="oderTotalPrice"> <fmt:formatNumber type="number"  maxFractionDigits="3" value="${sum }" /> </span>/
													총 적립금 :<span id="mbr_point_ny"> <fmt:formatNumber type="number"  maxFractionDigits="3" value="${sumPoint }" /> </span>
												</td>
											</c:if>
											<c:if test="${empty cartOrderList}">
												<td colspan="4" style="text-align: center;">등록된 상품이 없습니다</td>
											</c:if>
										</tr>
									</tfoot>
								</table>
							</div>
							
							
							<form id="orderForm" action="join" method="post">
								<h5>주문자 정보</h5>
								  <div class="form-group row">
								    <label for="mbr_nm" class="col-sm-2 col-form-label">이름</label>
								    <div class="col-sm-4">
								      <span id="mbr_nm" name="mbr_nm" ><c:out value="${loginStatus.mbr_nm }" /></span>
								    </div>
								  </div>
								  <div class="form-group row">
								    <label for="mbr_eml_addr" class="col-sm-2 col-form-label">전자우편</label>
								    <div class="col-sm-4">
								      <span id="mbr_eml_addr" name="mbr_eml_addr" ><c:out value="${loginStatus.mbr_eml_addr }" /></span>
								    </div>
								  </div>
								  <div class="form-group row">
								    <label for="mbr_telno" class="col-sm-2 col-form-label">휴대폰 번호</label>
								    <div class="col-sm-4">
								      <span id="mbr_telno" name="mbr_telno" ><c:out value="${loginStatus.mbr_telno }" /></span>
								    </div>
									<label for="mbr_pw" class="col-sm-5 col-form-label" id="telNoCheckStatus"></label>
								  </div>
								  <div class="form-group row">
								    <label for="mbr_telno" class="col-sm-2 col-form-label">회원등급</label>
								    <div class="col-sm-4">
								      <span id="mbr_telno" name="mbr_telno" ><c:out value="${loginStatus.common_code_child_nm }" /></span>
								    </div>
									<label for="mbr_pw" class="col-sm-5 col-form-label" id="telNoCheckStatus"></label>
								  </div>
								  
								  <hr>
								  
								  <h5>배송지 정보</h5>
								  <div class="form-group row">
								    <label for="mbr_nm" class="col-sm-2 col-form-label">이름</label>
								    <div class="col-sm-4">
								      <input type="text" class="form-control" id="order_mbr_nm" name="order_mbr_nm" value="${loginStatus.mbr_nm }" >
								      <input type="hidden" class="form-control" id="order_tot_amt" name="order_tot_amt" value="${sum }" >
								      <input type="hidden" class="form-control" id="mbr_id" name="mbr_id" value="${loginStatus.mbr_id }" >
								    </div>
								  </div>
								  <div class="form-group row">
								    <label for="mbr_telno" class="col-sm-2 col-form-label">휴대폰 번호</label>
								    <div class="col-sm-4">
								      <input type="text" class="form-control" id="order_mbr_telno" name="order_mbr_telno" value="${loginStatus.mbr_telno }">
								    </div>
									<label for="mbr_pw" class="col-sm-5 col-form-label" id="telNoCheckStatus"></label>
								  </div>
								  <div class="form-group row">
								    <label for="sample6_postcode" class="col-sm-2 col-form-label">우편번호</label>
								    <div class="col-sm-4">
								      <input type="text" class="form-control" id="sample6_postcode" name="order_mbr_zip" value="${loginStatus.mbr_zip }" readonly >
								    </div>
								    <div class="col-sm-1-left">
								      <button type="button"  class="btn btn-outline-info" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
								    </div>
								  </div>
								  <div class="form-group row">
								    <label for="sample6_address" class="col-sm-2 col-form-label">주소</label>
								    <div class="col-sm-4">
								      <input type="text" class="form-control" id="sample6_address" name="order_mbr_addr" value="${loginStatus.mbr_addr }" readonly>
								    </div>
								  </div>
								  <div class="form-group row">
								    <label for="sample6_detailAddress" class="col-sm-2 col-form-label">상세주소</label>
								    <div class="col-sm-4">
								      <input type="text" class="form-control" id="sample6_detailAddress" name="order_mbr_daddr" value="${loginStatus.mbr_daddr }">
								      <input type="hidden" id="sample6_extraAddress">
								    </div>
								  </div>
								  <div class="form-group row">
								    <label for="pay_method" class="col-sm-2 col-form-label">결제방법</label>
								    <div class="col-sm-4">
									    <select name="pay_method" id="pay_method" class="form-control" >
									      <option value="">결제방법을 선택하세요.</option>
									      <option value="무통장">무통장입금</option>
									      <option value="카카오페이">카카오페이</option>
									      <option value="휴대폰">휴대폰 결제</option>
									      <option value="신용카드">신용카드</option>
									    </select>
								    </div>
								  </div>
								  <div class="form-group row">
								  	<label for="bank" class="col-sm-2 col-form-label"></label>
								  	<div class="col-sm-4">
									    <select name="bank" id="bank" class="form-control" style="display: none;">
									      <option value="">은행을 선택하세요.</option>
									      <option value="111-11111-11111">국민은행(111-11111-11111)</option>
									      <option value="222-22222-22222">신한은행(222-22222-22222)</option>
									    </select>
									</div>
								    <input type="hidden" id="pay_nobank" name="pay_nobank" value="">
								    <input type="hidden" id="pay_nobank_price" name="pay_nobank_price" value="${sum }">
								  </div>
								  <div class="form-group row">
								    <label for="pay_nobank_user_nm" class="col-sm-2 col-form-label" id="pay_nobank_user_nm_label" style="display: none;">입금자명</label>
								    <div class="col-sm-4">
								       <input type="text" class="form-control" id="pay_nobank_user_nm" name="pay_nobank_user_nm" style="display: none;">
								    </div>
								  </div>
																  
							 </form>
							
							
							
						</div>
						<div class="box-footer text-right">
							<button type="button" id="btnOrder" class="btn btn-info">주문하기</button>
							<img id="kakao_pay" alt="kako pay" src="/img/payment_icon_yellow_medium.png" style="display: none;">
							<button type="button" id="btnCancel" class="btn btn-info">주문취소</button>
						</div>
					</div>
				</div>
			</div>
	</div>
      <!--  footer.jsp -->
  	  <%@include file="/WEB-INF/views/include/footer.jsp" %>

	<script>

		$(function(){
			
			//결제방법 선택
			let pay_method;
			$("#pay_method").on("change",function(){
				if($("#pay_method option:selected").val() == ""){
					alert("결제 방법을 선택하세요."); return;
				}
				
				if($("#pay_method option:selected").val() == "카카오페이"){
					pay_method = $("#pay_method option:selected").val();
					$("img#kakao_pay").css("display", "inline");
					$("#btnOrder").css("display", "none");
					$("#bank").css("display", "none");
					$("#pay_nobank_user_nm").css("display", "none");
					$("#pay_nobank_user_nm_label").css("display", "none");
					return;
				}else if($("#pay_method option:selected").val() == "무통장"){
					$("img#kakao_pay").css("display", "none");
					$("#btnOrder").css("display", "inline");
					$("#bank").css("display", "inline");
					$("#pay_nobank_user_nm").css("display", "inline");
					$("#pay_nobank_user_nm_label").css("display", "inline");
				}else{
					$("img#kakao_pay").css("display", "none");
					$("#btnOrder").css("display", "inline");
					$("#bank").css("display", "none");
					$("#pay_nobank_user_nm").css("display", "none");
					$("#pay_nobank_user_nm_label").css("display", "none");
				}

			});
			//카카오페이 버튼 클릭(ajax)
			$("img#kakao_pay").on("click", function(){
				
				//kakao pay에서 요청하는 필수 입력값 작업.
				//주문자
				let odr_name = $("input[name='order_mbr_nm']").val();
				//연락처 
				let odr_phone = $("input[name='order_mbr_telno']").val();
				//전자우편
				let odr_email = $("#mbr_eml_addr").val();
				//전체금액 odr_total_price
				let odr_total_price = $("input[name='pay_nobank_price']").val();
	
				//단위금액
				//할인이 적용된 금액
				//적립금
				//쿠폰
	
				$.ajax({
					url: '/user/order/orderPay',
					type: 'get',
					data: {
						totalAmount : odr_total_price,
						order_mbr_nm : $("input[name='order_mbr_nm']").val(),
						order_mbr_zip : $("input[name='order_mbr_zip']").val(),
						order_mbr_addr : $("input[name='order_mbr_addr']").val(),
						order_mbr_daddr : $("input[name='order_mbr_daddr']").val(),
						order_mbr_telno : $("input[name='order_mbr_telno']").val(),
						odr_total_price : odr_total_price,
						Payment_process : 'B11', //배송준비

						pay_method : $("#pay_method option:selected").val(),
						pay_tot_price : odr_total_price,
					},
					success: function(response) {
						//alert(response.next_redirect_pc_url);
						location.href = response.next_redirect_pc_url;
					}
	
				});
			});

			//무통장입금시 은행선택
			$("#bank").on("change",function(){
				if($("#bank option:selected").val() == ""){
					alert("은행을 선택하세요."); return;
				}

				$("#pay_nobank").val($("#bank option:selected").text().substring(0, 4));

			});



			//주문
			$("#btnOrder").on("click",function(){
				if($("#pay_method").val() == ""){
					alert("결제방법을 선택하세요."); return;
				}



				$("#orderForm").attr("action","/user/order/orderSave?type="+"무통장");
				$("#orderForm").submit();
				
			});

		


			

		});
		
		
		
		
		//숫자값 3자리마다 컴마
		$.numberWithCommas = function(x){
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		//3자리마다 컴마 제거
		$.withoutCommas = function (x) {
			return x.toString().replace(",", '');
		}

	</script>

    
  </body>
</html>
    