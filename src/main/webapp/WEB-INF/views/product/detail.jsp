<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/default.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<div class="line">
	</div>			
		<div class="content_top">
			<div class="ct_left_area">
					<div class="image-box">
						<img src="<%=request.getContextPath()%>/img${product.pr_img}" class="thumb-image">
					</div>		
			</div>
			<div class="ct_right_area">
				<div class="title">
					<h1>
						${product.pr_name}
					</h1>
				</div>
				<div class="line"></div>
				<div class="price">
					<div class="discount_price">
						판매가 : <span class="discount_price_number">${product.getPr_discount_price()}</span>
						<span style="text-decoration: line-through; pont-size:12px; color:gray;">${product.pr_price}</span>					
				</div>			
				<div class="line">
				</div>
				<div class="option">
					옵션 :
					<select name="choice" id="choice">
						<option class="default">옵션 선택</option>
						<c:forEach var="o" items="${option}" varStatus="vs">
							<option value="${o.op_colnsize}" data-target="${o.op_num}">${o.op_colnsize}</option>
						</c:forEach>					
					</select>
					<hr>
				</div>
				<div class="added_option">
				</div>
				<div class="total">
				<span>총 합계 :</span><strong id="total"></strong><span>원</span>
				</div>
					<div class="button_set">
						<button class="btn_cart" type="button">장바구니</button>
						<button class="btn_buy" type="button">구매하기</button>
					</div>
				</div>
			</div>
		</div>
		<div class="line">
		</div>				
		<div class="content_middle">
			<div class="pr_content">
				${product.pr_desc}
			</div>
		</div>
		<div class="line">
		</div>				
		<div class="content_bottom">
		</div>
<script>
	var tot = 0;
	$('#choice').on('change',function(){
		var val = $(this).val();
		var dup = false;
		//선택된 옵션의 이름들을 하나씩 가져와서 지금 선택한 옵션 이름과 비교하여
		//중복되면 dup를 true
		$('.colnsize').each(function(){
			var colnsize = $(this).text();
			if(colnsize == val){
				dup = true;
			}
		});
		if(dup){
			$(this).find('.default').prop("selected",true);
			alert('이미 추가된 옵션입니다');
			return;			
		}else{
		var price = '${product.pr_discount_price}'
		var op_num;
		$(this).children().each(function(){
			var name = $(this).val();
			if(name == val)
				op_num = $(this).data('target');
		});
		
		var str = 
			'<span class="sel-option">' +
				'<span class="colnsize">'+ val + '</span>'		+
				'<input type="number" value="1" min="1" required="required" class="option-count"/>' +
				'<span class="price">'+price+'</span>' +
				'<button class="btn-del-option">X</button>' +
				'<input type="hidden" value="'+op_num+'" class="op_num"/>'+
				'<hr>' +
			'</span>';
		
		
		$('.added_option').append(str);	
		tot += parseInt(price);
		$('#total').text(tot);
		}
		
		$(this).find('.default').prop("selected",true);
		
	})
	$(document).on('click','.option-count',function(){
		tot = 0;
		$('.option-count').each(function(){
			var total = 0;
			var price = parseInt('${product.pr_discount_price}');
			var count = parseInt($(this).val());
			total = price * count;
			$(this).siblings('.price').text(total);
			
			tot += parseInt(total);
		})
		
		$('#total').text(tot);
	});
	//장바구니
	$(document).on('click','.btn_cart', function(){
		$('.sel-option').each(function(){
			var ca_amount = $(this).children('.option-count').val();
			var ca_op_num = $(this).children('.op_num').val();
			var ca_price = $(this).children('.price').text();
			var cart = {
					ca_amount : ca_amount,
					ca_op_num : ca_op_num,
					ca_price  : ca_price
			}
			//ajax
			$.ajax({
	      async:false,
	      type:'POST',
	      data:JSON.stringify(cart),
	      url: "<%=request.getContextPath()%>/order/cart/insert",
	      contentType:"application/json; charset=UTF-8",
	      success : function(res){
	        if(res == "true")
	        	alert('장바구니에 추가 되었습니다')
	        if(res == "login")
	        	alert('login')
	        if(res == "false")
	        	alert('최소 한개 이상의 옵션을 선택해야 합니다')
	      }
	  	});
			
		})
		
	});
	$(document).on('click','.btn-del-option', function(){
		tot -= parseInt($(this).siblings('.price').text());
		$(this).parent().remove();
		$('#total').text(tot);
	});
</script>
</body>
</html>