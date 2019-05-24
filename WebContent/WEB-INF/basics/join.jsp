<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		if(${result} > 0){
			alert("회원이 되신걸 환영합니다!!");
			location.href = "login.jsp";
		}else{
			alert("회원가입에 실패했습니다. 죄송합니다");
			location.href = "main.jsp";
		}
	</script>
</body>
</html>