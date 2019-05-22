<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<script>
		if(${result == "true"}){
			alert("로그인에 성공했습니다.");
			location.href = "main.jsp";
		}else{
			alert("이메일 또는 비밀번호를 다시 확인해주세요.");
			location.href = "loginForm.jsp";
		}
	</script>
</body>
</html>