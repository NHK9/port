<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/additional-methods.min.js"></script>
</head>
<style>
	.image-box {
	    width:100px;
	    height:100px;
	    overflow:hidden;
	    margin:0 auto;
	}
	
	.image-thumbnail {
	    width:100%;
	    height:100%;
	    object-fit:cover;
	}
	input{
		border:none;
	}
</style>
<body>
		<form class="container find body" method="post" action="<%=request.getContextPath()%>/order/orderBuy">
			<h1 style="text-align: center; margin: 50px 0;">주문 상세</h1>
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>상품명</th>
						<th>옵션</th>
						<th>수량</th>
						<th>가격</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="i" varStatus="s">
						<tr>
							<td class="image-box"><img src="<%=request.getContextPath()%>/img${i.pr_img }" class="image-thumbnail"></td>
							<td>${i.pr_name }</td>
							<td>${i.op_colnsize }</td>
							<td><input type="text" value="${i.ol_amount }" readonly style="border:none"></td>
							<td><input type="number" class="price" readonly style="border:none"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr>
			<h5>주문자 정보</h5>
			<div class="memeber_info">
				<span>이름 : </span> <span>${user.me_name }</span> <hr>
				<span>연락처 : </span> <span>${user.me_phone }</span><hr>
				<span>이메일 : </span> <input type="text" name="od_email" value="${user.me_email }"> <hr>
			</div>
			<hr>
			<h5>배송 정보</h5>
			<div class="delivery_info">
				<span>이름 : </span> <input type="text" value="${list[0].od_name }" readonly> <hr>
				<span>연락처 : </span> <input type="text" value="${list[0].od_phone }" readonly> <hr>
				<span>주소 : </span> 
				<input type="text" value="${list[0].od_address1 }" readonly>
				<input type="text" value="${list[0].od_address2 }" readonly>
				<input type="text" value="${list[0].od_address3 }" readonly>
				<hr>
				<span>배송메세지 : </span> <input type="text" value="${list[0].od_delivery_msg }" readonly> <hr>
			</div>
			<hr>
			<h5>할인 정보</h5>
			<div class="discount_info">
				<span>적립금 사용: </span>
				<input type="number" value="${list[0].od_useRw }" readonly>
				 <hr>
				<span>쿠폰 할인 금액: </span> <fmt:parseNumber value="${list[0].od_total * list[0].cp_discount /100}"/>
			</div>
			<hr>
			<h5>금액 확인</h5>
			<div class="total_price">
			  <span>배송비 : </span><input value="${list[0].od_delivery }" style="border:none" readonly> <span>원</span><hr>
			  <span>적립금 : </span><input value="${list[0].od_addRw }" style="border:none" value="0" readonly><span>원</span> <hr>
				<span>최종 결제금액 : </span><input type="number" value="${list[0].od_pay }" style="border:none" readonly><span>원</span> <hr>
			</div>
			<button>쇼핑하기</button> <button type="button" >취소하기</button>
		</form>
	</body>
</html>