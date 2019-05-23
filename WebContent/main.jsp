<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Nanum+Gothic|Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
  src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>	
<style>
body {
	font-family: "Nanum Gothic";
	height: 100%;
}

.progress {
	width: 200px;
}

.progress-bar {
	background-color: orange;
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

.card-deck {
	width: 900px;
	margin: auto;
}

.hope {
	text-align: center;
	margin-bottom: 20px;
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

.btn-primary:active, .btn-primary:visited, .btn-primary:active:focus,
	.btn-primary:active:hover {
	border-color: #639d34;
	background-color: #639d34;
	color: #FFF;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-md navbar-light">
		<div class="logo">
			<a class="navbar-brand" href="main.jsp"><img src="logo.png"
				width="150px"></a>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="#">소개</a></li>
				<li class="nav-item"><a class="nav-link" href="#">후원안내</a></li>
				<li class="nav-item"><a class="nav-link" href="#">후원하기</a></li>
				<li class="nav-item"><a class="nav-link" href="loginForm.jsp">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="joinForm.jsp">회원가입</a></li>
			</ul>
		</div>
	</nav>

	<div class="hope">
		<img src="hope.png">
	</div>
	<hr>

	<div class="card-deck">
		<div class="card">
			<img src="boy wrestler.jpg" class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title">식물인간 아버지를 지키는 소년 레슬러 동호</h5>
				<p class="card-text">
					모금기간 <br>2019-05-15 ~ 2019-05-29 <br>
					
				<div class="wrapper">
					<div class="progress">
						<div id="card1" class="progress-bar" role="progressbar"
							 aria-valuenow="${percentage }"
							aria-valuemin="0" aria-valuemax="100"></div>
					</div>
				</div><span id="card1_span"></span>


			</div>
			<div class="card-footer">
				<button type="button" class="btn btn-primary">후원하기</button>
				<small class="text-muted"></small>
			</div>
		</div>
		<div class="card">
			<img src="plastic.jpg" class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title">환경을 위협하는 플라스틱</h5>
				<p class="card-text">This card has supporting text below as a
					natural lead-in to additional content.</p>
			</div>
			<div class="card-footer">
				<small class="text-muted"></small>
			</div>
		</div>
		<div class="card">
			<img src="..." class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title">Card title</h5>
				<p class="card-text">This is a wider card with supporting text
					below as a natural lead-in to additional content. This card has
					even longer content than the first to show that equal height
					action.</p>
			</div>
			<div class="card-footer">
				<small class="text-muted"></small>
			</div>
		</div>
	</div>


	<script>
		$.ajax({
			url : "Fund",
			type : "post",
			
		}).done(function(resp) {
			$("#card1").css("width",resp+"%");
			$("#card1_span").text(resp+"%");
		})
	</script>
</body>
</html>