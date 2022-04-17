<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
<head>
	<title>Home</title>
	<style >
	.box, .box:hover{
		width : 100px; height : 100px; border : 1px solid red;
		color : red; line-height: 100px; text-align: center;
		font-weight: bold; font-size: 50px; display: block;
		text-decoration: none;
	}
	.thumb-image{
		width : 300px; 
	}
	
	</style>
</head>
<body>
<form class="body container" action="<%=request.getContextPath()%>/원하는url" method="post" enctype="multipart-formdata">
	<input type="file" name="files"multiple accept="image/*" id="fileUpload" style="display: none">
	<a class="box" href="javascript:;">+</a>
	<div id="image-holder"></div>
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
/*
$(document).on('click','.thumb-image', function(){
	if(confirm('이미지를 삭제하겠습니까?')){
		$(this).remove();
	}
});
*/
/*
$(document).on('click','.btn_cart', function(){
		var amount = $();
		var price = ;
		if(num => 0){
			$.ajax({
				async:false,
				type:'POST',
				data: {ca_amount : amount, ca_price : price },
				url:"<%=request.getContextPath()%>/order/cart/insert",
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
		
	});
 */
</script>
</body>
</html>