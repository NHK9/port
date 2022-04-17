<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 적용 팝업</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<div>
		<div>
			<h5 style="text-align:center">쿠폰 적용</h5> <hr>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>쿠폰명</th>
						<th>할인율</th>
						<th>할인금액</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="i">
							<tr>
								<td>${i.cp_name }</td>
								<td class="discount">${i.cp_discount }</td>
								<td class="discount_price"><input type="text" name="discountPrice" style="border:none" readonly></td>
								<td><button type="button" class="apply-btn" value="${i.hc_num }" >적용</button></td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<input type="hidden" id="pr_total" value="0">
		</div>
	</div>
	<script>
		//주문창에서 상품합계 가져옴
		$('#pr_total').val(opener.document.getElementById('pr_total').value);
		
		//할인금액 계산
		$('.discount_price').each(function(){
			var total = 0;
			var prTotal = $("#pr_total").val();
			var disc = $(this).siblings('.discount').text();
			total = parseInt(prTotal) * parseInt(disc) / 100;
			$(this).children().val(Math.floor(total));
		})
		
		//주문창으로 쿠폰번호,할인금액 넘김
		$('.apply-btn').click(function(){
			opener.document.getElementById("hc-num").value = $(this).val();
			opener.document.getElementById("cp").value = $(this).parent().siblings('.discount_price').find('[name=discountPrice]').val();
			window.opener.$('#cp').trigger('change');
			window.close();
		});
	</script>
</body>
</html>