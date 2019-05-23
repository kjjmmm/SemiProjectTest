<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<<<<<<< HEAD
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Nanum+Gothic|Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>	
	
<style>
body {
	font-family: "Nanum Gothic";
	height: 100%;
}

.wrapper {
	width: 400px;
	margin: auto;
	padding: 40px;
	border: 1px solid #e4e4e4;
	border-radius: 5px;
}

.top_wrapper {
	display: flex;
	justify-content: space-between;
	height: 40px;
	align-items: center;
	position: relative;
	margin: auto;
}

a {
	font-weight: bold;
}

a:hover {
	color: #000000;
}

.title {
	margin-bottom: 40px;
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

#zip {
	display: inline-block;
	margin-top: 20px;
}

#inputZip {
	display: inline-block;
}

.helper {
	font-size: 12px;
}

#pw_form, #pw_match {
	font-size: 12px;
}

#divBtnJoin {
	text-align: center;
}

#checkPassword {
	margin-bottom: 5px;
}

#inputEmail {
	display: inline-block;
}

li {
	width: 130px;
}

ul {
	margin: auto;
}

</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light">
		<a class="navbar-brand" href="#">Walk Together</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="#"></a></li>
				<li class="nav-item"><a class="nav-link" href="#">��������</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#">������湲�</a></li>
				<li class="nav-item"><a class="nav-link" href="#">濡�洹몄��</a></li>
				<li class="nav-item"><a class="nav-link" href="#">����媛���</a></li>
			</ul>
		</div>
	</nav>


<!-- 	<nav class="navbar navbar-expand-lg navbar-light bg-light"> -->
<!-- 		<a class="navbar-brand" href="#">Crowd Funding</a> -->
<!-- 		<button class="navbar-toggler" type="button" data-toggle="collapse" -->
<!-- 			data-target="#navbarNav" aria-controls="navbarNav" -->
<!-- 			aria-expanded="false" aria-label="Toggle navigation"> -->
<!-- 			<span class="navbar-toggler-icon"></span> -->
<!-- 		</button> -->
<!-- 		<div class="collapse navbar-collapse" id="navbarNav"> -->
<!-- 			<ul class="navbar-nav"> -->
<!-- 				<li class="nav-item"><a class="nav-link" href="#">��媛�</a></li> -->
<!-- 				<li class="nav-item"><a class="nav-link" href="#">��������</a></li> -->
<!-- 				<li class="nav-item"><a class="nav-link" href="#">������湲�</a></li> -->
<!-- 				<li class="nav-item"><a class="nav-link" href="#">濡�洹몄��</a></li> -->
<!-- 				<li class="nav-item"><a class="nav-link" href="#">����媛���</a></li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
<!-- 	</nav> -->
	
	
	<!-- 	<div class="container"> -->
	<!--  		 <div class="row"> -->
	<!--     		<div id="logo" class="col-lg-1" style="font-family: Georgia, serif; font-weight: bold; font-size: 25px;"> -->
	<!--       			Crowd Funding -->
	<!--     		</div> -->
	<!--     		<div id="projects" class="col-lg-1"> -->

	<!--     		</div> -->
	<!--     		<div id="projects" class="col-lg-2"> -->
	<!--       			<a href="" class="look_projects" style="color: #777676">��濡����� ���щ낫湲�</a> -->
	<!--     		</div> -->
	<!--     		<div id="makeProject" class="col-lg-2"> -->
	<!--       			<a href="" class="upload_project" style="color: #777676">��濡����� �щ━湲�</a> -->
	<!--     		</div> -->
	<!--     		<div class="col-lg-4"> -->

	<!--     		</div> -->
	<!--     		<div id="login" class="col-lg-1"> -->
	<!--       			<a href="" class="a_login_join" style="color: #777676">濡�洹몄��</a> -->
	<!--     		</div> -->
	<!--     		<div id="join" class="col-lg-1"> -->
	<!--       			<a href="" class="a_login_join" style="color: #777676">����媛���</a> -->
	<!--     		</div> -->
	<!--   		</div> -->
	<!-- 	</div> -->
	<hr>
	<form>
		<div class="wrapper">
			<div class="title">
				<h3>����媛���</h3>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="name" name="name"
					placeholder="�ъ�⑺���� �대�" required>
			</div>
			<div class="form-group">
				<input type="email" class="form-control" id="inputEmail"
					name="email" placeholder="�대��� 怨���" style="width: 70%" required>
				<button type="button" id="btnConfirmEmail"
					class="btn btn-outline-info">�몄���湲�</button>
			</div>
			<div id="divPw" class="form-group">
				<input type="password" class="form-control" id="inputPassword"
					name="pw" placeholder="鍮�諛�踰���" required><em class="helper">��臾�,
					�レ��, �뱀��臾몄�� (!@#$%^&*+=-)瑜� 議고�⑺�� 8�� �댁��</em>
				<p id="pw_form"></p>
			</div>
			<div class="form-group">
				<input type="password" class="form-control" id="checkPassword"
					placeholder="鍮�諛�踰��� ����" required>
				<p id="pw_match"></p>
			</div>
			<div id="zip" class="form-group">
				<input type="text" id="inputZip" class="form-control" name="zip"
					style="width: 50%" placeholder="�고�몃���" readonly>
				<button type="button" id="search" class="btn btn-outline-info">李얘린</button>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="inputAddress"
					name="address1" placeholder="二쇱��" readonly>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="inputAddress2"
					name="address2" placeholder="���몄＜��">
			</div>

			<div id="divBtnJoin">
				<button type="submit" id="btnJoin" class="btn btn-primary">媛�����湲�</button>
			</div>
		</div>
	</form>


=======
</head>
<body>
>>>>>>> 365fde083420d41f6d507f7248857f5b8a73d665
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