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
					LIST PRODUCT				
				</div>
				<div class="box-body">
					 <form id="searchForm" action="/admin/product/adminProductList" method="get">
					 <div class="col-sm-3">
					  <select class="form-control form-control-sm-md" name="type">
						  <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }" />>--</option>
						  <option value="C1" <c:out value="${pageMaker.cri.type eq 'C1' ? 'selected' : '' }" />>카테코리1</option><!-- CATE1 -->
						  <option value="C2" <c:out value="${pageMaker.cri.type eq 'C2' ? 'selected' : '' }" />>카테고리2</option><!-- CATE2 -->
						  <option value="N" <c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : '' }" />>상품이름</option><!-- GDS_NM -->
					  </select>
					  </div>
					  <div class="col-sm-5"></div>
					  <div class="col-sm-3">
						  <input type="text" class="form-control mr-sm-2" name="keyword" placeholder="Search" value="${pageMaker.cri.keyword }">
						  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
						  <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					  </div>
					  <div class="col-sm-1">
					  	<button class="btn btn-link">Search</button>
					  </div>
				  </form>
				  <div class="col-sm-12">
					  <table class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col">글번호</th>
						      <th scope="col">상품이름</th>
						      <th scope="col">가격</th>
						      <th scope="col">재고</th>
						      <th scope="col">판매여부</th>
						      <th scope="col">등록일</th>
						      <th scope="col">수정</th>
						      <th scope="col">삭제</th>
						    </tr>
						  </thead>
						  <tbody>
						    <c:forEach items="${adminProductList }" var="List">
						    <tr>
						      <th scope="row"><c:out value="${List.gds_code }" /></th>
						      <td>
						      <img alt="이미지준비" src="/admin/product/displayFile?folderName=${List.gds_img_folder}&fileName=${List.gds_img}" style="height: 80px; width: 55px;" />
						      <a class="move" href="${List.gds_code }"><c:out value="${List.gds_nm }" escapeXml="true" /></a>
						      </td>
						      <td><c:out value="${List.gds_price }" /></td>
						      <td><c:out value="${List.gds_cnt }" /></td>
						      <td><c:out value="${List.gds_prchs_yn }" /></td>
						      <td><fmt:formatDate value="${List.gds_reg_date }" pattern="yyyy-MM-dd hh:mm" />   </td>
						      <td><button type="button" class="btn btn-outline-info">수정</button></td>
						      <td><button type="button" class="btn btn-outline-danger">삭제</button></td>
						    </tr>
						    </c:forEach>
						    
						  </tbody>
						</table>
						<nav aria-label="...">
						  <ul class="pagination" style="justify-content: center;">
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
							<form id="actionForm" action="/admin/product/adminProductList" method="get">
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
								<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
								<input type="hidden" name="type" value="${pageMaker.cri.type}">
								<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
							</form>
						</nav>
					</div>
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

			actionForm.attr("action", "/admin/product/adminProductList");

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
    
    
    


  });

</script>



<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>