<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		if(${result} == 1){
			alert("글이 성공적으로 등록되었습니다.");
			location.href = "textList.board?currentPage=1";
		}else{
			alert("등록에 실패했습니다. 다시 시도해주세요.");
			location.href = "newArticle.board";	
		}
	</script>
</body>
</html>