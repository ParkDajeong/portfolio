<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
	<head>
		<link href="/resources/css/login.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<section>
			<header></header>
			<div id="loginBox">
				<div class="banner">
					<img src="/resources/img/top/hogwarts-3476786_1920.png">
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
			$(".continue").click(function() {
				var objParam = {
						email 		: $("#email").val(),
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
						} else{
							$("#password").val("");
							$(".error").css("display", "block");
						}
					},
					error		: function(request, status, error){
	        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
	       			}
				});
			});
		});
	</script>
</html>