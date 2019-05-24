<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<style>
    #wrapper{
        width: 800px;
        margin: auto;
        margin-top: 50px;
    }    
    #writeInfo{
    	text-align: right;
    }
    #content{
    	border: 1px solid dodgerblue;
    	width: 100%;
        height: 700px;
        overflow-y: auto;
    }
    .btns{
        text-align: right;
        margin-top: 10px;
        margin-bottom: 10px;
        margin-right: 10px;
        float: right;
    }
/*     img{ */
/*     	width: 300px; */
/*     	height: 300px; */
/*     } */
</style>
</head>
<body>
	<div id="wrapper" class="container">
		<div class="row text-center">
		    <div class="col-12 my-2"><h3>${result.title}</h3></div>
		</div>
		<div id="writeInfo" class="row">
			<div class="col-4"></div>
		    <div class="col-3">작성자 : ${result.writer}</div>
		    <div class="col-3">작성일 : ${result.writedate}</div>
		    <div class="col-2">조회수 : ${result.viewCount}</div>
		</div>
		<div class="row">
		    <div id="content" class="col-12 mt-2">${result.contents}</div>
		</div>
		<div class="row">
			<div class="btns">
				<a href="textList.board?currentPage=1" class="btn btn-sm btn-outline-primary">목록</a>
			</div>
			<c:if test="${result.writer == myId}">
				<div class="btns">
		            <a href="editArticle.board?textNo=${result.textNo}" class="btn btn-sm btn-outline-primary">수정</a>
		        </div>
				<div class="btns">
		            <a href="removeArticle.board?textNo=${result.textNo}" class="btn btn-sm btn-outline-primary">삭제</a>
		        </div>
	        </c:if>
		</div>
	</div>
</body>
</html>