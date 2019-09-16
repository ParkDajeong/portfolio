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
				<h1>LOGIN</h1>
				<div class="wrapper idBox">
					<span>이메일 주소</span>
					<input type="text" name="email" id="email">
				</div>
				<div class="wrapper pwBox">
					<span>비밀번호</span>
					<input type="password" name="password" id="password">
				</div>
				<div class="error">
					<span>
						이메일 또는 비밀번호를 다시 확인하세요.<br>
						등록되지 않았거나, 이메일 또는 비밀번호를 잘못 입력하셨습니다.
					</span>
				</div>
				<div class="findBtnWrap">
					<button class="btns findPwd">비밀번호를 잊으셨나요?</button>
				</div>
				<div class="submitWrap">
					<button class="btns continue">ENTER</button>
				</div>
				<span>
					새로 오셨나요? 함께해요:)&nbsp;
					<a href="/join">Join Us</a>
				</span>
			</div>
			<footer></footer>
		</section>
	</body>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		$(document).ready(function() {
			$(".findPwd").click(function() {
				location.href = "/forgot-password";
			});
			
			$(".close").click(function() {
				history.go(-1);
			});
			
			$(".wrapper > input").keydown(function(key) {
                if (key.keyCode == 13) {
                	if(!$("#email").val())
                    	alert("이메일을 입력해주세요.");
                	else if(!$("#password").val())
                		alert("비밀번호를 입력해주세요.");
                	else
                		$(".continue").click();
                }
            });
			
			$(".continue").click(function() {
				var email = $("#email").val();
				var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

				if (regExp.test(email)) {
					$(".error").css("display", "none");
				
					var objParam = {
							email 		: email,
							password	: $("#password").val()
					}
					
					$.ajax({
						url			: "/login/login",
						datatype	: "json",
						data		: objParam,
						type		: "POST",
						success		: function(retVal) {
							if(retVal.code == "success") {
								location.href = "/";
							} else if(retVal.code == "notAuth") {
								$("#password").val("");
								$("#password").focus();
								alert("로그인은 메일 인증 후에 가능합니다.");
							} else{
								$("#password").val("");
								$("#password").focus();
								$(".error").css("display", "block");
							}
						},
						error		: function(request, status, error){
		        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
		       			}
					});
				} else {
					$(".error > span").text("잘못된 이메일 형식입니다. 이메일을 다시 확인해주세요.");
					$(".error").css("display", "inherit");
					$("#password").val("");
					$("#email").focus();
					return false;
				}
			});
		});
	</script>
</html>