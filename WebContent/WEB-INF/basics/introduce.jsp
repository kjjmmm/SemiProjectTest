<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Introduce</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<style>
	
	div{
    	box-sizing: border-box;
	}
	.introMain{
	    max-height: 730px;
	    object-fit: cover;
	}
	body {
	font-family: "Nanum Gothic";
	height: 100%;
	}
	.wrapper {
		display: inline-block;
	}
	a {
		font-weight: bold;
	}
	a:hover {
		color: #000000;
	}
	ul {
		margin: auto;
	}
	li {
		width: 130px;
	}
	.nav_link {
		font-family: "Nanum Gothic";
	}
	.btn-primary {
		margin: 20px 0px 20px;
		background-color: #1ebdd8;
		border-color: #1ebdd8;
		color: #FFF;
	}
	.btn-primary:hover, .btn-primary:focus {
		border-color: #28a39f;
		background-color: #28a39f;
		color: #FFF;
	}
</style>
</head>
<body>
	<div id="root">
		<nav class="navbar navbar-expand-md navbar-light navbar-fixed-top">
			<div class="logo">
				<a class="navbar-brand" href="Main.members">
				<img src="logo/bridge_logo2.png" width="150px"></a>
			</div>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="Introduce.members">소개</a></li>
					<li class="nav-item"><a class="nav-link" href="write.board">후원해 주세요</a></li>
					<li class="nav-item"><a class="nav-link" href="textList.board?currentPage=1">후원 게시판</a></li>
	
					<c:choose>
						<c:when test="${sessionScope.loginEmail != null || navercontents.name != null}">
							<li class="nav-item"><a class="nav-link"
								href="Logout.members">로그아웃</a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link" href="LoginForm.members">로그인</a></li>
							<li class="nav-item"><a class="nav-link" href="JoinForm.members">회원가입</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</nav>
		<div id="wrapper">
			<div id="header">Navi</div>
			<div class="jumbotron">
				<img src="giveyou.jpg" class="d-block introMain">
			</div>
			<div id="footer">Footer</div>
		</div>
	</div>
</body>
</html>