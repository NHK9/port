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
<style>
	.image-box {
	    width:200px;
	    height:200px;
	    overflow:hidden;
	    margin:0 auto;
	}
	
	.image-thumbnail {
	    width:100%;
	    height:100%;
	    object-fit:cover;
	}
</style>
<body>
	<div class="container find body">
		<div class="container find body">
			<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">상품 리스트</h1>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>이미지</th>
						<th>상품코드</th>
						<th>상품명</th>
						<th>상품가격</th>
						<th>성별</th>
						<th>할인율</th>
						<th>설명</th>
						<th>카테고리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="product">
						<tr>
						 	<td class="image-box"><img src="<%=request.getContextPath()%>/img${product.pr_img}" class="image-thumbnail"></td>
						 	<td id="code">${product.pr_code}</td>
						 	<td>${product.pr_name}</td>
						 	<td>${product.pr_price}</td>
						 	<td>${product.pr_gender}</td>
						 	<td>${product.pr_discount}</td>
						 	<td>${product.pr_desc}</td>
						 	<td>${product.pr_cg_name}</td>
						 	<td>
						 	<a href="<%=request.getContextPath()%>/admin/product/modify?pr_code=${product.pr_code}">
								<button class="btn btn-outline-success">수정</button>
							</a>
						 	</td>
						 	<td>
						 		<button id="delete" class="btn btn-outline-success">삭제</button>
						 	</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- class = row -->
	</div>
<script>
$(document).on('click','#delete',function(){
	var del = confirm('삭제하시겠습니까?')
	if(del){
		var pr_code = $(this).parent().siblings('#code').text();
		$.ajax({
			async:false,
			type:'POST',
			data: {pr_code : pr_code },
			url:"<%=request.getContextPath()%>/admin/product/deleted",
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
		$(this).parent().siblings('#code').parent().remove();
	}
});
</script>
</body>
</html>