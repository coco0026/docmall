<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Adimin LTE css -->
	<%@include file="/WEB-INF/views/admin/include/plugin1.jsp" %>
	
	
	<script>
		/* 프로세스 완료 메시지 */
		let msg = "${msg}";
		if(msg == "GoodsSuccess"){
			alert("상품이 정상적으로 등록되었습니다.");
		}else if(msg == "GoodsFail"){
			alert("상품등록에 실패하였습니다 관리자에게 문의하세요.");
		}else if(msg == "delSuccess"){
			alert("상품이 정상적으로 삭제되었습니다");
		}else if(msg == "delFail"){
			alert("상품삭제에 실패하였습니다 관리자에게 문의하세요.");
		}else if(msg == "mdifySuccess"){
			alert("상품이 정상적으로 수정되었습니다.");
		}else if(msg == "mdifyFail"){
			alert("상품수정에 실패하였습니다 관리자에게 문의하세요.");
		}
	</script>
	
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

	<!-- header -->
	<%@include file="/WEB-INF/views/admin/include/header.jsp" %>
	<!-- header -->

  <!-- Left side column. contains the logo and sidebar -->
  <%@include file="/WEB-INF/views/admin/include/nav.jsp" %>

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">
		<h1>
			Page Header
			<small>Optional description</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
			<li class="active">Here</li>
		</ol>
		</section>

		<!-- Main content -->
		<section class="content container-fluid">

			<div class="row">
				<div class="col-md-12">
					<div class="box box-primary">
						<div class="box-header">
							LIST ORDER DETAIL				
						</div>
						<div class="box-body">
							<h2>주문상세정보</h2>
							<h5>주문정보</h5>
							<table class="table table-bordered">
							  <thead>
							    <tr>
							      <th scope="col">주문번호</th>
							      <td scope="col"><c:out value="${orderVO.order_code }" /></td>
							    </tr>
							  </thead>
							  <tbody>
							    <tr>
							      <th scope="col">주문일자</th>
							      <td scope="col"><fmt:formatDate value="${orderVO.order_date }" pattern="yyyy-MM-dd hh:mm" /> </td>
							    </tr>
							    <tr>
							      <th scope="col">주문자</th>
							      <td scope="col"><c:out value="${orderVO.order_mbr_nm }" /></td>
							    </tr>
							    <tr>
							      <th scope="col">주문처리상태</th>
							      <td scope="col"><c:out value="${orderVO.payment_process }" /></td>
							    </tr>
							  </tbody>
							</table>
							
							<h5>결제정보</h5>
							<table class="table table-bordered">
							  <thead>
							    <tr>
							      <th scope="col">총 주문금액</th>
							      <td scope="col"><c:out value="${orderVO.order_tot_amt }" /></td>
							    </tr>
							  </thead>
							  <tbody>
							    <tr>
							      <th scope="col">총 할인금액</th>
							      <td scope="col"><c:out value="" /></td>
							    </tr>
							    <tr>
							      <th scope="col">총 결제금액</th>
							      <td scope="col"><c:out value="${payMentVO.pay_tot_price }" /></td>
							    </tr>
							    <tr>
							      <th scope="col">결제수단</th>
							      <td scope="col"><c:out value="${payMentVO.pay_method }" /></td>
							    </tr>
							  </tbody>
							</table>
							
							<h5>주문상품정보</h5>
							<table class="table table-bordered">
							  <thead>
							    <tr>
							      <th scope="col">이미지</th>
							      <th scope="col">상품정보</th>
							      <th scope="col">수량</th>
							      <th scope="col">상품구매금액</th>
							      <th scope="col">주문처리상태</th>
							      <th scope="col">취소/교환/반품</th>
							    </tr>
							  </thead>
							  <tbody>
								  <c:forEach items="${orderDetailMap }" var="orderDetailMap">
								    <tr>
								      <td scope="col">
								      <img alt="이미지준비" src="/admin/order/displayFile?folderName=${orderDetailMap.GDS_IMG_FOLDER }&fileName=s_${orderDetailMap.GDS_IMG }" style="height: 80px; width: 55px;" onerror="this.onerror=null; this.src='/img/noIMG.png'" /><!-- onerror 네트웍 상황에따라 이미지를 불러올 수 없을경우 대체이미지 -->
									  </td>
								      <td scope="col"><c:out value="${orderDetailMap.GDS_NM }" /></td>
								      <td scope="col"><c:out value="${orderDetailMap.ORDER_DTL_CNT }" /></td>
								      <td scope="col"><c:out value="${orderDetailMap.ORDER_DTL_AMT }" /></td>
								      <td scope="col"><c:out value="${orderDetailMap.ORDER_PROCESS }" /></td>
								      <td scope="col"><button type="button" name="btnOrderCancel" data-order_code="${orderDetailMap.ORDER_CODE}"  data-gds_code="${orderDetailMap.GDS_CODE}" data-order_dtl_amt="${orderDetailMap.ORDER_DTL_AMT }" class="btn btn-info">주문취소</button></td>
								    </tr>
							      </c:forEach>
							  </tbody>
							</table>
							
							
							
						</div>
					</div>
				</div>
			</div>
		</section>
    	<!-- /.content -->
	</div>
  	<!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/include/footer.jsp" %>
  

  	<!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
		<!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
			<li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
			<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content">
			<!-- Home tab content -->
			<div class="tab-pane active" id="control-sidebar-home-tab">
				<h3 class="control-sidebar-heading">Recent Activity</h3>
				<ul class="control-sidebar-menu">
				<li>
					<a href="javascript:;">
					<i class="menu-icon fa fa-birthday-cake bg-red"></i>

					<div class="menu-info">
						<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

						<p>Will be 23 on April 24th</p>
					</div>
					</a>
				</li>
				</ul>
				<!-- /.control-sidebar-menu -->

				<h3 class="control-sidebar-heading">Tasks Progress</h3>
				<ul class="control-sidebar-menu">
				<li>
					<a href="javascript:;">
					<h4 class="control-sidebar-subheading">
						Custom Template Design
						<span class="pull-right-container">
							<span class="label label-danger pull-right">70%</span>
						</span>
					</h4>

					<div class="progress progress-xxs">
						<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
					</div>
					</a>
				</li>
				</ul>
				<!-- /.control-sidebar-menu -->

			</div>
			<!-- /.tab-pane -->
		<!-- Stats tab content -->
		<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
		<!-- /.tab-pane -->
		<!-- Settings tab content -->
		<div class="tab-pane" id="control-sidebar-settings-tab">
			<form method="post">
			<h3 class="control-sidebar-heading">General Settings</h3>

			<div class="form-group">
				<label class="control-sidebar-subheading">
				Report panel usage
				<input type="checkbox" class="pull-right" checked>
				</label>

				<p>
				Some information about this general settings option
				</p>
			</div>
			<!-- /.form-group -->
			</form>
		</div>
		<!-- /.tab-pane -->
		</div>
  	</aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery bootstrap3.3.7 AdminL -->
