<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>HAPO-Community</title>
		<link href="/resources/css/join.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<section>
			<header>
				<a class="close">
					<img src="/resources/img/close.png">
				</a>
			</header>
			<div id="loginBox">
				<h1>JOIN US</h1>
				<div id="joinForm">
					<div class="wrapper nicknameBox">
						<span>닉네임</span>
						<input type="text" name="nickname" id="nickname">
						<span class="warn nickname">이미 사용중인 닉네임입니다.</span>
					</div>
					<div class="wrapper idBox">
						<span>이메일 주소</span>
						<input type="text" name="email" id="email">
						<span class="warn email">잘못된 이메일 형식입니다.</span>
					</div>
					<div class="wrapper idComfirmBox">
						<span>이메일 주소 확인</span>
						<input type="text" name="confirmEmail" id="confirmEmail">
						<span class="warn confirm">이메일이 다릅니다. 다시 입력하세요.</span>
					</div>
					<div class="wrapper pwBox">
						<span>비밀번호</span>
						<input type="password" name="password" id="password">
					</div>
					<div class="pwChk">
						<img class="overChk" src="/resources/img/check.png" width="16px"><span class="must over8Word">최소 8자 이상</span>
						<img class="mixChk" src="/resources/img/check.png" width="16px"><span class="must mixNumAlphabet">숫자와 영문자 혼용</span>
					</div>
					<div class="submitWrap">
						<button class="btns join"><span>JOIN</span><div class="circle display-none"></div></button>
					</div>
				</div>
			</div>
		</section>
		<footer></footer>
	</body>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/join.js" type="text/javascript"></script>
</html>