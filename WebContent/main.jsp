<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
.progress {
	width: 200px;
}

.progress-bar {
	background-color: orange;
}

.wrapper {
	display: inline-block;
}
</style>
</head>
<body>
	모금기간 : 2019-05-15 ~ 2019-05-29
	<br><button id="fund">모금현황</button>
	<div class="wrapper">
		<div class="progress">
			<div class="progress-bar" role="progressbar" style="width: ${percentage}%"
				aria-valuenow="${percentage }" aria-valuemin="0" aria-valuemax="100"></div>
		</div>
	</div>${percentage } %
	<script>
		document.getElementById("fund").onclick = function(){
			location.href="Fund";
		}
	</script>
</body>
</html>