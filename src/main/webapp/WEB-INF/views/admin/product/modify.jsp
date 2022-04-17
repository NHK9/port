<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
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
	
	.thumb-image {
	    width:100%;
	    height:100%;
	    object-fit:cover;
	}
</style>
<body>
	<form class="body container" action="<%=request.getContextPath()%>/admin/product/modify" method="post" enctype="multipart/form-data">
		<h1>상품 정보 수정</h1>
		<div class="image-box">          
			<input type="file" name="files2" multiple accept="image/*" id="fileUpload" style="display: none">
				<label>이미지</label>
				<a class="box" href="javascript:;">+</a>
			<div id="image-holder" class="image-box">
				<img src="<%=request.getContextPath()%>/img${product.pr_img}" class="thumb-image">
			</div>
		</div>
		<div class="form-group">
			<label for="pr_code">상품코드</label>
		  <input type="text" class="form-control" name="pr_code" value="${product.pr_code}" readonly>
		</div>
		<div class="form-group">
			<label for="pr_name">상품명</label>
		  <input type="text" class="form-control" name="pr_name" value="${product.pr_name}">
		</div>
		<div class="form-group">
			<label for="pr_price">가격</label>
		  <input type="text" class="form-control" name="pr_price" value="${product.pr_price}">
		</div>
		<div class="form-group">
			<label for="pr_gender">성별</label>
		  <select class="form-control" name="pr_gender">
		  	<option value="A" <c:if test="${product.pr_gender == 'A' }">selected</c:if>>공용</option>
		  	<option value="M" <c:if test="${product.pr_gender == 'M' }">selected</c:if>>남자</option>
		  	<option value="F" <c:if test="${product.pr_gender == 'F' }">selected</c:if>>여자</option>
		  </select>
		</div>
		<div class="form-group">
			<label for="pr_discount">할인율</label>
		  <input type="text" class="form-control" name="pr_discount" value="${product.pr_discount}">
		</div>
		<div class="form-group">
			<label for="pr_desc">상품설명</label>
		  <input type="text" class="form-control" name="pr_desc" value="${product.pr_desc}">
		</div>
		<div class="form-group">
			<label for="pr_cg_name">카테고리</label>
		  <select class="form-control" name="pr_cg_name">
			  <c:forEach var="i" items="${category}">
			    <option value="${i.cg_name}" <c:if test="${i.cg_name eq product.pr_cg_name}">selected</c:if>>${i.cg_name}</option>
			  </c:forEach>
			</select>
		</div>
			<c:forEach var="o" items="${option}" varStatus="vs">
				<div class="form-group opt">
					<input type="hidden" class="form-control co" name="list[${vs.index}].op_num" value="${o.op_num}">
					<input type="hidden" class="form-control" name="list[${vs.index}].op_pr_code" value="${o.op_pr_code}">
					<label for="op_colnsize">색상&사이즈</label>
					<input type="text" class="form-control op_colnsize" name="list[${vs.index}].op_colnsize" value="${o.op_colnsize}">
					<label for="op_amount">수량</label>
					<input type="text" class="form-control" name="list[${vs.index}].op_amount" value="${o.op_amount}">			
				  <button type="button" class="btn-option-delete">삭제</button>
				  <hr>
				</div>
			</c:forEach>
		
		<button type="button" class="btn-option-insert">옵션추가</button>		
		<button class="btn btn-outline-success col-12">수정</button>
	</form>
<script>
$("#fileUpload").on('change', function () {

    //Get count of selected files
    var countFiles = $(this)[0].files.length;

    var imgPath = $(this)[0].value;
    //확장자 체크
    var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
    var image_holder = $("#image-holder");
    
    if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
        if (typeof (FileReader) != "undefined") {

				    image_holder.empty();
            //loop for each file selected for uploaded.
            for (var i = 0; i < countFiles; i++) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $("<img />", {
                        "src": e.target.result,
                            "class": "thumb-image"
                    }).appendTo(image_holder);
                }

                image_holder.show();
                reader.readAsDataURL($(this)[0].files[i]);
            }

        } else {
            alert("This browser does not support FileReader.");
        }
    } else {
        alert("Pls select only images");
    }
});
$('.box').click(function(){
	$('#fileUpload').click();
})
//옵션 추가버튼 클릭
$(document).on('click','.btn-option-insert', function(){	
	var index = $('.op_colnsize').length;
	var str = 
		'<div class="form-group opt">' + 
			'<label for="op_colnsize">' +
			'색상&사이즈' +
			'</label>' +
			'<input type="text" class="form-control op_colnsize" name="list['+index+'].op_colnsize">' +
			'<label for="op_colnsize">' +
			'수량' + 
			'</label>' +
			'<input type="text" class="form-control" name="list['+index+'].op_amount">' +
			'<button type="button" class="btn-option-delete">' + 
			'삭제' +
			'</button>' +
		'</div>';

	$(this).before(str);
});
$(document).on('click','.btn-option-delete', function(){
	var num = $(this).siblings('.co').val();
	if(num => 0){
		$.ajax({
			async:false,
			type:'POST',
			data: {op_num : num },
			url:"<%=request.getContextPath()%>/admin/option/deleted",
			success : function(res){
		    if(res == 'ok')
		    	deleted = true;
		    else
		    	deleted = false;
		    if(deleted)
		    	alert('삭제 되었습니다');
		    else
		    	alert('삭제 되었습니다');
			}
		});
	}
	$(this).parent().remove();
});
</script>
</body>
</html>