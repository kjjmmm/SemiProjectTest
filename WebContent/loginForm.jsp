<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.login_box {
	width: 400px;
	margin: auto;
	padding: 40px;
	border: 1px solid #e4e4e4;
	border-radius: 5px;
}

a:hover {
	text-decoration: none;
	font-weight: bold;
}

#toJoin {
	color: black;
	text-align: center;
	font-size: 15px;
	text-decoration: none;
	margin: 20px 0px 20px;
}

.form-control::placeholder {
	font-size: 15px;
}

#forget_pw {
	margin-top: 20px;
	text-decoration: none;
	font-size: 14px;
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

.title {
	margin-bottom: 20px;
}

.save_find {
	font-size: 13px;
	display: inline-block;
}

.find_id {
	text-align: right;
}
/* .top_wrapper{ */
/* 	display:flex; */
/* 	justify-content:space-around; */
/* 	height:40px; */
/* 	align-items:center; */
/* 	position:relative; */
/* 	margin:auto; */
/* } */
a {
	font-weight: bold;
}

a:hover {
	color: #000000;
}
ul{
	margin:auto;
}
#navbarNav{
	
}
li{
	width:130px;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light">
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
				<li class="nav-item"><a class="nav-link" href="#">후원안내</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#">후원하기</a></li>
				<li class="nav-item"><a class="nav-link" href="#">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="#">회원가입</a></li>
			</ul>
		</div>
	</nav>


<!-- 	<div class="container"> -->
<!-- 		<div id="nav" class="row"> -->
<!-- 			<div id="logo" class="col-lg-2 d-none d-md-block" -->
<!-- 				style="font-family: Georgia, serif; font-weight: bold; font-size: 20px;"> -->
<!-- 				Crowd Funding</div> -->
<!-- 			<div id="projects" class="col-lg-2 d-none d-sm-block"> -->
<!-- 				<a href="" class="look_projects" style="color: #777676">프로젝트 -->
<!-- 					둘러보기</a> -->
<!-- 			</div> -->
<!-- 			<div id="makeProject" class="col-lg-2 d-none d-sm-block"> -->
<!-- 				<a href="" class="upload_project" style="color: #777676">프로젝트 -->
<!-- 					올리기</a> -->
<!-- 			</div> -->
<!-- 			<div class="col-lg-4"></div> -->
<!-- 			<div id="login" class="col-lg-1"> -->
<!-- 				<a href="" class="a_login_join" style="color: #777676">로그인</a> -->
<!-- 			</div> -->
<!-- 			<div id="join" class="col-lg-1"> -->
<!-- 				<a href="" class="a_login_join" style="color: #777676">회원가입</a> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

	<hr>
	<div class="wrapper">
		<div class="login_box">
			<div class="title">
				<h3>로그인</h3>
			</div>
			<form action="Login.members" method="post">
				<div class="form-group">
					<input type="email" class="form-control" id="exampleInputEmail1"
						name="email" aria-describedby="emailHelp" placeholder="이메일 주소(아이디)">
				</div>
				<div class="form-group">
					<input type="password" class="form-control"
						id="exampleInputPassword1" name="pw"
						placeholder="비밀번호 (영문,숫자,특수문자 포함 8자 이상)">
				</div>
				<div class="save_find">
					<a href="" class="find_id" style="color: black">아이디·비밀번호 찾기></a>
				</div>
				<button type="submit" class="btn btn-primary btn-md btn-block"
					style="font-size: 18px; font-weight: bold;">로그인</button>

				<div id="toJoin">
					아직 계정이 없으신가요?&nbsp;&nbsp;&nbsp;<a href="joinForm.jsp" id="a_join"
						style="color: black">가입하기</a>
				</div>
			</form>
			<hr>
			<div id="forget_pw" style="text-align: center">
				<a href="" style="color: black">혹시 비밀번호를 잊으셨나요?</a>
			</div>
		</div>
	</div>
</body>
</html>