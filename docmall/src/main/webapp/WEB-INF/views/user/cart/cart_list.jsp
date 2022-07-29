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
										<th scope="col">이미지</th>
										<th scope="col">제품명</th>
										<th scope="col">수량</th>
										<th scope="col">적립</th>
										<th scope="col">배송비</th>
										<th scope="col">가격</th>
										<th scope="col">취소</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${cartList }" var="CartVO">
											<c:set var="price" value="${CartVO.gds_price * CartVO.cart_prchs_cnt }"></c:set>
											<tr>
											<td scope="row">
												<a class="move" href="${List.gds_code }">
													<img src="/user/product/displayFile?folderName=${CartVO.gds_img_folder}&fileName=s_${CartVO.gds_img}" 
													style="height: 80px; width: 55px;" onerror="this.onerror=null; this.src='/img/noIMG.png'" /><!-- onerror 네트웍 상황에따라 이미지를 불러올 수 없을경우 대체이미지 -->
												</a>
											</td>
											<td>
												<input type="text" name="gds_nm" value="${CartVO.gds_nm }" readonly>
											</td>
											<td>
												<input type="hidden" name="gds_price" value="${CartVO.gds_price }">
												<input type="number" name="cart_prchs_cnt" value="${CartVO.cart_prchs_cnt }" >
												<button type="button" name="btnCntChange" data-cart_code="${CartVO.cart_code}" class="btn btn-info">수량변경</button>
											</td>
											<td> </td>
											<td><c:out value="" />[기본배송]조건</td>
											<td><span class="unitprice"><fmt:formatNumber type="number" maxFractionDigits="3"  value="${price }" /></span></td>
											<td>
												<button type="button" name="btnCartDel" data-cart_code="${CartVO.cart_code}" class="btn btn-info">취소</button>
											
											</td>
											</tr>
											<c:set var="sum" value="${sum + price }"></c:set>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<c:if test="${!empty cartList}">
												<td colspan="7" style="text-align: right;">총 금액 :<span id="cartTotalPrice"> <fmt:formatNumber type="number"  maxFractionDigits="3" value="${sum }" /> </span></td>
											</c:if>
											<c:if test="${empty cartList}">
												<td colspan="7" style="text-align: center;">등록된 상품이 없습니다</td>
											</c:if>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
						<div class="box-footer text-right">
							<button type="button" name="btnCartAllDel" class="btn btn-info">장바구니 비우기</button>
							<button type="button" name="btnProductList" class="btn btn-info">계속 쇼핑하기</button>
							<button type="button" name="btnOrder" class="btn btn-info">주문하기</button>
						</div>
					</div>
				</div>
			</div>
	</div>
      <!--  footer.jsp -->
  	  <%@include file="/WEB-INF/views/include/footer.jsp" %>

	<script>

		$(function(){

			//수량변경 버튼
			$("button[name='btnCntChange']").on("click",function(){

				let btnCntChange = $(this);

				let cart_code = $(this).data("cart_code");
				//$(this).prev().val();
				let cart_prchs_cnt = $(this).parent().find("input[name='cart_prchs_cnt'").val();

				console.log("cart_code : " + cart_code);
				console.log("cart_prchs_cnt : " + cart_prchs_cnt);

				$.ajax({
					url: '/user/cart/cartCntUpdate',
					type: 'get',
					data: { cart_code : cart_code , cart_prchs_cnt : cart_prchs_cnt},					
					dataType : 'text',
					success : function(result){
						if(result == "success"){
							alert("수량이 변경되었습니다.");
							location.reload();

							//개별상품 금액, 총금액 변경작업
							// let gds_price = btnCntChange.parent().find("input[name='gds_price']").val();
							// btnCntChange.parent().parent().find('span.unitprice').html($.numberWithCommas(gds_price * cart_prchs_cnt));

							// //총구매 가격 변경
							// let total_price = 0;
							// $("table#cartlistresult span.unitprice").each(function(index, item){
							// 	//console.log(item.html());
							// 	total_price += parseInt($.withoutCommas($(item).text()));
							// 	$("table#cartlistresult span#cartTotalPrice").text(total_price);  
							// });

						}
					}
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
			
			
			//장바구니 취소
			$("button[name='btnCartDel']").on("click",function(){

				let cart_code = $(this).data("cart_code");
				
				let gds_nm = $("input[name='gds_nm']").val();
				console.log(gds_nm);
				
				if(!confirm(cart_code + "번 상품을 삭제하시겠습니까?")) return;
				



				location.href = "/user/cart/cartDelete?cart_code="+cart_code;
			});
			
			
			//장바구니 전체 취소
			$("button[name='btnCartAllDel']").on("click",function(){
				
				if(!confirm("장바구니 상품을 전부 취소하시겠습니까?")) return;
				
				location.href = "/user/cart/cartAllDelete";

			});
			
			//주문하기
			$("button[name='btnOrder']").on("click",function(){
				
				
				location.href = "";

			});
			
			//list이동
			$("button[name='btnProductList']").on("click",function(){
				
				if(!confirm("장바구니 상품을 전부 취소하시겠습니까?")) return;
				
				location.href = "/user/product/productList";

			});
			
			
			
			
			
			

		});

	</script>

    
  </body>
</html>
    