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
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

	<script id="reviewTemplate" type="text/x-handlebars-template">
		{{#each .}}
		<div class="list-group">
			<div class="d-flex w-100 justify-content-between">
			  <h6 class="mb-1">{{mbr_id}}</h6>
			  <small>평점 : {{review_score}}</small>
			</div>
			<p class="mb-1">{{review_cn}}</p>
			<small>{{prettifyDate review_reg_date}}</small>
		</div>
		<hr>
		{{/each}}
	</script>

  	
    
    
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
					<div class="col12">REVIEW</div>
					
					<!-- 리뷰 리스트 위치 -->
					<div id="reviewListResult" class="col-12"></div>
					
					<div class="col12">
						<button type="button" id="btnReview" class="btn btn-info">리뷰 쓰기</button>
					</div>
				</div>	
				
				<!--상품후기 페이징 출력위치-->
		        <div>
		          <nav aria-label="Page navigation example">
		            <ul class="pagination" id="reviewPagingResult">
		            </ul>
		          </nav>
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

							reviewPage = 1;
							//  "/user/review/list/123/1",
							url = "/user/review/list/" + ${productVO.gds_code } + "/" + reviewPage;
							
							
							// 상품후기 대화상자 숨김
							$("#reviewModal").modal('hide');
							$("#star_review_score a.rv_score").parent().children().removeClass("on");
							rv_cn.val("");
							
						}
					}

						
				});
		});




			let reviewPage = 1;
			let url = "/user/review/list/" + ${productVO.gds_code } + "/" + reviewPage;		
			
			getPage(url);

			function getPage(pageInfo){
				//상품후기 목록
					$.getJSON(pageInfo, function(data){
					//console.log("목록 : " + data.list[0].gds_code);
					//console.log("목록 : " + data.pageMaker.startPage);

					if(data.list.length > 0){

						//상품후기목록
						printReviewList(data.list, $("#reviewListResult"), $("#reviewTemplate"));

						//페이징
						printReviewPaging(data.pageMaker, $("#reviewPagingResult"));

					}




					});
						
			}

			
			//상품후기 출력 함수
			let printReviewList  = function(reviewArrData, target, templateObj){

				//핸들바 코드가 존재하는 상품후기 디자인코드를 컴파일함.
				let template = Handlebars.compile(templateObj.html());

				let html = template(reviewArrData);

				target.children().empty();
				target.append(html);
			}

			//상품 후기 등록일 : 사용자정의 Helper함수. 템플릿에서 사용함.
			Handlebars.registerHelper("prettifyDate", function(timeValue){

				let dateObj = new Date(timeValue);
		        let year = dateObj.getFullYear();
		        let month = dateObj.getMonth() + 1;
		        let date = dateObj.getDate();
		        let hour = dateObj.getHours();
		        let minute = dateObj.getMinutes();

		      return year + "/" + month + "/" + date + " " + hour + ":" + minute;

			});
			
			
			//별평점 표시하기
		    Handlebars.registerHelper("displayStar", function(rating){

		      let stars = "";
		      switch(rating) {
		        case 1:
		          stars = "★☆☆☆☆";
		          break;
		        case 2:
		          stars = "★★☆☆☆";
		          break;
		        case 3:
		          stars = "★★★☆☆";
		          break;
		        case 4:
		          stars = "★★★★☆";
		          break;
		        case 5:
		          stars = "★★★★★";
		          break;
		          
		      }

		      return stars;

		    });

			
			

			//아이디 4글자만 보여주기
			Headers.registerHelper("idfourdisplay", function(userid){
				
				let userID = userid.substring(0,4);
				let mbridLeng = (userid.length() - 4);
				
				for(let i=0; i<mbridLeng; i++){
					userID += "*";
				}
				
				return userID;
			});
			
			
			

			//상품후기 페이징 함수
			let printReviewPaging = function(pageMaker, target){

				let pagingStr = ""

				//이전
				if(pageMaker.prev){
					pagingStr =+ "<li  class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'> << a </a></li>";
				}

				//페이지번호
				for(let i=pageMaker.startPage; i <= pageMaker.endPage; i++){

					let classStr = pageMaker.cri.pageNum == i ? "class=active'" : "";
					pagingStr += "<li class='page-item'" + classStr + "><a class='page-link' href='" + i + "'>" + i + "</a></li>";

				}

				//다음표시
				if(pageMaker.next){

					pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'> >> a </a></li>";

				}

				
				target.children().remove();
				target.append(pagingStr);

			}


		
			//이전, 페이지번호, 다음
			$("nav ul#reviewPagingResult").on("click", "li a.page-link", function(e){
				e.preventDefault();
				console.log("페이지번호 클릭");

				//상품 후기 목록
				reviewPage = $(this).attr("href");
				url = "/user/review/list/" + $("#gds_code") + "/" + reviewPage;
				
				
				getPage(url);
				
			});
			
			

		});

	</script>

	<!-- 상품후기 출력위치 -->



	<!-- 상품후기 페이징 출력 위치 -->
	
	
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
    