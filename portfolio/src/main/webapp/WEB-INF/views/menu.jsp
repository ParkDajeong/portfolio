<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true" %>
<head>
	<link href="/resources/css/menu.css" type="text/css" rel="stylesheet">
</head>
<header>
	<div class="loginBar">
		<span>
			<c:choose>
				<c:when test="${sessionScope.user_email != null}">
					<a href="/mypage" class="nickname">${sessionScope.user_nickname}</a>
					<a href="/logout" class="logout">로그아웃</a>
				</c:when>
				<c:otherwise>
					<a href="/login" class="login">로그인</a>
					<a href="/join" class="join">회원가입</a>
				</c:otherwise>
			</c:choose>
		</span>
	</div>
	<div class="bannerWrap">
		<a href="/"><img src="/resources/img/menu/logo3.png"></a>
	</div>
	<nav>
		<div class="menuWrap">
			<ul>
				<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
					<li>
						<a href="/"><span>게시판</span></a>
					</li>
					<li>
						<a href="/admin/user/list"><span>회원 관리</span></a>
					</li>
				</c:if>
			</ul>
		</div>
	</nav>
</header>