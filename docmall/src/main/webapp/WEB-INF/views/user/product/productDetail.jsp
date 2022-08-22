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
			  <p>
			  	<small>평점 : {{displayStar review_score}}</small>
				{{modifyview mbr_id review_no}}
				<input type="hidden" name="review_score" value="{{review_score}}">
		  	  </p>
			</div>
			<div class="d-flex w-100 justify-content-between">
			  <p class="mb-1"><span class="review_cn">{{review_cn}}</span></p>
			  <p>
			  	<small>{{prettifyDate review_reg_date}}</small>
			 	{{deleteview mbr_id review_no}}
			  </p>
			</div>
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
		<button type="button" name="btnOrder" id="btnOrder" class="btn btn-info">구매하기</button>
		<button type="button" name="btnCart" id="btnCart" class="btn btn-info">장바구니</button>
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
			
			
		  	$("button[name='btnBuyCart']").on("click", function(){

	        	$("#modal_productDetail").modal('show');

	        	let url = "/user/product/productDetail/" + $(this).data("gds_code");
	        
	        	$.getJSON(url, function(result) {

			          //모달 대화상자에서 상품상세정보 표시
			          //console.log("상품상세정보" + result.gds_code);
						
			          //상품코드
			          $("div#modal_productDetail input#gds_code").val(result.gds_code);
			          //상품이름
			          $("div#modal_productDetail input#gds_nm").val(result.gds_nm);
			          //판매가격
			          $("div#modal_productDetail input#gds_price").val(result.gds_price);
			          //상품이미지
			          let url = "/user/product/displayFile?folderName=" + result.gds_img_folder + "&" + "fileName=" + result.gds_img;
			          
			          //console.log("이미지파일경로: " + url);
			          $("div#modal_productDetail img#modal_detail_image").attr("src", url);
		          

	       		 });

	      });

	      //장바구니 담기
	      $("#btnCart").on("click", function(){

	        $.ajax({
	          url : '/user/cart/cart_add',
	          data: { gds_code : $("input#gds_code").val(), cart_prchs_cnt : $("input#cart_prchs_cnt").val()},
	          dataType: 'text',
	          success: function(result) {
	            if(result == "success") {
	              alert("장바구니에 추가되었습니다.");
	              if(confirm("장바구니로 이동하시겠습니까?")) {
	                location.href = "/user/cart/cart_list";
	              }

	            }
	          }
	        });
	      });
	      
	      
	     //직접구매 클릭시 non-ajax
		 $("#btnOrder").on("click", function(){

			let gds_code = $("#gds_code").val(); //구매상품코드
			let cart_prchs_cnt = $("#cart_prchs_cnt").val(); //구매수량

			location.href = "/user/order/orderListInfo?gds_code="+gds_code+"&cart_prchs_cnt="+cart_prchs_cnt+"&type=direct";
			


		 });

			
		
		  //actionForm 참조 : 1)페이지번호 클릭 2)검색버튼 클릭
	      let actionForm = $("#actionForm");
			
		  let searchForm = $("#searchForm");
	      //검색버튼 클릭시 pageNum 초기화
	      $("#btnSearch").on("click", function(){

	        searchForm.find("input[name='pageNum']").val(1);
	        searchForm.submit();
	      });
		
		
		
		
		//상품이미지, 상품제목 클릭
	      $("div.container a.move").on("click", function(e){
	        e.preventDefault();

	        let gds_code = $(this).attr("href");

	        actionForm.attr("method", "get");
	        actionForm.attr("action", "상품상세주소");

	        actionForm.append("<input type='hidden' name='gds_code' value='" + gds_code + "'>");
	        //actionForm.submit();

	      });
		



			//상품후기 팝업대화상자
			$("div#productDetailReview button#btnReview").on("click", function(){

				$("#reviewModal").modal('show');

			});
			
			
			 //상품후기 수정 팝업대화상자
		     $("div#reviewListResult").on("click", "p a.modify", function(e){

		        e.preventDefault();

		        $("button.btnReview").hide(); // 쓰기,수정,삭제 버튼 3개 보이지 않음.
		        $("button#btnReviewModify").show();  // 수정 버튼 보이게 함.

		        //수정내용 표시.
		        let review_no = $(this).attr("href"); //상품후기코드
		        let review_cn = $(this).parents("div.list-group").find("p span.review_cn").text();

		        $("textarea#review_cn").val(review_cn); 
		        $("input#review_no").val(review_no);

		        // 2)별평점표시.  2
		        let review_score = $(this).parents("div.list-group").find("p input[name='review_score']").val();

		        //별 a태그 5개
		        $("#star_review_score a").each(function(index, item) {

		          if(index < review_score) {
		            $(item).addClass('on');
		          }else {
		            $(item).removeClass('on');
		          }
		        });
		        // 
		       
		        
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

				let review_score = 0;
				let review_cn = $("#review_cn").val();
				let gds_code = $("#gds_code").val();

				$("#star_review_score a.rv_score").each(function(index,item){
					if($(this).attr('class') == 'rv_score on'){
						rv_score += 1;
					}
				});

				console.log("review_score : " + rv_score);


				if(review_score == 0){
					alert("평점을 선택해주세요."); return;
				}

				if(review_cn == ""){
					alert("리뷰를 작성해주세요."); return;
				}

				//자바스크립트 Object객체 구문
				let data = {gds_code : gds_code,  review_score : rv_score,  review_cn : review_cn};
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
							url = "/user/review/list/" + $("#gds_code").val() + "/" + reviewPage;
							
							getPage(url);
							
							
							// 상품후기 대화상자 숨김
							$("#reviewModal").modal('hide');
							$("#star_review_score a.rv_score").parent().children().removeClass("on");
							rv_cn.val("");
							
						}
					}

						
				});
			});
			
			//상품후기 수정버튼 클릭
		      $("#btnReviewModify").on("click", function(){
		        
		        let review_no = $("#review_no").val();
		        let review_score = 0;
		        let review_cn = $("#review_cn").val();

		        // 별평점이 5개
		        $("#star_review_score a.rv_score").each(function(index, item){
		          if($(this).attr('class') == 'rv_score on') {
		            review_score += 1;
		          }
		        });

		        console.log("별 평점: " + review_score );

		        if(review_score == 0){
		          alert("별 평점을 선택해주세요.");
		          return;
		        }

		        if(review_cn == "") {
		          alert("상품후기를 입력하세요.");
		          return;
		        }

		        //자바스트립트 Object객체 구문
		        
		        let data = {review_no : review_no, review_cn : review_cn, review_score : review_score};
		        
		        $.ajax({
		          url: '/user/review/modify',
		          /*컨트롤러에서 전송데이터 포맷이 설정되어 있으므로, 클라이언트에서 보내는 데이터의 MIME설정을 헤더에 추가해야 한다. */
		          headers: {
		              "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PATCH"
		            },
		          type: 'patch',
		          dataType: 'text',
		          data : JSON.stringify(data), /* JSON 문자열데이타 */
		          success : function(result) {
		            if(result == "success") {
		              alert("상품후기가 수정되었습니다.");
		              
		              //상품후기 목록
		              //reviewPage = 1;
		              // "/user/review/list/상품코드/첫번째 페이지"
		              url = "/user/review/list/" + $("#gds_code").val() + "/" + reviewPage;

		              getPage(url);
		              
		              // 상품후기 대화상자 숨김.
		              $("#reviewModal").modal('hide');
		              $("#star_review_score a.rv_score").parent().children().removeClass("on");
		              $("#review_cn").val("");

		            }
		          }
		        });
		        
		      });

			});//jquery ready이벤트 끝


			let reviewPage = 1;
			let url = "/user/review/list/" + ${productVO.gds_code } + "/" + reviewPage;		
			
			getPage(url);

			function getPage(pageInfo){
				//상품후기 목록
				$.getJSON(pageInfo, function(data){
				/* console.log("목록 : " + data.list[0].gds_code);
				console.log("목록 : " + data.pageMaker); */

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

			 //상품후기 등록일 : 사용자정의 Helper함수.  템플릿에서 사용함.
		    Handlebars.registerHelper("prettifyDate", function(timeValue) {

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
			/* Headers.registerHelper("idfourdisplay", function(userid){
				
				let userID = userid.substring(0,4);
				let mbridLeng = (userid.length() - 4);
				
				console.info("userID : " + userID);
				console.info("mbridLeng : " + mbridLeng);
				
				for(let i=0; i<mbridLeng; i++){
					userID += "*";
				}
				
				return userID;
			}); */


			//로그인 사용자와 댓글 작성자가 일치할 경우 수정, 삭제버튼 표시
			Handlebars.registerHelper("modifyview",function(review_mbr_id, review_no){

				let result = "";
				let login_mbr_id = "${sessionScope.loginStatus.mbr_id}";
				if(login_mbr_id == login_mbr_id){
					result = "<a class='modify' href='" + review_no +"'>[modify]</a>";
				}

				return new Handlebars.SafeString(result);

			});

			Handlebars.registerHelper("deleteview",function(review_mbr_id, review_no){

				let result = "";
				let login_mbr_id = "${sessionScope.loginStatus.mbr_id}";
				if(login_mbr_id == login_mbr_id){
					result = "<a class='delete' href='" + review_no +"'>[delete]</a>";
				}

				return new Handlebars.SafeString(result);

			});
		
			
			

			//상품후기 페이징 함수
		    let printReviewPaging = function(pageMaker, target) {

		      let pagingStr = "";

		      // 이전표시
		      if(pageMaker.prev) {
		        pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
		      }

		      //페이지번호 표시
		      for(let i= pageMaker.startPage; i <= pageMaker.endPage; i++) {
		        let classStr = pageMaker.cri.pageNum == i ? "active'" : "";
		        pagingStr += "<li  class='page-item " + classStr + "'><a  class='page-link' href='" + i + "'>" + i + "</a></i>";
		      }

		      // 다음표시
		      if(pageMaker.next) {
		        pagingStr += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
		      }

		      //console.log("페이지문자열: " + pagingStr);
		      target.children().remove();
		      target.append(pagingStr);
		    }


		
		 	// 이전, 페이지번호, 다음 클릭
		    $("nav ul#reviewPagingResult").on("click", "li a.page-link", function(e){
		      e.preventDefault();
		      //console.log("페이지번호 클릭");

		      //상품후기 목록
		      reviewPage = $(this).attr("href");
		      // "/user/review/list/상품코드/첫번째 페이지"
		      url = "/user/review/list/" + $("#gds_code").val() + "/" + reviewPage;

		      getPage(url);

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
	            <label for="message-text" class="col-form-label">리뷰내용:</label>
	            <textarea class="form-control" id="review_cn"></textarea>
	            <input type="hidden" name="review_no" id="review_no">
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" id="btnReviewWrite" class="btn btn-primary btnReview">상품리뷰 쓰기</button>
	        <button type="button" id="btnReviewModify" class="btn btn-primary btnReview">상품리뷰 수정</button>
	        <button type="button" id="btnReviewDelete" class="btn btn-primary btnReview">상품리뷰 삭제</button>
	      </div>
	    </div>
	  </div>
	</div>

    
  </body>
</html>
    