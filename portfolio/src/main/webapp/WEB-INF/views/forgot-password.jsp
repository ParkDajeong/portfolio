<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>HAPO Community</title>
		<link rel="icon" sizes="16x16" href="/resources/img/lightning.ico">
		<link href="/resources/css/login.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" href="//cdn.jsdelivr.net/font-nanum/1.0/nanumbarungothic/nanumbarungothic.css">
		<style>
			header {
				height: 180px;
			}
			.submitWrap {
				margin-top: 15px;
			}
			.info {
				padding: 5px 15px 18px;
				color: white;
				font-size: 16px;
			}
			/********* 반응형 *********/
			@media (max-width: 500px) {
				header, footer {
					height: 110px;
				}
			}
		</style>
	</head>
	<body>
		<section>
			<header>
				<a class="close">
					<img src="/resources/img/close.png">
				</a>
			</header>
			<div id="loginBox">
				<div class="banner">
					<a href="/"><img src="/resources/img/menu/logo3_fix.png"></a>
				</div>
				<h1>비밀번호 변경</h1>
				<div class="info">회원 가입 시, 사용하신 이메일 주소를 입력하시면<br>임시 비밀번호를 보내드립니다.</div>
				<div class="wrapper emailBox">
					<span>이메일 주소</span>
					<input type="text" name="email" id="email">
				</div>
				<div class="error">
					<span>
						잘못된 이메일 형식입니다. 이메일을 다시 확인해주세요.
					</span>
				</div>
				<div class="submitWrap">
					<button class="btns continue">CONTINUE</button>
				</div>
			</div>
			<footer></footer>
		</section>
	</body>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function() {
			$(".close").click(function() {
				history.go(-1);
			});
			
			$(".continue").click(function() {
				var email = $("#email").val();
				var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

				if(!$("#email").val()){
					alert("이메일을 입력해주세요.");
					return;
				}
				
				if (regExp.test(email)) {
					$(".error").css("display", "none");
					
					$.ajax({
						url			: "/forgot-password/mail",
						dataType	: "json",
						data		: {email : email},
						type		: "POST",
						success		: function(retVal) {
							if(retVal.code == "success") {
								location.href = "/";
							} else if(retVal.code == "OK") {
								alert("임시 비밀번호를 발급했습니다. 메일함을 확인하세요.");
								location.href = "/login";
							} else{
								alert("임시 비밀번호 발급에 실패하였습니다. 잠시 후 다시 시도하세요.");
							}
						},
						error		: function(request, status, error){
		        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
		       			}
					});
				} else {
					$(".error").css("display", "inherit");
					$("#email").focus();
					return false;
				}
			});
		});
	</script>
</html>