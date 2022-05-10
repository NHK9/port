<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/additional-methods.min.js"></script>
</head>
<body>
	<div class="container find body">
		<div class="container find body">
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">쿠폰 관리</h1>
			<a href="<%=request.getContextPath() %>/admin/member/cpRegister">쿠폰 등록</a>
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>쿠폰명</th>
						<th>할인율</th>
						<th></th>
						<th>발급</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="cp">
						<tr>
							<td class="cpNum"><input type="hidden" value="${cp.cp_num }"></td>
						 	<td>${cp.cp_name}</td>
						 	<td>${cp.cp_discount}</td>
						 	<td><button type="button" id="delete" class="btn btn-outline-success col-12">삭제</button></td>
						 	<td><select class="sel">
						 		<option value="1">발급 대상 선택</option>
						 		<option value="2">전체 회원</option>
						 	</select>
						 	<button type="button" id ="issue" class="btn btn-outline-success col-12">발급</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- class = row -->
	</div>
<script>
//쿠폰 발급
$(document).on('click','#issue',function(){
	var cases = $(this).siblings('.sel').val();
	if(cases <= 1){
		alert('발급 대상을 선택하세요');
		return;
	}
	var del = confirm('쿠폰을 발급하시겠습니까?')
	if(del){
		var cp_num = $(this).parent().siblings('.cpNum').children().val();
		$.ajax({
			async:false,
			type:'POST',
			data: {cp_num : cp_num, cases : cases},
			url:"<%=request.getContextPath()%>/admin/coupon/issue",
			success : function(res){
		    if(res == 'ok')
		    	deleted = true;
		    else
		    	deleted = false;
		    if(deleted)
		    	alert('발급 되었습니다');
		    else
		    	alert('발급할 수 없습니다');
			}
		});
	}
});
//쿠폰 삭제
$(document).on('click','#delete',function(){
	var del = confirm('삭제하시겠습니까?')
	if(del){
		var cp_num = $(this).parent().siblings('.cpNum').children().val();
		$.ajax({
			async:false,
			type:'POST',
			data: {cp_num : cp_num },
			url:"<%=request.getContextPath()%>/admin/coupon/deleted",
			success : function(res){
		    if(res == 'ok')
		    	deleted = true;
		    else
		    	deleted = false;
		    if(deleted)
		    	alert('삭제 되었습니다');
		    else
		    	alert('삭제 할 수 없습니다');
			}
		});
		$(this).parent().parent().remove();
	}
});
</script>
</body>
</html>