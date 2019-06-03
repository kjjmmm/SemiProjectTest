<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
        <link rel="stylesheet"
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link
              href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua|Nanum+Gothic|Nanum+Gothic+Coding&display=swap"
              rel="stylesheet">
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Cute+Font|Noto+Serif+KR:700|Do+Hyeon|Sunflower:300|Jua|Nanum+Gothic|Nanum+Gothic+Coding&display=swap" rel="stylesheet">

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
                margin-bottom: 30px;
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
                margin-top:20px;
            }

            #inputZip {
                display: inline-block;
            }

            .helper {
                font-size: 12px;
            }
            #pw_form, #pw_match, #emailCheck{
                font-size:12px;
            }
            #divBtnJoin{
                text-align:center;
            }
            #checkPassword{
                margin-bottom:5px;
            }
            #inputEmail,#inputPassword,#inputPasswordCheck,#phone{
                display:inline-block;
                width: auto;
            }
            ul {
                margin: auto;
            }

            li {
                width: 130px;
            }
            .myhr1{
                border: 0;
                height: 1px;
                background-color: white;
            }
            .first{
                letter-spacing: 1px;
                margin-left: 3em;
                display: block;
                color: gray;
                line-height: 21px;
                min-width: 70px;
            }
            .first-pw{
                letter-spacing: 1px;
                margin-left: 3em;
                display: block;
                color: gray;
                line-height: 35px;
            }
            .first-phone{
                letter-spacing: 1px;
                margin-left: 3em;
                display: block;
                color: gray;
                line-height: 35px;
            }
            .second{
                font-weight: 600;
                margin-left: 1em;
            }
            .white{
                border: 0px;
                margin-right: 2em;
                height: 30px;
                font-weight: 600;
            }
            .wrap{
                border: 3px solid #1ebdd850;
                border-radius: 10px;
                padding: 50px;


            }
            hr{
                border-color: #1ebdd850;
            }
            #top{
                border-color: whitesmoke
            }
            .update{
                position: relative;
                top: 40px;
                left: 45%;
            }
            #address1,#address2{
                width: 270px;
            }
            #zipcode{
                background-color: #1ebdd830;
                border-color: #1ebdd850;
            }
            #addressbt{
                position: relative;
            }
            small{
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-md navbar-light">
            <div class="logo">
                <a class="navbar-brand" href="Main.members" style="font-family: 'Cute Font', cursive;"><h1>도움닿기</h1></a>
            </div>
            <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarNav" aria-gcontrols="navbarNav"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="Introduce.members">소개</a></li>
                    <li class="nav-item"><a class="nav-link" href="write.board">후원해
                        주세요</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="textList.board?currentPage=1">후원 게시판</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="LoginForm.members">로그인</a></li>
                    <li class="nav-item"><a class="nav-link"
                                            href="JoinForm.members">회원가입</a></li>
                </ul>
            </div>
        </nav>
        <hr id="top">
        <br><br><br>

        <form action="myPageUpdateForNaver.members" method="post">

            <div class="container wrap">
                <h3>내 정보 관리</h3>
                <br>
                <hr  class="myhr1">
                <div class="row">
                    <div class="col-2 d-md-block d-none"><span class="first">이메일</span></div>
                    <div class="col-10 "><span class="second">${realcontents.email}${navercontents.email }</span></div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-2 d-md-block d-none"><span class="first">이름</span></div>
                    <div class="col-10"><span class="second">${realcontents.name }${navercontents.name }</span></div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-2 d-md-block d-none"><span class="first-phone first">연락처</span></div>

                    <div class="col-10"><span><span class="form-inline">
                        <div class="form-group">
                            <input type="text" class="form-control mx-sm-3 second" name="phone" id="phone" value="${realcontents.phone }" required>
                        </div>
                        </span></span></div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-2"><span class="first-pw first">주소</span></div>
                    <div class="col-10"><span><span class="form-inline">
                        <div class="form-group">
                            <input type="text" id="zipcode" class="form-control mx-sm-3 second" readonly value="${realcontents.zipCode }" name="zipcode">
                            <button type="button" class="btn btn-info d-sm-block d-none" id="addressbt">찾기</button>
                        </div>
                        </span></span></div>
                </div>
                <br>
                <div class="row">
                    <div class="col-2"><span class="first-pw"></span></div>
                    <div class="col-10"><span><span class="form-inline">
                        <div class="form-group">
                            <input type="text" id="address1" class="second form-control mx-sm-3" value="${realcontents.address1 }" name="address1">
                        </div>
                        </span></span></div>
                </div>
                <br>

                <div class="row">
                    <div class="col-2"><span class="first-pw first d-md-block d-none">상세 주소</span></div>
                    <div class="col-10"><span><span class="form-inline">
                        <div class="form-group">
                            <input type="text" id="address2" class="second form-control mx-sm-3" value="${realcontents.address2 }" name="address2">

                        </div>
                        </span></span></div>
                </div>
                <div class="row"><div class="col-12">
                    <input type="submit" class="btn btn-info update" id="update" value="수정 하기"></input>
                </div>
            </div>
            </div>
        </form>

    <script>

        document.getElementById("addressbt").onclick = function() {
            new daum.Postcode(
                {
                    oncomplete : function(data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                        if (data.userSelectedType === 'R') {
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if (data.bname !== ''
                                && /[동|로|가]$/g.test(data.bname)) {
                                extraAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if (data.buildingName !== ''
                                && data.apartment === 'Y') {
                                extraAddr += (extraAddr !== '' ? ', '
                                              + data.buildingName
                                              : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if (extraAddr !== '') {
                                extraAddr = ' (' + extraAddr + ')';
                            }
                            // 조합된 참고항목을 해당 필드에 넣는다.
                            document.getElementById("address1").value = extraAddr;

                        } else {
                            document.getElementById("address1").value = '';
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        document.getElementById('zipcode').value = data.zonecode;
                        document.getElementById("address1").value = addr;
                        // 커서를 상세주소 필드로 이동한다.
                        document.getElementById("address2").focus();
                    }
                }).open();
        }

    </script>
    </body>
</html>