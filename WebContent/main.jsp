<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Nanum+Gothic|Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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

.carousel-item {
	height: 400px;
	width: 800px;
}

.carousel {
	height: 400px;
	width: 800px;
	margin: auto;
}

.card-img-top {
	height: 150px;
}

#img_carousel {
	position: absolute;
}

.text3 {
	position: relative;
	color: white;
	font-size: 30px;
	top: 300px;
	left: 450px;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-md navbar-light navbar-fixed-top">
		<div class="logo">
			<a class="navbar-brand" href="main.jsp"><img
				src="logo/bridge_logo2.png" width="150px"></a>
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
				<li class="nav-item"><a class="nav-link" href="">후원 게시판</a></li>
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
	<!-- 캐러셀 -->
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel" data-interval="false">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="photo_image/hope.png" id="" class="d-block w-100"
					alt="...">

			</div>
			<div class="carousel-item">
				<img src="photo_image/hands.png" id="img_carousel"
					class="d-block w-100" alt="...">

			</div>
			<div class="carousel-item">
				<img src="photo_image/handbyhand.png" id="img_carousel"
					class="d-block w-100" alt="...">
				<div class="text3">
					<p>당신의 손길이 필요합니다.</p>
				</div>
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<hr>

	<div class="card-deck">
		<div class="card">
			<img src="photo_image/boy wrestler.jpg" class="card-img-top"
				alt="...">
			<div class="card-body">
				<h5 class="card-title">식물인간 아버지를 지키는 소년 레슬러 동호</h5>
				<p class="card-text">
					모금기간 <br>2019-05-15 ~ 2019-05-29 <br>
				</p>
				<div class="wrapper">
					<div class="progress">
						<div id="card1" class="progress-bar" role="progressbar"
							aria-valuenow="${percentage }" aria-valuemin="0"
							aria-valuemax="100"></div>
					</div>
				</div>
			</div>
			<div class="card-footer">
				<button type="button" class="btn btn-primary">후원하기</button>
				<small class="text-muted"></small>
			</div>
		</div>
		<div class="card">
			<img src="photo_image/plastic.jpg" class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title">
					환경을 위협하는 플라스틱<br>
				</h5>
				<p class="card-text">
					모금기간 <br>2019-05-15 ~ 2019-05-29 <br>
				</p>
				<div class="wrapper">
					<div class="progress">
						<div id="card1" class="progress-bar" role="progressbar"
							aria-valuenow="${percentage }" aria-valuemin="0"
							aria-valuemax="100"></div>
					</div>
				</div>
			</div>
			<div class="card-footer">
				<button type="button" class="btn btn-primary">후원하기</button>
				<small class="text-muted"></small>
			</div>
		</div>
		<div class="card">
			<img src="photo_image/전화상담원.jpg" class="card-img-top" alt="...">
			<div class="card-body">
				<h5 class="card-title">청소년 학교폭력상담원 지원</h5>
				<p class="card-text">
					모금기간 <br>2019-05-15 ~ 2019-05-29 <br>
				</p>
				<div class="wrapper">
					<div class="progress">
						<div id="card1" class="progress-bar" role="progressbar"
							aria-valuenow="${percentage }" aria-valuemin="0"
							aria-valuemax="100"></div>
					</div>
				</div>
			</div>
			<div class="card-footer">
				<button type="button" class="btn btn-primary">후원하기</button>
				<small class="text-muted"></small>
			</div>
		</div>
	</div>


	<script>
		$.ajax({
			url : "Fund",
			type : "post",

		}).done(function(resp) {
			$("#card1").css("width", resp + "%");
			$("#card1_span").text(resp + "%");
		})
	</script>
	
	<c:if test="${navercontents.name != null }">
	
		<script>

		alert("${navercontents.name}님 반갑습니다 !");
		
	</script>
	
	</c:if>
</body>
</html>