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

	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
	  <h1 class="display-4">${ cate_code_child_nm}</h1>
	</div>
	

	<div class="container">

      <div class="row">
      	<c:forEach items="${productList }" var="productVO">
	        <div class="col-md-4">
	          <div class="card mb-4 shadow-sm">
	            <!-- <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"></rect><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg> -->
	            <!-- 상품이미지 -->
	            <a class="move" href="${productVO.gds_code}">
	            	<img alt="이미지준비" class="bd-placeholder-img card-img-top" width="100%" height="225"  
	            	src="/user/product/displayFile?folderName=${productVO.gds_img_folder}&fileName=s_${productVO.gds_img}" onerror="this.onerror=null; this.src='/img/noIMG.png'" /><!-- onerror 네트웍 상황에따라 이미지를 불러올 수 없을경우 대체이미지 -->	
	            </a>
	            <div class="card-body">
	              <p class="card-text">
	              	<c:out value="${productVO.gds_nm}" /><br>
	              	<fmt:setLocale value="ko_kr"/><fmt:formatNumber type="currency" maxFractionDigits="3" value="${productVO.gds_price}"></fmt:formatNumber>
	              </p>
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="btn-group">
	                  <button type="button" name="btnBuyCart" data-gds_code="${productVO.gds_code}" class="btn btn-sm btn-outline-secondary">Buy & Cart</button>
	                </div>
	                <small class="text-muted">리뷰 : 11</small>
	              </div>
	            </div>
	          </div>
	        </div>
        </c:forEach>
      </div>
      <div class="row">
      	<div class="col-12">
      		<nav aria-label="...">
				<ul class="pagination">
					<!-- 이전표시 -->
					<c:if test="${pageMaker.prev }">
						<li class="page-item">
						<a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
						</li>
					</c:if>
					<!-- 페이지번호 표시.  1  2  3  4  5 -->
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num" >
						<li class='page-item ${pageMaker.cri.pageNum == num ? "active": "" }'><a class="page-link" href="${num}">${num}</a></li>
					</c:forEach>
					<!-- 
					<li class="page-item active" aria-current="page">
					<span class="page-link">2</span>
					</li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					-->
					<!-- 다음표시 -->
					<c:if test="${pageMaker.next }">
						<li class="page-item">
						<a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
						</li>
					</c:if>
				</ul>
				<!--페이지 번호 클릭시 list주소로 보낼 파라미터 작업-->
				<form id="actionForm" action="" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
					<input type="hidden" name="type" value="${pageMaker.cri.type}">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					<input type="hidden" name="common_code_child" value="${common_code_child}">
					<input type="hidden" name="cate_code_child_nm" value="${cate_code_child_nm}">
				</form>
			</nav>
      	</div>
      </div>
      
	</div>
      <!--  footer.jsp -->
  	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
  
  
	
	
	<div class="modal fade" id="modalProductDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel"></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
			  <div class="row">
				  <div class="col-md-6">
						<img alt="" id="modal_detail_image" class="bd-placeholder-img card-img-top" width="100%" height="225"  src="/user/product/displayFile?folderName=${productVO.gds_img_folder}&fileName=s_${productVO.gds_img}" onerror="this.onerror=null; this.src='/img/noIMG.png'" /><!-- onerror 네트웍 상황에따라 이미지를 불러올 수 없을경우 대체이미지 -->
				  </div>
				<div class="col-md-6">
					<form>
						<div class="form-group row">
							<label for="gds_price" class="col-form-label col-3">상품명</label>
							<div class="col-9">
								<input type="text" class="form-control" id="gds_nm">
								<input type="hidden" class="form-control" id="gds_code">
							</div>
						</div>
						<div class="form-group row">
							<label for="gds_price" class="col-form-label col-3">판매가격</label>
							<input type="hidden" class="form-control" id="gds_code">
							<div class="col-9">
								<input type="text" class="form-control" id="gds_price" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label for="gds_cnt" class="col-form-label col-3">수량</label>
							<div class="col-9">
								<input type="number" class="form-control  w-25" id="cart_prchs_cnt" min="1" value="1">
							</div>
						</div>
					</form>
				</div>
			</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" name="btnModalBuy" class="btn btn-primary">BUY IT NOW</button>
	        <button type="button" name="btnModalCart" class="btn btn-primary">ADD TO CART</button>
	      </div>
	    </div>
	  </div>
	</div>	

	<script>

		$(function(){
			
			let actionForm = $("#actionForm"); // <form id="actionForm"> 참조
			let searchForm = $("#searchForm");
			
			// 페이지 번호 클릭시 동작.  이전	1	2	3	4	5  다음
			$("li.page-item a.page-link").on("click", function(e) {
				e.preventDefault(); // 태그의 기본특성을 제거. <a>태그의 링크기능을 제거.
				
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				
				let url = "/user/product/productList/${common_code_child}/" + encodeURIComponent("${cate_code_child_nm}");
	
				actionForm.attr("method", "get")
				actionForm.attr("action", url);
				actionForm.submit();


			});

			// 목록에서 제목을 클릭시 동작.(페이징 파라미터, 검색 파라미터, 글번호)
			$("a.move").on("click", function(e) {
				// $(this) : $("a.move") 선택자중 클릭된 a 태그
				e.preventDefault(); // <a>태그의 링크기능을 취소.
				let bno = $(this).attr("href");



				actionForm.find("input[name='bno']").remove();

				//<form>태그의 자식으로 추가됨.
				actionForm.append("<input type='hidden' name='bno' value='" + bno + "'>");
				actionForm.attr("action", "/board/get");

				actionForm.submit();


			});
			
			
			

			$("button[name='btnBuyCart']").on("click", function(){

				$('#modalProductDetail').modal('show');

				let url = "/user/product/productDetail/"+ $(this).data("gds_code");

				$.getJSON(url, function(result){

					//상품코드
					$("div#modalProductDetail input#gds_code").val(result.gds_code);
					//수량
					/* $("div#modalProductDetail input#cart_prchs_cnt").val(result.cart_prchs_cnt); */
					//판매가격
					$("div#modalProductDetail input#gds_price").val(result.gds_price);
					//상품이름
					$("div#modalProductDetail input#gds_nm").val(result.gds_nm);
					//상품이미지
					let url = "/user/product/displayFile?folderName="+result.gds_img_folder+"&"+"fileName"+result.gds_img;
					console.log("url : " + url);
					$("div#modalProductDetail input#modal_detail_image").attr("src",url);

				});

			});
			

			//장바구니 담기
			$("button[name='btnModalCart']").on("click", function(){

				$.ajax({
					url : '/user/cart/cart_add',
					data : {gds_code : $("div#modalProductDetail input#gds_code").val() , cart_prchs_cnt :$("div#modalProductDetail input#cart_prchs_cnt").val()},
					dataType : 'text',
					beforeSend : function(xmlHttpRequest) {
			            console.log("ajax xmlHttpRequest check");
			            xmlHttpRequest.setRequsetHeadr("AJAX", "true");
			      	},
					success : function(result){
						if(result == "success"){
							alert("장바구니에 추가되었습니다.");
							if(confirm("장바구니로 이동하시겠습니까?")){
								location.href = "/user/cart/cart_list";
							}

						}
					},
					error : function(xhr, status, error){
						
						if(xhr.status == 400){
							console.log(status);
							location.href = "/member/login";
						} 
						
					}
				});
				

			});
			
			//직접구매 클릭시 non-ajax
			$("button[name='btnModalBuy']").on("click", function(){

			let gds_code = $("div#modalProductDetail input#gds_code").val(); //구매상품코드
			let cart_prchs_cnt = $("div#modalProductDetail input#cart_prchs_cnt").val(); //구매수량

			location.href = "/user/order/orderListInfo?gds_code="+gds_code+"&cart_prchs_cnt="+cart_prchs_cnt+"&type=direct";
			


			});

			

			//상세화면
			$("div.container a.move").on("click",function(e){
				e.preventDefault();

				let gds_code = $(this).attr("href");

				actionForm.attr("method","get");
				actionForm.attr("action","/user/product/productDetail");
				
				actionForm.find("input[name='gds_code']").remove();
				
				actionForm.append("<input type='hidden' name='gds_code' value='"+gds_code+"'>");
				actionForm.submit();

			});











			
			
			
			
			
			
			
			
			
			

		});

	</script>

    
  </body>
</html>
    