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
<script src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/additional-methods.min.js"></script>
</head>
<body>
	<div id="myOrder">
		<h2 class="page-title">주문관리</h2>
		<div class="page-body">
			<div class="my_menu">
				<ul>
					<li class="over"><a href="<%=request.getContextPath()%>/admin/member/list">회원관리</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/product/register">상품등록</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/product/list">상품조회</a></li>
					<li><a href="<%=request.getContextPath()%>/admin/product/ordermanage">주문관리</a></li>
				</ul>
			</div>
			<div class="tbl">
				<table class="tbl_col" summary="주문번호, 주문일자, 상품명, 결제금액, 주문상태,배송상태">
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
								<div class="tb-center">주문상태</div>
							</th>
							<th scope="row">
								<div class="tb-center">배송상태</div>
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
								<td><div class="tb-center">
									<input type="hidden" name="od_num" value="${i.od_num }">
									<select class="sel">
										<option value="1">${i.od_state }</option>
										<option value="2">입금완료</option>
										<option value="3">배송완료</option>
									</select>
								</div></td>
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
		</div>
	</div>
</body>
<script>
	$('.sel').on('change',function(){
		console.log('a');
		var num = $(this).val();
		var od_num = $(this).siblings('[name=od_num]').val();
		$.ajax({
			async:false,
			type:'POST',
			data: {num : num, od_num : od_num },
			url:"<%=request.getContextPath()%>/admin/order/modify",
			success : function(res){
		    if(res == 'ok')
		    	alert('변경 되었습니다');
		    else
		    	alert('실패');
			}
		})
	});
</script>
</html>