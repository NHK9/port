<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/default.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
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
	    *object-fit:cover;
	    display: block;
	}
</style>
<body>
	<form method="post" action="<%=request.getContextPath()%>/order/buy">
		<div class="cartWrap">
			<h2 class="page-title">장바구니</h2>
			<input type="hidden" value="${user.me_gr_num }" name="grade">
			<div class="page-body">
				<table class="col table-cart" summary="번호,사진,상품명,수량,가격">
					<colgroup>
						<col width="30">
						<col width="130">
						<col width="*">
						<col width="120">
						<col width="90">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">
								<div class="tb-center">
									<input type="checkbox" class="all_check" checked>
								</div>
							</th>
							<th scope="col" colspan="2">
								<div class="tb-center">상품명</div>
							</th>
							<th scope="col">
								<div class="tb-center">수량</div>
							</th>
							<th scope="col">
								<div class="tb-center">가격</div>
							</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<td colspan="5">
								<div class="msg">
									<ul>
										<li>${user.me_name }님은
										<span class="grade"></span>회원입니다</li>
										<li>
										${user.me_name }님은 구매시, 구매금액의
										<span class="rw"></span>를 추가 적립해 드립니다. 
										</li>
										<li>3만원 이상 구매시 무료배송이 적용됩니다.</li>
									</ul>
								</div>
							</td>
							<td colspan="4">
								<div class="tb-right" style="float:right">
									<div>
										<p class="tit">총 구매금액</p>
										<span class="prTotal" style="display:inline;"></span>
										원
									</div>
									<div>
										<p class="tit">배송비</p>
										<span class="deliveryPrice" style="display:inline;"></span>
										원
									</div>
									<div class="total">
										<p class="tit">결제 예정금액</p>
										<strong class="totalPrice" style="display:inline;"></strong>
										원
									</div>
								</div>
							</td>
						</tr>
					</tfoot>
					<tbody>
						<c:forEach items="${cart}" var="i">
							<tr>
								<td class="cart-check">
									<div class="tb-center">
										<input type="checkbox" class="cart_checkbox" value="${i.op_num }">
									</div>
								</td>
								<td class="image">
									<input class="imgVal" type="hidden" value="${i.pr_img }">
									<div class="tb-center image-box">
											<a href="<%=request.getContextPath()%>/product/detail?pr_code=${i.pr_code}">
												<img src="<%=request.getContextPath()%>/img${i.pr_img}" class="image-thumbnail">
											</a>
									</div>
								</td>
								<td class="namencolnsize">
									<div class="tb-center nameDiv">
										<p class="nameP">
											<a class="nameA" href="<%=request.getContextPath()%>/product/detail?pr_code=${i.pr_code}">
												${i.pr_name }
											</a>
										</p>
										<div class="colnsize opt">
											${i.op_colnsize }
										</div>
									</div>
								</td>
								<td class="amount">
									<div class="tb-center">
										${i.ca_amount }
									</div>
								</td>
								<td class="price">
									<div class="tb-center">
										${i.ca_price }
									</div>
								</td>
								<td class="ca-num"><input type="hidden" value="${i.ca_num }"></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btn-order-ctrl">
					<div class="btn">
						<div class="box_btn white">
							<a href="<%=request.getContextPath()%>/">쇼핑하기</a>
						</div>
						<div class="box_btn white">
							<button type="button" class="btn-del">선택삭제</button>
						</div>
						<div class="box_btn">
							<button class="btn-buy">주문하기</button>
						</div>
					</div>
				</div>
			</div> 
		</div>
	</form>
	<script>
		$(document).ready(function(){
			console.log($('[name=grade]').val())
			if($('[name=grade]').val() == '1'){
				$('.grade').text('[FRIEND]');
				$('.rw').text('1%');				
			}
			if($('[name=grade]').val() == '2'){
				$('.grade').text('[FAMILY]');
				$('.rw').text('2%');				
			}
			if($('[name=grade]').val() == '3'){
				$('.grade').text('[PREMIUM]');
				$('.rw').text('3%');				
			}
			if($('[name=grade]').val() == '4'){
				$('.grade').text('[VIP]');
				$('.rw').text('5%');				
			}
			setTotal();
		});
		//선택상품삭제
		$(document).on('click','.btn-del',function(){
			var del = confirm('삭제 하시겠습니까?');
			if(del){
				$('.ca-num').each(function(){
					if($(this).siblings('.cart-check').find('.cart_checkbox').is(":checked")){
						var ca_num = $(this).children().val();
						if(ca_num => 0){
							$.ajax({
								async:false,
								type:'POST',
								data: {ca_num : ca_num },
								url:"<%=request.getContextPath()%>/order/cart/deleted",
								success : function(res){
						    if(res == 'true'){
						    	alert('삭제 되었습니다');
						    }
						    else
						    	alert('.');
								}
							});
						}
						$(this).parent().remove();
						setTotal();
				}
			})
			}
		})
		var index = 0;
		//체크박스 변경시 합계변경
		$('.cart_checkbox').on('change', function(){
			var check = $(this).is(':checked');
			if(check){
				var amount = $(this).parent().parent().siblings('.amount').text();
				var price = $(this).parent().parent().siblings('.price').text();
				var img = $(this).parent().parent().siblings('.image').children('.imgVal').val();
				var name = $(this).parent().parent().siblings('.namencolnsize').children('.nameDiv').children('.nameP').children('.nameA').text();
				var colnsize = $(this).parent().parent().siblings('.namencolnsize').children('.nameDiv').children('.colnsize').text();
				var num = $(this).val();
				var str =
					'<td class="form_data">' +
					'<input type="hidden" name="list['+index+'].ca_amount" value="'+amount+'">'+
					'<input type="hidden" name="list['+index+'].ca_price" value="'+price+'">'+
					'<input type="hidden" name="list['+index+'].pr_img" value="'+img+'">'+
					'<input type="hidden" name="list['+index+'].pr_name" value="'+name+'">'+
					'<input type="hidden" name="list['+index+'].op_colnsize" value="'+colnsize+'">'+
					'<input type="hidden" name="list['+index+'].op_num" value="'+num+'">'+
					'</td>';
				$(this).parent().parent().parent().append(str);
				index +=1;
			}
			else{
				$(this).parent().parent().siblings('.form_data').remove();
			}
			setTotal();
		});
		$('.cart_checkbox').click();
		//상품합계메소드
		function setTotal(){
			var total = 0;
			//var delivery = 0;
			var totalprice = 0;
			$('.price').each(function(){
				if($(this).siblings('.cart-check').find('.cart_checkbox').is(":checked")){
					total += parseInt($(this).text());
				}
			});
			$('.prTotal').text(total);
			
			if(total < 30000){
				$('.deliveryPrice').text(3000);
				totalPrice = parseInt(total) + 3000;
				$('.totalPrice').text(totalPrice);
			}else{
				$('.deliveryPrice').text(0);
				totalPrice = total;
				$('.totalPrice').text(totalPrice);
			}
		}
		//전체선택
		$('.all_check').on('click', function(){

			if($('.all_check').prop("checked")){
				$('.cart_checkbox').prop("checked", true);
				$('.cart_checkbox').each(function(){
					var amount = $(this).parent().parent().siblings('.amount').text();
					var price = $(this).parent().parent().siblings('.price').text();
					var img = $(this).parent().parent().siblings('.image').children('.imgVal').val();
					var name = $(this).parent().parent().siblings('.namencolnsize').children('.nameDiv').children('.nameP').children('.nameA').text();
					var colnsize = $(this).parent().parent().siblings('.namencolnsize').children('.nameDiv').children('.colnsize').text();
					var num = $(this).val();
					var str =
						'<td class="form_data">' +
						'<input type="hidden" name="list['+index+'].ca_amount" value="'+amount+'">'+
						'<input type="hidden" name="list['+index+'].ca_price" value="'+price+'">'+
						'<input type="hidden" name="list['+index+'].pr_img" value="'+img+'">'+
						'<input type="hidden" name="list['+index+'].pr_name" value="'+name+'">'+
						'<input type="hidden" name="list['+index+'].op_colnsize" value="'+colnsize+'">'+
						'<input type="hidden" name="list['+index+'].op_num" value="'+num+'">'+
						'</td>';
					$(this).parent().parent().parent().append(str);
					index +=1;
				});
			} else{
				$('.cart_checkbox').prop("checked", false);
				$('.cart_checkbox').each(function(){
					$(this).parent().parent().siblings('.form_data').remove();
					index = 0;
				});
			}
			setTotal();
		});
	</script>
	</body>
</html>