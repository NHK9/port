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
	<div id="myReward">
		<h2 class="page-title">적립금내역</h2>
		<div class="page-body">
			<div class="my_menu">
				<ul>
					<li><a href="<%=request.getContextPath()%>/myorder">주문내역</a></li>
					<li><a href="<%=request.getContextPath()%>/mycoupon">쿠폰내역</a></li>
					<li class="over"><a href="<%=request.getContextPath()%>/myreward">적립금내역</a></li>
					<li><a href="">상품리뷰</a></li>
					<li><a href="<%=request.getContextPath()%>/mypage">회원정보</a></li>
				</ul>
			</div>
			<p class="t-box-msg-tit">
				<span>${user.me_name }</span>
				님이 쇼핑몰에서 사용 가능한 적립금 내역입니다.
			</p>
			<div class="info">
				<div class="order">
					<table>
						<tbody>
							<tr>
								<td>
									<dl>
										<dd>
											<span>총 보유 적립금액</span>
										</dd>
										<dd>
											<span class="total_reward">${user.me_rw }</span>
											원
										</dd>
									</dl>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<h3 class="tit-tb-list">적립금 내역</h3>
			<div class="tbl">
				<table class="tbl_col" summary="날짜, 적립내역, 적립금">
					<colgroup>
						<col width="120">
						<col width="*">
						<col width="120">
					</colgroup>
					<thead>
						<tr>
							<th scope="row">
								<div class="tb-center">날짜</div>
							</th>
							<th scope="row">
								<div class="tb-center">적립내역</div>
							</th>
							<th scope="row">
								<div class="tb-center">적립금</div>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="i" varStatus="s">
							<tr>
								<td><div class="tb-center">${i.rw_date }</div></td>
								<td><div class="tb-left">${i.rw_desc }</div></td>
								<td><div class="tb-center">${i.rw_price }</div></td>
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
				<li>- 결제 시 사용 가능한 적립금이 표시됩니다.</li>
			</ul>
		</div>
	</div>
</body>
</html>