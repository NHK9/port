<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/additional-methods.min.js"></script>
</head>
<body>
	<form class="body container" action="<%=request.getContextPath()%>/admin/member/cpRegister" method="post">
		<h1 class="jumbotron" style="text-align: center; margin: 50px 0;">쿠폰 등록</h1>
		<div class="form-group">
			<label for="cp_name">쿠폰명</label>
		  <input type="text" class="form-control" name="cp_name">
		</div>
		<div class="form-group">
			<label for="cp_code">쿠폰코드</label>
		  <input type="text" class="form-control" name="cp_code">
		  <button type="button" id="codeCheck" class="btn btn-outline-success col-12">중복확인</button>
		</div>
		<div class="form-group">
			<label for="cp_discount">할인율</label>
		  <input type="number" class="form-control" name="cp_discount">
		</div>
		<button class="btn btn-outline-success col-12">등록</button>
	</form>
	<script>
	var codeCheck = false;
	console.log('asd')
	$('#codeCheck').click(function(){
		var code = $('[name=cp_code]').val();
		$.ajax({
			async:false,
			type:'POST',
			data: {code : code },
			url:"<%=request.getContextPath()%>/admin/codeCheck",
			success : function(res){
		    if(res == 'ok')
		    	codeCheck = true;
		    else
		    	codeCheck = false;
		    //idCheck = res == 'ok' ? true : false;
		    if(codeCheck)
		    	alert('사용 가능한 코드입니다.');
		    else
		    	alert('이미 사용 중인 코드입니다.');
			}
		});
	});
	
	$('[name=cp_code]').change(function(){
		codeCheck = false;
	});
	
	$('form').submit(function(){
		if(!codeCheck){
			alert('코드 중복검사를 해야합니다.');
			return false;
		}
		
	});
	$("form").validate({
	      rules: {
	        cp_name: {
	          required : true
	        },
	        cp_code: {
		          required : true
		        },
		      cp_discount:{
	        	required : true
	        }
	      },
	      //규칙체크 실패시 출력될 메시지
	      messages : {
	    	  cp_name: {
	          required : "필수로입력하세요",
	        },
	        cp_code: {
	          required : "필수로입력하세요",
	        },
	        cp_discount: {
	        	required : "필수로입력하세요"
	        }
	      }
	    });
	</script>
</body>
</html>