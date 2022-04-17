<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/default.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<div id="myCoupon">
		<h2 class="page-title">쿠폰내역</h2>
		<div class="page-body">
			<div class="my_menu">
				<ul>
					<li><a href="<%=request.getContextPath()%>/myorder">주문내역</a></li>
					<li class="over"><a href="<%=request.getContextPath()%>/mycoupon">쿠폰내역</a></li>
					<li><a href="<%=request.getContextPath()%>/myreward">적립금내역</a></li>
					<li><a href="">상품리뷰</a></li>
					<li><a href="<%=request.getContextPath()%>/mypage">회원정보</a></li>
				</ul>
			</div>
			<p class="t-box-msg-tit">
				<span>${user.me_name }</span>
				님이 쇼핑몰에서 사용 가능한 쿠폰 내역입니다.
			</p>
			<div class="tbl">
				<table class="tbl_col" summary="번호, 쿠폰이름, 할인율, 발급일">
					<colgroup>
						<col width="80">
						<col width="*">
						<col width="80">
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th scope="row">
								<div class="tb-center">번호</div>
							</th>
							<th scope="row">
								<div class="tb-center">쿠폰이름</div>
							</th>
							<th scope="row">
								<div class="tb-center">할인율</div>
							</th>
							<th scope="row">
								<div class="tb-center">발급일</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="i" varStatus="s">
							<tr>
								<td><div class="tb-center">${fn:length(list)- s.index }</div></td>
								<td><div class="tb-left">${i.cp_name }</div></td>
								<td><div class="tb-center">${i.cp_discount }%</div></td>
								<td><div class="tb-center">${i.hc_date }</div></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<ol class="paging">
				<li>
					
				</li>
			</ol>
			<ul class="foot-dsc">
				<li>- 적립된 금액이 0원 이상 누적되었을 때, 사용하실 수 있습니다</li>
				<li>- 결제 시 적립금 사용 여부를 확인할 수 있는 안내문이 나옵니다.</li>
			</ul>
		</div>
	</div>
</body>
</html>