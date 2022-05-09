<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
</style>
<body>
		<form class="container find body" method="post" action="<%=request.getContextPath()%>/order/orderBuy">
			<h1 style="text-align: center; margin: 50px 0;">주문 / 결제</h1>
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
							<td><input type="text" name="list[${s.index }].ol_amount" value="${i.ca_amount }" readonly style="border:none"></td>
							<td><input type="number" class="price" name="list[${s.index }].ol_price" value="${i.ca_price }" readonly style="border:none"></td>
							<td><input type="hidden" name="list[${s.index }].ol_op_num" value="${i.op_num }"></td>
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
				<span>이름 : </span> <input type="text" name="od_name"> <hr>
				<span>연락처 : </span> <input type="text" name="od_phone"> <hr>
				<span>주소 : </span> 
				<input type="text" id="postcode" placeholder="우편번호" name="od_address1" class="form-control col-6">
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="form-control col-6">
				<input type="text" id="address" placeholder="주소" name="od_address2" class="form-control mb-2">
				<input type="text" id="detailAddress" placeholder="상세주소" name="od_address3" class="form-control mb-2">
				<hr>
				<span>배송메세지 : </span> <input type="text" name="od_delivery_msg"> <hr>
			</div>
			<hr>
			<h5>주문상품 할인적용</h5>
			<div class="discount_info">
				<span>적립금 사용: </span>
				<input type="number" name="od_useRw" id="rw" min="0" value="0"/>
				<input type="checkbox" id="rw_all">전액사용
				<span style="font-size:12px">(사용가능 적립금 :</span>
				<span id="available_rw" style="font-size:12px"></span><span style="font-size:12px">원)</span>
				<input type="hidden" value="${user.me_rw }" id="total_reward">
				 <hr>
				<span>쿠폰 사용: </span> <input type="number" id="cp" value="0" readonly/> 
				<button type="button" onclick="openPopUp()">쿠폰선택</button> <hr>
				<input type="hidden" name="od_hc_num" id="hc-num" value="0">
			</div>
			<hr>
			<h5>금액 확인</h5>
			<div class="total_price">
				<span>상품 합계 : </span><input id="pr_total" name="od_total" value="0" style="border:none" readonly> <span>원</span><hr>
			  <span>배송비 : </span><input name="od_delivery" class="delivery" value="0" style="border:none" readonly> <span>원</span><hr>
			  <input type="hidden" value="${user.me_gr_num }" id="gr_num">
			  <span>적립금 : </span><input id="addRw" name="od_addRw" style="border:none" value="0" readonly><span>원</span> <hr>
				<span>최종 결제금액 : </span><input class="pay" name="od_pay" style="border:none" readonly><span>원</span> <hr>
			</div>
			<h5>결제 정보</h5>
			<div class="pay_info">
				<span>결제방법</span> <hr>
				<input type="radio">신용카드 <hr>
				<input type="radio">휴대폰 결제 <hr>
				<input type="radio">실시간 계좌이체 <hr>
				<input type="radio">에스크로 <hr>
				<input type="radio">무통장입금 <hr>
				<input type="radio">카카오페이(KAKAOPAY) <hr>
				<input type="radio">페이코(PAYCO) <hr>
				<input type="radio">스마일페이 <hr>
				<input type="radio">토스 <hr>
				<input type="radio">차이(CHAI) <hr>
			</div>
			<div>
				<input type="checkbox" name="agree">
				<span>상기 결제정보를 확인하였으며, 구매진행에 동의합니다.</span> <hr>
			</div>
			<button>주문하기</button> <button type="button" >취소하기</button>
		</form>
	<script>
	//상품합계,적립금,배송비
	console.log('test');
	var prTotal =0;
	var rw = 0;
	rw = $('#total_reward').val();
	//사용적립금
	$('#available_rw').text(rw);
	//상품합계계산
	$('.price').each(function(){
		prTotal += parseInt($(this).val
				());
	});

	//상품합계
	$('#pr_total').val(prTotal);
	//배송비,지불금액 계산
	if(prTotal < 30000){
		console.log('delon');
		$('.delivery').val(3000);
		prTotal += 3000;
		$('.pay').val(prTotal);
	}else{
		console.log('delno');
		$('.pay').val(prTotal);
	}

	//적립금계산
	if($('#gr_num').val() == 1)
		$('#addRw').val(Math.floor($('#pr_total').val() * 0.01));
	if($('#gr_num').val() == 2)
		$('#addRw').val(Math.floor($('#pr_total').val() * 0.02));
	if($('#gr_num').val() == 3)
		$('#addRw').val(Math.floor($('#pr_total').val() * 0.03));
	if($('#gr_num').val() == 4)
		$('#addRw').val(Math.floor($('#pr_total').val() * 0.05));
	
	//적립금,쿠폰 사용시 합계변경
	$('#rw, #cp').on('change',function(){
		if(parseInt($('#rw').val()) > parseInt(rw)){
			console.log($('#rw').val())
			console.log(rw)
			alert('보유 적립금을 초과했습니다.');
			$('#rw').val(rw);
			return;
		}
		
		if($('#rw_all').is(':checked')){
			$('#rw_all').prop('checked',false);			
		}
		
		$('#available_rw').text(rw - parseInt($('#rw').val()));
		setTotal();
	});
	
	//합계 계산 메소드
	function setTotal(){
		var total = 0;
		total = prTotal - $('#rw').val() - $('#cp').val();
		$('.pay').val(total);
	};
	
	//쿠폰버튼 클릭시
	function openPopUp() {
			var openCp = window.open("<%=request.getContextPath()%>/order/couponPopup", "cpPopUp", "width=600, height=630, top=150, left=200");
			//openCp.document.getElementById('pr_total').value = document.getElementById('pr_total').value;
	}
	//적립금 전액사용
	$('#rw_all').click(function(){
		if($(this).is(':checked')){
			$('#rw').val(rw);
			setTotal();
		}
	})
	
	
	//주소
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if(data.userSelectedType === 'R'){
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
				
				} 
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress").focus();
			}
		}).open();
		
		//동의 체크
		$('form').submit(function(){
			var isAgree = $('[name=agree]').is(':checked');
			//동의에 체크되지 않으면
			if(!isAgree){
				alert('동의에 체크해야합니다.');
				$('[name=agree]').focus();
				return false;
			}
			
		});
}
	</script>
	</body>
</html>