<%@include file="/WEB-INF/views/admin/include/plugin2.jsp" %>

<script src="/ckeditor/ckeditor.js"></script>
<script>

  $(document).ready(function(){

	  //배송상태 변경
	  $("button[name='btnChangeOrderProcess']").on("click", function(){

		//주문번호, 선택한 배송상태값
		let order_code = $(this).data("order_code");
		let order_process = $(this).parent().find("select[name='order_process'] option:selected").val();
		
		console.log("order_code : " + order_code);
		console.log("order_process : " + order_process);

		$.ajax({
			url: '/admin/order/orderProcessChange',
			method: 'get',
			data : {order_code : order_code, order_process : order_process},
			dataType: 'text',
			success : function(result) {
				if(result == "success") {
					alert("배송상태가 변경되었습니다.");				
					location.reload();
				}
			}
		});

	  });


	  //체크박스 선택
	  let isCheck = true;
	  $("#checkAll").on("click",function(){
		$(".check").prop("checked", this.checked); 

		isCheck = this.checked;
	  });

	  //데이터행 체크박스 클릭
	  $(".check").on("click",function(){
		  
		$("#checkAll").prop("checked",this.checked);

		$(".check").each(function(){
			if(!$(this).is(":checked")){
				$("#checkAll").prop("checked",false);
			}
		});
	  });

	  //선택삭제
	  $("button[name='btnCheckDel']").on("click", function(){

		if($(".check:checked").length == 0){
			alert("삭제할 주문정보를 선택하세요."); return;
		}

		let isOrderDel = confirm("선택한 주문정보를 삭제하시겠습니까?");
		if(!isOrderDel) return;

		//삭제할 주문번호 배열.
		let orderCodeArr = [];

		$(".check:checked").each(function(){

			orderCodeArr.push($(this).val());

		});

		console.log("orderCodeArr : " + orderCodeArr);

		$.ajax({
			url: '/admin/order/orderCheckedDel',
			method: 'post',
			data : {orderCodeArr : orderCodeArr},
			dataType: 'text',
			success : function(result) {
				if(result == "success") {
					alert("선택한 주문정보가 삭제되었습니다.");				
					// location.reload();
					location.href = "/admin/order/adminOrderList"
				}
			}
		});


	  });





    
    
	  let actionForm = $("#actionForm"); // <form id="actionForm"> 참조
		
		// 페이지 번호 클릭시 동작.  이전	1	2	3	4	5  다음
		$("li.page-item a.page-link").on("click", function(e) {
			e.preventDefault(); // 태그의 기본특성을 제거. <a>태그의 링크기능을 제거.
			
			/* 검색기능추가하여 아래구문은 사용안함.
			let url = "list?pageNum=" + $(this).attr("href") + "&amount=10";
			location.href = url;
			*/

			//현재 선택한 페이지번호 변경작업.   <input type="hidden" name="pageNum" value="값">
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));

			actionForm.attr("action", "/admin/order/adminOrderList");

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


		//1차 카테고리 선택시
		$("#cate_code").on("change",function(){

			let cate_code = $(this).val();

			console.log("1차카테고리코드 : " + cate_code);

			let url = "/admin/product/subCategoryList/" + cate_code;

			$.getJSON(url,function(subCategoryList){
			
				console.log(subCategoryList[0].common_code);
				console.log(subCategoryList[0].common_code_child);
				console.log(subCategoryList[0].common_code_child_nm);

				let optionStr = "";
				let cate_code_child = $("#cate_code_child");

				cate_code_child.find("option").remove();
				cate_code_child.append("<option value=''>2차 카테고리 선택</option>")

				
				//1차 카테고리별 2차카테고리 option 추가
				for(let i=0; i<subCategoryList.length; i++){

					optionStr += "<option value='" + subCategoryList[i].common_code_child + "'>" + subCategoryList[i].common_code_child_nm + "</option>";

				}

				cate_code_child.append(optionStr);


			});

		});
		
		
    
    

		//상품수정
		$("button[name='btnProductEdit']").on("click", function(){
			//$(this).data("gds_code"); 태그에 있는 data_gds_code의 값

			//상품코드를 자식으로 추가
			actionForm.append("<input type='hidden' name='gds_code' value='"+ $(this).data("gds_code") +"'>");

			
			actionForm.attr("method","get");			
			actionForm.attr("action","/admin/product/adminProductModify");
			actionForm.submit();

		});
		

		
		//주문상품 개별 취소
		$("button[name='btnOrderCancel']").on("click", function(){
			
			if(!confirm("상품을 주문취소하겠습니까?")) return;
			
			let order_code = $(this).data("order_code");
			let gds_code = $(this).data("gds_code");
			let order_dtl_amt = $(this).data("order_dtl_amt");
			
			console.log("1order_code : " + order_code);
			console.log("1gds_code : " + gds_code);
			console.log("1order_dtl_amt : " + order_dtl_amt);
			
			location.href = "/admin/order/orderUnitProductCancelCancel?order_code="+order_code+"&gds_code="+gds_code+"&order_dtl_amt="+order_dtl_amt;

		});

		
		//상품삭제
		$("button[name='btnProductDel']").on("click", function(){

			if(!confirm($(this).data("gds_code") + "번 상품을 삭제하시겠습니까?")) return;

			//$(this).data("gds_code"); 태그에 있는 data_gds_code의 값

			//상품코드를 자식으로 추가
			actionForm.append("<input type='hidden' name='gds_code' value='"+ $(this).data("gds_code") +"'>");

			let gds_img_folder =  $(this).parent().children("input[name='gds_img_folder']").val();
			actionForm.append("<input type='hidden' name='gds_img_folder' value='"+ gds_img_folder +"'>");

			let gds_img =  $(this).parent().children("input[name='gds_img']").val();
			actionForm.append("<input type='hidden' name='gds_img' value='"+ gds_img +"'>");

			actionForm.attr("method","get");			
			actionForm.attr("action","/admin/product/adminProductDelete");
			actionForm.submit();

		});




		let searchForm = $("#searchForm");
		//검색버튼 클릭시 pageNum 초기화
		$("#btnSearch").on("click",function(){

			searchForm.find("input[name='pageNum']").val(1);
			searchForm.submit();

		});


  });

</script>



<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>