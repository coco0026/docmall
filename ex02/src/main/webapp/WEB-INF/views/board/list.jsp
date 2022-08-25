<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    

    <!-- Bootstrap core CSS -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">


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

    
    <!-- Custom styles for this template -->
    <link href="/resources/css/pricing.css" rel="stylesheet">
  </head>
  <body>
    
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/carousel.jsp" %>

<div class="container">
  <h3>게시판 글목록</h3>
  <table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">글번호</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">등록일</th>
	      <th scope="col">조회수</th>
	    </tr>
	  </thead>
	  <tbody>
	    <c:forEach items="${list }" var="board">
	    <!-- BoardVO클래스의 필드명으로 코딩했지만, 호출은 getter메서드가 사용됨. -->
	    <tr>
	      <th scope="row"><c:out value="${board.bno }" /></th>
	      <td><a class="" href="/board/modify?bno=${board.bno }"><c:out value="${board.title }" escapeXml="true" /></a></td>
	      <td><c:out value="${board.writer }" /></td>
	      <td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd hh:mm" />   </td>
	      <td>0</td>
	    </tr>
	    </c:forEach>
	    
	  </tbody>
	</table>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

