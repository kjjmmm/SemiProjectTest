<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editing</title>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<style>
    div{
        box-sizing: border-box;
    }
	#wrapper{
        margin: auto;
        margin-top: 50px;
        width: 800px;
    }
    hr{
    	border : thin solid dodgerblue;
        color: dodgerblue;
        margin-bottom: 10px;
        margin-top: 10px;
    }
    #footer{
        height: 50px;
    }
    .btns{
        text-align: right;
        margin-top: 10px;
        margin-bottom: 10px;
        margin-right: 10px;
        float: right;
    }
    #mytitle{
    	height: 50px;
    }
</style>
</head>
<body>
	<div id="wrapper" class="container p-1">
        <form id="article" action="editedArticle.board" method="post">
        	<input type="hidden" name="textNo" value="${result.textNo}">
            <div class="row p-0 m-0">
	            <div class="col-12 p-0 m-0">
	                <input type="text" name="mytitle" placeholder="제목을 입력해 주세요." value="${result.title}">
	            </div>
	        </div>
	        <div class="row">
		        <div id="content" class="col-12">
				  	<div id="summernote" contenteditable="true">${result.contents}</div>
				  	<input id="mycontent" type="hidden" name="mycontent">
				</div>
			</div>
	        <div id="footer" class="row">
	        	<div class="col-12">    
		            <div class="btns">
	                    <input id="sendit" class="btn btn-sm btn-outline-primary" type="button" value="수정하기">
		            </div>
		            <div class="btns">
		                <a href="textList.board?currentPage=${result.textNo}" class="btn btn-sm btn-outline-primary">취소</a>
		            </div>
	            </div>
	        </div> 
        </form>
    </div>
    
    <script>
	    $(window).on("beforeunload", function(){
	    	$("img").each(function(index, item){
	    		var src = $(this).attr("src");
	    		$.ajax({
					url: "deleteImage.board",
					data: {src : src},
					type: "POST",
					cache: false
				})
	    	})
	    });
    
        $("#sendit").on("click", function(){
            $("#mycontent").val($(".note-editable").html());
            $("#article").submit();
        })
        
         $('#summernote').summernote({
	        placeholder: '내용을 입력해주세요.',
	        tabsize: 2,
	        height: 500,
	        
	        callbacks: { // 값이 하나 이상이기 때문에 객체로 넣어줌.
	        	onImageUpload: function(files, editor, welEditable) { 
	        		for(var i = files.length - 1; i >= 0; i--){
	        			sendFile(files[i], this);
	        		}
	            },
        		
		        onMediaDelete : function(target) {
		            deleteFile(target[0].src);
		        }
	     	}
    	});     		
        
        function sendFile(file, editor) {
			var data = new FormData();
	    	data.append("file", file);
	        $.ajax({
	        	url:"uploadImage.board",
	        	data: data,
	        	type:"POST",
	        	cache: false,
	        	contentType: false,
	        	enctype: "multipart/form-data",
	        	processData: false
	        }).done(function(resp){
	        	$(".note-editable").append("<img src='"+resp+"'>");
	        })
        }
        
        function deleteFile(src) {
            $.ajax({
                data: {src : src},
                type: "POST",
                url: "deleteImage.board", // replace with your url
                cache: false,
                success: function(resp) {
                	if(resp == "true"){
                		console.log("정상 삭제");
                	}else{
                		console.log("삭제 실패");	
                	}
                }
            });
        }
        
        $("#cancel").on("click", function(){
        	$("img").each(function(index, item){
        		var src = $(this).attr("src");
        		$.ajax({
    				url: "deleteImage.board",
    				data: {src : src},
    				type: "POST",
    				cache: false
    			})
        	})
        	location.href="textList.board?currentPage=${currentPage}";
        })
    </script>
</body>
</html>