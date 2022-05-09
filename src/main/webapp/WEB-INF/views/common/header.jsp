<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.nav-item{
	position: relative;
	}
	.cate-box {
		display: none;
    position: absolute;
    z-index: 40;
    display: none;
    left: 50%;
    width: 140px;
    margin-left: -70px;
    padding: 16px;
    background: #343a40;
    text-align: center;
    }
 .nav-link:hover + .cate-box, .cate-box:hover {
  display: block;
}
.cate-box a {
	display: block;
	color:white;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	  <!-- Brand/logo -->
	  <a class="navbar-brand" href="<%=request.getContextPath()%>">HOME</a>
	  
	  <ul class="navbar-nav">
	  	<li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=women">우먼</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=mens">맨즈</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=new">신상</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=best">베스트</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=cosmetic">코스메틱</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=shoes">슈즈</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/product/list?type=acc">용품</a>
		  </li>
		  <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/board/list?type=공지">커뮤니티</a>
		      <div class="cate-box">
		      	<a href="<%=request.getContextPath()%>/board/list?type=이벤트">이벤트</a>
		      	<a href="<%=request.getContextPath()%>/board/list?type=공지">공지사항</a>
		      	<a href="<%=request.getContextPath()%>/board/list?type=고객센터">고객센터</a>
		      	<a href="<%=request.getContextPath()%>/board/list">리뷰</a>
		      </div>
		  </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/order/cart">검색</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/order/cart">장바구니</a>
	    </li>
	    <!-- 로그인되어 있지 않으면 => 세션에 user가 없으면-->
	  	<c:if test="${ user == null }">
	  	<li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath()%>/mypage">MY</a>
	      <div class="cate-box">
	      	<a href="<%=request.getContextPath()%>/signup">회원가입</a>
	      	<a href="<%=request.getContextPath()%>/login">로그인</a>
	      </div>
	    </li>
	    </c:if>
	    <!-- 로그인 되어 있으면 => 세션에 user가 있으면 => user가 null이 아니면  -->
	    <c:if test="${ user != null }">
		    <li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/mypage">MY</a>
		      <div class="cate-box">
		      	<a href="<%=request.getContextPath()%>/mypage">회원정보</a>
		      	<a href="<%=request.getContextPath()%>/myorder">주문내역</a>
		      	<a href="<%=request.getContextPath()%>/mycoupon">쿠폰내역</a>
		      	<a href="<%=request.getContextPath()%>/myreward">적립금내역</a>
		      	<a href="">고객센터</a>
		      	<a href="<%=request.getContextPath()%>/logout">로그아웃</a>
		      </div>
		    </li>
	    </c:if>
	    <c:if test="${user.me_authority == '슈퍼 관리자' }">
	    	<li class="nav-item">
		      <a class="nav-link" href="<%=request.getContextPath()%>/admin/member/list">관리자</a>
		      <div class="cate-box">
		      	<a href="<%=request.getContextPath()%>/admin/member/list">회원관리</a>
		      	<a href="<%=request.getContextPath()%>/admin/product/list">상품조회</a>
		      	<a href="<%=request.getContextPath()%>/admin/product/register">상품등록</a>
		      	<a href="<%=request.getContextPath()%>/admin/product/ordermanage">주문관리</a>
		      </div>
		    </li>
	    </c:if>
	  </ul>
	</nav>
</body>
</html>