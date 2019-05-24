<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
</head>
<body>
	<form action="LimChart" method="post">
		<input type="text" name="barNum">
		<input type="text" name="percentNum">
		<input type="submit" id="sm">
	</form>
	
	<script>
		document.getElementById("sm").onclick = function(){
			location.href="LimChart";
		}
	
	</script>
</body>
</html>