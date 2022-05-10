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
	<div id="myOrder">
		<h2 class="page-title">주문내역</h2>
		<div class="page-body">
			<div class="my_menu">
				<ul>
					<li class="over"><a href="<%=request.getContextPath()%>/myorder">주문내역</a></li>
					<li><a href="<%=request.getContextPath()%>/mycoupon">쿠폰내역</a></li>
					<li><a href="<%=request.getContextPath()%>/myreward">적립금내역</a></li>
					<li><a href="">상품리뷰</a></li>
					<li><a href="<%=request.getContextPath()%>/mypage">회원정보</a></li>
				</ul>
			</div>
			<p class="t-box-msg-tit">
				<span>${user.me_name }</span>
				님이 쇼핑몰에서 주문한 내역입니다.
			</p>
			<div class="tbl">
				<table class="tbl_col" summary="주문번호, 주문일자, 상품명, 결제금액, 주문상세,배송현황">
					<colgroup>
						<col width="95">
						<col width="95">
						<col width="*">
						<col width="100">
						<col width="100">
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th scope="row">
								<div class="tb-center">주문번호</div>
							</th>
							<th scope="row">
								<div class="tb-center">주문일자</div>
							</th>
							<th scope="row">
								<div class="tb-center">상품명</div>
							</th>
							<th scope="row">
								<div class="tb-center">결제금액</div>
							</th>
							<th scope="row">
								<div class="tb-center">주문상세</div>
							</th>
							<th scope="row">
								<div class="tb-center">배송현황</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="i" varStatus="s">
							<tr>
								<td><div class="tb-center">${i.od_num}</div></td>
								<td><div class="tb-center">${i.od_date }</div></td>
								<td><div class="tb-center">${i.pr_name }</div></td>
								<td><div class="tb-center">${i.od_pay }</div></td>
								<td>
									<div class="tb-center">
										<a class="button05" href="<%=request.getContextPath()%>/order/detail?od_num=${i.od_num}">주문상세</a>
									</div>
								</td>
								<td>
									<div class="tb-center">
										<a class="button05" href="">배송현황</a>
									</div>
								</td>
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
				<li>- 주문상세의 조회 버튼을 클릭하시면, 주문상세 내역을 확인하실 수 있습니다.</li>
				<li>- 배송현황의 조회 버튼을 클릭하시면, 해당 주문의 배송 현황을 한눈에 확인하실 수 있습니다.</li>
			</ul>
		</div>
	</div>
</body>
</html>