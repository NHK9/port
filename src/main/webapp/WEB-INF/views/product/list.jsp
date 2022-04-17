<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/default.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<div class="content">
		<div class="main_box">
					<h2>${type}</h2>
		</div>
		<div class="prdBrand">
			<div class="item-wrap">
				<div class="item-sort">
					<p class="ea">
						총
						<strong>${totalCount }</strong>
						개의 상품이 있습니다.
					</p>
					<div class="sort">
						<select onchange="location.href=this.value">
						<option>상품정렬</option>
						<option value="">신상품순</option>
						<option value="">낮은 가격순</option>
						<option value="">높은 가격순</option>
						</select>
					</div>
				</div>
				<div class="item-cont">
					<c:forEach items="${list}" var="list">
						<dl class="item-list">
							<dt>
								<a class="image-box" href="<%=request.getContextPath()%>/product/detail?pr_code=${list.pr_code}">
									<img src="<%=request.getContextPath()%>/img${list.pr_img}" class="image-thumbnail">
								</a>
							</dt>
							<dd>
								<div>
									<div class="prd-name">${list.pr_name}</div>
									<div class="priceBox">
										<span class="percent dis_rate3">${list.pr_discount}%</span>
										<span class="prd-price s_prd">${list.getPr_discount_price() }</span>
										<span class="o_prd">${list.pr_price }</span>
									</div>
								</div>
							</dd>
						</dl>
					</c:forEach>
				</div>
				<div class="item-page"></div>
			</div>
		</div>
	</div>
	<div>
			<ul class="pagination justify-content-center">
   		<c:if test="${pm.prev}">
		    <li class="page-item">
		    	<a class="page-link" href="<%=request.getContextPath()%>/product/list?page=${pm.criteria.page-1}&search=${pm.criteria.search}&type=${pm.criteria.type}">이전</a>
		    </li>
	    </c:if>
	    <c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
	    	<c:if test="${i != pm.criteria.page }">
			    <li class="page-item">
			    	<a class="page-link" href="<%=request.getContextPath()%>/product/list?page=${i}&search=${pm.criteria.search}&type=${pm.criteria.type}">${i}</a>
			    </li>
		    </c:if>
		    <c:if test="${i == pm.criteria.page }">
			    <li class="page-item active">
			    	<a class="page-link" href="<%=request.getContextPath()%>/product/list?page=${i}&search=${pm.criteria.search}&type=${pm.criteria.type}">${i}</a>
			    </li>
		    </c:if>
	    </c:forEach>
	    <c:if test="${pm.next}">
		    <li class="page-item">
		    	<a class="page-link" href="<%=request.getContextPath()%>/product/list?page=${pm.criteria.page+1}&search=${pm.criteria.search}&type=${pm.criteria.type}">다음</a>
		    </li>
	    </c:if>
	  </ul>
	</div>
<script>
</script>
</body>
</html>