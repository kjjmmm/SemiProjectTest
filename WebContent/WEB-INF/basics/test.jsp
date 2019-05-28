<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>테스트 페이지</title>
</head>

<body>
	<nav class="navbar navbar-expand-md navbar-light navbar-fixed-top">
		<div class="logo">
			<a class="navbar-brand" href="main.jsp"><img src="logo/bridge_logo2.png"
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
				<li class="nav-item"><a class="nav-link" href="to_write.board">후원해 주세요</a></li>
				<li class="nav-item"><a class="nav-link" href="textList.board?currentPage=1">후원 게시판</a></li>


				<c:choose>
					<c:when test="${sessionScope.loginEmail != null}">
						<li class="nav-item"><a class="nav-link" href="Logout.members">로그아웃</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a class="nav-link" href="LoginForm.members">로그인</a></li>
						<li class="nav-item"><a class="nav-link" href="JoinForm.members">회원가입</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>
	
	<form action="">
	   <select>
    	<option value="0">금액 선택</option>
    	<option value="1000">1,000원</option>
    	<option value="5000">5,000원</option>
    	<option value="10000">10,000원</option>
    	<option value="20000">20,000원</option>
        <option value>기타 입력</option>
    </select>
		후원하실 금액 : <input type="text" id="amount">
	</form>
	<input id="check_module" type="button" value="후원하기">
	</p>
	<script>
		$("#check_module").click(function() {
			var IMP = window.IMP; // 생략가능
			IMP.init('imp84992027'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			IMP.request_pay({
				pg : 'inicis', // version 1.1.0부터 지원.
				/* 
				    'kakao':카카오페이, 
				    html5_inicis':이니시스(웹표준결제)
				        'nice':나이스페이
				        'jtnet':제이티넷
				        'uplus':LG유플러스
				        'danal':다날
				        'payco':페이코
				        'syrup':시럽페이
				        'paypal':페이팔
				 */
				pay_method : 'card',
				/* 
				    'samsung':삼성페이, 
				    'card':신용카드, 
				    'trans':실시간계좌이체,
				    'vbank':가상계좌,
				    'phone':휴대폰소액결제 
				 */
				merchant_uid : 'merchant_' + new Date().getTime(),
				/* 
				    merchant_uid에 경우 
				    https://docs.iamport.kr/implementation/payment
				    위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				    참고하세요. 
				    나중에 포스팅 해볼게요.
				 */
				name : '주문명:결제테스트', //결제창에서 보여질 이름 //// 후원명 불러오기
				amount : $("#amount").val(), // 입력받은 금액
				buyer_email : '', // 사용자가 로그인한 email 불러오기
				// 사용자 정보 불러오기
				buyer_name : '',
				buyer_tel : '010-1234-5678',
				buyer_addr : '',
				buyer_postcode : '',
				m_redirect_url : ''
			/*  
			    모바일 결제시,
			    결제가 끝나고 랜딩되는 URL을 지정 
			    (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐) 
			 */
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
					location.href = "success.jsp";

					jQuery.ajax({
						url : "https://www.myservice.com/payments/complete", // 가맹점 서버
						method : "POST",
						headers : {
							"Content-Type" : "application/json"
						},
						data : {
							imp_uid : rsp.imp_uid,
							merchant_uid : rsp.merchant_uid
						}
					}).done(function(data) {
						
					})

				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					location.href = "test.jsp";
				}
				alert(msg);
			});
		});
	</script>
</body>

</html>