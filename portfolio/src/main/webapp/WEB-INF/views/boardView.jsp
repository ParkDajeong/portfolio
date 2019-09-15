<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>HAPO-Community</title>
		<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
		<link href="/resources/css/boardView.css" type="text/css" rel="stylesheet">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	</head>
	<body>
		<jsp:include page="menu.jsp"/>
		<section>
			<div id="contentWrapper">
				<div class="content-header">
					<input type="hidden" id="board_id" name="board_id" value="${boardView.id}" />
					<input type="hidden" id="user_email" name="user_email" value="${sessionScope.user_email}" />
					<input type="hidden" id="user_nickname" name="user_nickname" value="${sessionScope.user_nickname}" />
					<c:set var="post_writer" value="${boardView.writer_email}"></c:set>
					<div class="board-title">
						<h3>${boardView.subject}</h3>
						<c:if test="${sessionScope.user_email == boardView.writer_email || sessionScope.user_email == 'sobeast980@gmail.com'}">
							<span>
								<a class="modify">수정</a>
								<a class="delete">삭제</a>
							</span>
						</c:if>
					</div>
					<div class="contentInfo">
						<span class="writer" data-email="${boardView.writer_email}">${boardView.writer_nickname}</span>
						<span class="info">${boardView.register_datetime} <span class="view">조회 ${boardView.read_count}</span></span>
					</div>
				</div>
				<div class="content-body">
					${boardView.content}
				</div>
				<!-- 댓글 -->
				<div class="content-footer">
					<span class="commentCnt">Comment <span>${replyCnt}</span>개</span>
					<div class="writeComment">
						<div class="c_writer">${sessionScope.user_nickname}</div>
						<textarea class="c_inputBox" placeholder="댓글을 달아주세요:)" cols="20"></textarea>
						<button class="btn btn-outline-secondary insert">등록</button>
					</div>
					<c:forEach var="replyView" items="${replyView}">
							<c:if test="${replyView.depth == 0}">
								<div class="replyWrapper rv${replyView.reply_id}">
									<div class="MaincommetWrap">
										<div class="comment-header">
											<input type="hidden" id="reply_id" name="reply_id" value="${replyView.reply_id}" />
											<span class="reply_user" data-writer="${replyView.reply_writer_email}">${replyView.reply_writer_nickname}</span>
											<c:if test="${replyView.reply_writer_email == post_writer && replyView.reply_writer_email != 'sobeast980@gmail.com'}">
												<span class="post_owner">글쓴이</span>
											</c:if>
											<c:if test="${replyView.reply_writer_email == 'sobeast980@gmail.com'}">
												<script>$("[data-writer='sobeast980@gmail.com']").css("color", "#4f5ba7")</script>
											</c:if>
											<span class="reply_date">${replyView.regDate}</span>
											<span class="replyWriterBtn">
												<c:if test="${sessionScope.user_email != null}">
													<span><a class="reply_comment r_edit">답글</a></span>
												</c:if>
												<c:if test="${sessionScope.user_email == replyView.reply_writer_email || sessionScope.user_email == 'sobeast980@gmail.com'}">
													<a class="reply_modify r_edit">수정</a>
													<a class="reply_delete r_edit">삭제</a>
												</c:if>
											</span>
										</div>
										<div class="commentContent">${replyView.reply_content}</div>
									</div>
								</div>
							</c:if>
							<c:if test="${replyView.depth > 0}">
								<div class="commentWrap">
									<div class="arrow">
										<img src="/resources/img/commnet_Arrow.png">
									</div>&nbsp;
									<div class="SubcommetWrap">
										<div class="comment-header">
											<input type="hidden" id="reply_id" name="reply_id" value="${replyView.reply_id}" />
											<span class="reply_user" data-writer="${replyView.reply_writer_email}">${replyView.reply_writer_nickname}</span>
											<c:if test="${replyView.reply_writer_email == post_writer && replyView.reply_writer_email != 'sobeast980@gmail.com'}">
												<span class="post_owner">글쓴이</span>
											</c:if>
											<c:if test="${replyView.reply_writer_email == 'sobeast980@gmail.com'}">
												<script>$("[data-writer='sobeast980@gmail.com']").css("color", "#4f5ba7")</script>
											</c:if>
											<span class="reply_date">${replyView.regDate}</span>
											<span class="replyWriterBtn">
												<c:if test="${sessionScope.user_email == replyView.reply_writer_email || sessionScope.user_email == 'sobeast980@gmail.com'}">
													<a class="reply_modify r_edit">수정</a>
													<a class="reply_delete r_edit">삭제</a>
												</c:if>
											</span>
										</div>
										<div class="commentContent">${replyView.reply_content}</div>
									</div>
									<script>$(".rv" + ${replyView.parent_id}).append($(".commentWrap:last"));</script>
								</div>
							</c:if>
					</c:forEach>
				</div>
			</div>
		</section>
	</body>
</html>
<script src="/resources/js/boardView.js" type="text/javascript"></script>
