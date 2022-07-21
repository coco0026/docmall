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
				<form id="productForm" action="adminProductInsert" method="post" enctype="multipart/form-data">
					<div class="box-header">
						REGISTER PRODUCT				
					</div>
					<div class="box-body">
					  <div class="form-group row">
					  	<label for="cate_code" class="col-sm-2 col-form-label">1차 카테고리</label>
						<div class="col-sm-4">
							<select class="form-control form-control-sm-md" name="cate_code" id="cate_code">
								<option>1차 카테고리 선택</option>
								<c:forEach items="${cateList }" var="cateList">
									<option value="${cateList.common_code}">${cateList.common_code_nm}</option>
								</c:forEach>
							</select>
						</div>
						<label for="cate_code_child" class="col-sm-2 col-form-label">2차 카테고리</label>
						<div class="col-sm-4">
							<select class="form-control form-control-sm-md" name="cate_code_child" id="cate_code_child">
								<option>2차 카테고리 선택</option>
							</select>
					  	</div>
					  </div>
					  <div class="form-group row">
					    <label for="gds_nm" class="col-sm-2 col-form-label">상품명</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="gds_nm" name="gds_nm">
					    </div>
					    <label for="gds_price" class="col-sm-2 col-form-label">상품가격</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="gds_price" name="gds_price">
					    </div>
					  </div>
					  
					  <div class="form-group row">
					    <label for="gds_dscnt" class="col-sm-2 col-form-label">할인율</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="gds_dscnt" name="gds_dscnt">
					    </div>
					    <label for="gds_cnt" class="col-sm-2 col-form-label">상품수</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="gds_cnt" name="gds_cnt">
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="gds_img" class="col-sm-2 col-form-label">섬네일</label>
					    <div class="col-sm-4">
					      <input type="file" class="form-control" id="uploadFile" name="uploadFile">
					    </div>
					    <label class="form-check-label col-sm-2" for="gds_prchs_yn">구매가능 여부</label>
						<div class="col-sm-4 text-left">
						  <input class="form-check-input" type="checkbox" value="Y" id="gds_prchs_yn" name="gds_prchs_yn">
						</div>	
					  </div>
					  <div class="form-group row">
					    <label for="gds_cn" class="col-sm-2 col-form-label">상품설명</label>
					    <div class="col-sm-10">
					      <textarea class="form-control" name="gds_cn" id="gds_cn" rows="3"></textarea>
					    </div>
					  </div>
					</div>
						<div class="form-group row">
							<div class="col-sm-12 text-center">
							 <button type="submit" class="btn btn-success" id="btnInsert">상품등록</button>
							</div>			
						</div>
					<div class="box-footer">
						<div class="form-group">
							<ul class="uploadedList"></ul>
						</div>
							REGISTER PRODUCT				
					</div>
				</form>
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
	  

    //ckeditor 환경설정
    var ckeditor_config = {
			resize_enabled : false,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMode : CKEDITOR.ENTER_P,
			toolbarCanCollapse : true,
			removePlugins : "elementspath", 
			filebrowserUploadUrl: '/admin/product/imageUpload' //업로드 탭기능추가 속성

    }

    CKEDITOR.replace("gds_cn",ckeditor_config);





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
    
    
    
    
    
    
    
    
    
    
    


  });

</script>



<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>