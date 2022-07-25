<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 1차카테고리 -->
<nav class="navbar navbar-expand-lg navbar-light">
  <a class="nav-link text-dark" href="/">EzenShop</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <!-- <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li> -->
      <c:forEach items="${mainCategoryList }" var="categoryVO">
	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="${categoryVO.common_code }" role="button" data-toggle="dropdown" aria-expanded="false">
	          <c:out value="${categoryVO.common_code_nm }"></c:out>
	        </a>
	        <!-- 2차카테고리 -->
	        <div class="dropdown-menu subCategory">
	          <a class="dropdown-item" href="#">Action</a>
	        </div>
	      </li>
      </c:forEach>
      <!-- <li class="nav-item">
        <a class="nav-link disabled">Disabled</a>
      </li> -->
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>

<script>

  $(function(){
    //1차 카테고리 
    $("ul.navbar-nav li.nav-item a").on("click", function(){

      //ajax 사용시 이전에 필요한 선택자의 정보를 변수에 미리 저장해서 사용해야 한다.
      let selectedCategory = $(this);
      let url = "/product/subCategoryList/" + $(this).attr("href");

      /* console.log("url : " + url); */



      //result : 2차 카테고리정보
      $.getJSON(url,function(result){
    	  let subCategoryList =  selectedCategory.next();
        subCategoryList.children().remove();
        
        let subCategoryStr = "";
        for(let i=0; i<result.length; i++){
          //subCategoryStr += " <a class='dropdown-item' href='/product/productList/"+ result[i].common_code_child +"'>" + result[i].common_code_child_nm + "</a>";

          //jquery 문법을 사용하여 이벤트 적용을 통한 주소요청작업
          subCategoryStr += " <a class='dropdown-item' href='"+ result[i].common_code_child +"'>" + result[i].common_code_child_nm + "</a>";
        }

        subCategoryList.append(subCategoryStr);

      });

    });


    //2차 카테고리 
    $("ul.navbar-nav li.nav-item div.subCategory").on("click","a",function(e){

      e.preventDefault();

      let cate_code_child = $(this).attr("href");
      location.href = "/product/productList/" + cate_code_child



    });






  });


</script>