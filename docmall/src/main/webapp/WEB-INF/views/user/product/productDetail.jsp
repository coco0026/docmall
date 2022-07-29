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

	  /* 상품후기 별 평점 */
	  #star_review_score a.rv_score{
		  font-size: 22px;
		  text-decoration: none;
		  color: lightgray;

	  }

	  #star_review_score a.rv_score.on{
			color: black;
	  }



    </style>
    
    <%@include file="/WEB-INF/views/include/common.jsp" %>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
    <!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
  	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    
    
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/categoryMenu.jsp" %>

	<div class="pricing-header px-3 py-3 pt-md-5 pb-md-4 mx-auto text-center">
	  <h1 class="display-4">${ cate_code_child_nm}</h1>
	</div>
	

	<div class="container">

      <div class="row">
      	<div class="col-6">
      		<img alt="이미지준비" class="bd-placeholder-img card-img-top" width="100%" height="225"  
           	src="/user/product/displayFile?folderName=${productVO.gds_img_folder}&fileName=${productVO.gds_img}" onerror="this.onerror=null; this.src='/img/noIMG.png'" /><!-- onerror 네트웍 상황에따라 이미지를 불러올 수 없을경우 대체이미지 -->	
      	</div>
      	<div class="col-6">
      		<h5>${productVO.gds_nm}</h5>
      		<p>가격 : <fmt:formatNumber type="number"  maxFractionDigits="3" value="${productVO.gds_price }" /> </p>
      		<p>
      			수량 : <input type="number" class="form-control w-25" id="cart_prchs_cnt" min="1" value="1">
      			<input type="hidden" id="gds_code" name="gds_code" value="${productVO.gds_code }">
      		</p>
      	</div>
      </div>
      
      <div class="box-footer text-right">
		<button type="button" name="btnOrder" class="btn btn-info">구매하기</button>
		<button type="button" name="btnCart" class="btn btn-info">장바구니</button>
	  </div>
	  
	  <div class="row">
		<div class="col-12">
			<div id="productDetailTab">
			  <ul>
			    <li><a href="#productDetailInfo">상세정보</a></li>
			    <li><a href="#productDetailReview">상품리뷰</a></li>
			  </ul>
			  <div id="productDetailInfo">
			    <p>${productVO.gds_cn }</p>
			  </div>
			  <div id="productDetailReview">
				<div class="row">
					<div class="col-6">REVIEW</div>
					<div class="col-6">
						<button type="button" id="btnReview" class="btn btn-info">리뷰 쓰기</button>
					</div>
				</div>			  
			  </div>
			</div>
		</div>
	  </div>
      
	</div>
	
	
      <!--  footer.jsp -->
  	  <%@include file="/WEB-INF/views/include/footer.jsp" %>
  
  
	
	

	<script>

		$(function(){
			
			//jquery-ui tab작업
			$("#productDetailTab").tabs();
			



			//상품후기 팝업대화상자
			$("div#productDetailReview button#btnReview").on("click", function(){

				$("#reviewModal").modal('show');

			});



			//평점 클릭시 별색상 변경
			$("#star_review_score a.rv_score").on("click",function(e){

				e.preventDefault();

				$(this).parent().children().removeClass("on");
				$(this).addClass("on").prevAll("a").addClass("on");



			});
			
			
			//상품 후기 쓰기
			$("#btnRevieWrite").on("click",function(){

				let rv_score = 0;
				let rv_cn = $("#rv_cn").val();
				let gds_code = $("#gds_code").val();

				$("#star_review_score a.rv_score").each(function(index,item){
					if($(this).attr('class') == 'rv_score on'){
						rv_score += 1;
					}
				});

				console.log("rv_score : " + rv_score);


				if(rv_score == 0){
					alert("평점을 선택해주세요."); return;
				}

				if(rv_cn == ""){
					alert("리뷰를 작성해주세요."); return;
				}

				let data = {"gds_code" : gds_code,  "review_score" : rv_score,  "review_cn" : rv_cn};
				$.ajax({
					url : '/user/review/new',
					headers : {
						"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
					},
					type : 'post',
					dataType : 'text',
					data : JSON.stringify(data),
					success : function(result){
						if(result == "success"){
							alert("상품후기가 등록되었습니다.");
							
							//상품후기 목록
							$.getJSON("/user/review/list/123/1", function(data){
								console.log("목록 : " + data.list[0].);
							});
							
							
							// 상품후기 대화상자 숨김
							$("#reviewModal").modal('hide');
							$("#star_review_score a.rv_score").parent().children().removeClass("on");
							rv_cn.val("");
							
						}
					}

						
				});

				










			});








			
			
			
			
			
			

		});

	</script>
	
	
	<!-- 상품후기 modal dialog -->
	<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">New message</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="col-form-label">상품평점:</label>
				<p id="star_review_score">
					<a class="rv_score" href="#">★</a>
					<a class="rv_score" href="#">★</a>
					<a class="rv_score" href="#">★</a>
					<a class="rv_score" href="#">★</a>
					<a class="rv_score" href="#">★</a>
				</p>	            
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="col-form-label">Message:</label>
	            <textarea class="form-control" id="rv_cn"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" id="btnRevieWrite" class="btn btn-primary">Send message</button>
	      </div>
	    </div>
	  </div>
	</div>

    
  </body>
</html>
    