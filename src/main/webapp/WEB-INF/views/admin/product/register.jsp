<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<style>
	.opt{
		border: 1px solid gray;
		padding-bottom: 5px;
		box-sizing: border-box;
	}
</style>
<body>
	<form class="body container" action="<%=request.getContextPath()%>/admin/product/register" method="post" enctype="multipart/form-data">
		<h1>상품 등록</h1>
		<input type="file" name="files2"multiple accept="image/*" id="fileUpload" style="display: none">
			<label>이미지</label>
			<a class="box" href="javascript:;">+</a>
		<div id="image-holder"></div>
		<div class="form-group">
			<label for="pr_code">상품코드</label>
		  <input type="text" class="form-control" name="pr_code">
		</div>
		<div class="form-group">
			<label for="pr_name">상품명</label>
		  <input type="text" class="form-control" name="pr_name">
		</div>
		<div class="form-group">
			<label for="pr_price">가격</label>
		  <input type="text" class="form-control" name="pr_price">
		</div>
		<div class="form-group">
			<label for="pr_gender">성별</label>
		  <select class="form-control" name="pr_gender">
		  	<option value="A">공용</option>
		  	<option value="M">남자</option>
		  	<option value="F">여자</option>
		  </select>
		</div>
		<div class="form-group">
			<label for="pr_discount">할인율</label>
		  <input type="text" class="form-control" name="pr_discount">
		</div>
		<div class="form-group">
			<label for="pr_desc">상품설명</label>
		  <input type="text" class="form-control" name="pr_desc">
		</div>
		<div class="form-group">
			<label for="pr_cg_name">카테고리</label>
		  <select class="form-control" name="pr_cg_name">
			  <c:forEach var="i" items="${category}">
			    <option value="${i.cg_name}">${i.cg_name}</option>
			  </c:forEach>
			</select>
		</div>
		<div class="form-group opt">
			<label for="op_colnsize">색상&사이즈</label>
		  <input type="text" class="form-control op_colnsize" name="list[0].op_colnsize">
			<label for="op_amount">수량</label>
		  <input type="text" class="form-control" name="list[0].op_amount">
		</div>
		<button type="button" class="btn-option-insert">옵션추가</button>
		<button class="btn btn-outline-success col-12">등록</button>
	</form>
<script>
$("#fileUpload").on('change', function () {

    //Get count of selected files
    var countFiles = $(this)[0].files.length;

    var imgPath = $(this)[0].value;
    //확장자 체크
    var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();
    var image_holder = $("#image-holder");
    image_holder.empty();

    if (extn == "gif" || extn == "png" || extn == "jpg" || extn == "jpeg") {
        if (typeof (FileReader) != "undefined") {

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
	$(this).parent().remove();
});
</script>
</body>
</html>