<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true" %>
	
<head>
	<link href="/resources/css/boardView.css" type="text/css" rel="stylesheet">
</head>

<div class="modal-header">
	<input type="hidden" id="board_id" name="board_id" value="${boardView.id}" />
	<h4 class="smaller lighter blue no-margin modal-title">${boardView.subject}</h4>
	<div class="contnetInfo">
		<span class="writer">${boardView.nickname}
			<c:if test="${sessionScope.user_email == boardView.writer}">
				<a style="color: red;" class="modify">수정</a>
				<a style="color: blue;" class="delete">삭제</a>
			</c:if>
		</span>
		<span class="info">${boardView.register_datetime} <span class="view">조회 ${boardView.read_count}</span></span>
	</div>
	<!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close" aria-hidden="true">×</button> -->
</div>
<div class="modal-body">
	${boardView.content}
</div>
<!-- 댓글 -->
<div class="modal-footer">
	<span class="commentView">이 게시물에 달린 코멘트 <span>${replyCnt}</span>개</span>
	<c:if test="${sessionScope.user_nickname != null}">
		<div class="writeComment">
			<div class="c_writer">${sessionScope.user_nickname}</div>
			<textarea class="c_inputBox" placeholder="댓글을 달아주세요:)" cols="20"></textarea>
			<button class="btn btn-outline-secondary insert">등록</button>
		</div>
	</c:if>
	<c:forEach var="replyView" items="${replyView}">
		<div class="replyWrapper">
			<c:if test="${replyView.depth == 0}">
				<div class="MaincommetWrap">
					<input type="hidden" id="reply_id" name="reply_id" value="${replyView.reply_id}" />
					<span class="reply_user">${replyView.nickname}</span>&nbsp;&nbsp;
					<span><a style="color: green;" class="reply_comment">답글</a></span>
					<span class="replyWriterBtn">
						<c:if test="${sessionScope.user_email == boardView.writer}">
							<a style="color: red;" class="reply_modify">수정</a>
							<a style="color: blue;" class="reply_delete">삭제</a>
						</c:if>
					</span>
					<div class="commentContent">${replyView.reply_content}</div>
					<span class="reply_date">${replyView.regDate}</span>
				</div>
			</c:if>
			<c:if test="${replyView.depth > 0}">
				<div class="commentWrap">
					<div class="arrow">
						<img src="/resources/img/commnet_Arrow.png">
					</div>&nbsp;
					<div class="SubcommetWrap">
						<input type="hidden" id="reply_id" name="reply_id" value="${replyView.reply_id}" />
						<span class="reply_user">${replyView.nickname}</span>&nbsp;&nbsp;
						<span class="replyWriterBtn">
							<c:if test="${sessionScope.user_email == boardView.writer}">
								<a style="color: red;" class="reply_modify">수정</a>
								<a style="color: blue;" class="reply_delete">삭제</a>
							</c:if>
						</span>
						<div class="commentContent">${replyView.reply_content}</div>
						<span class="reply_date">${replyView.regDate}</span>
					</div>
				</div>
			</c:if>
		</div>
	</c:forEach>
</div>

<script>
	$(document).ready(function() {
		//게시글 수정
		$(".modify").click(function() {
			location.href="/board/edit?board_id=" + $("#board_id").val();
		});
		
		//게시글 삭제
		$(".delete").click(function() {
			var objParam = {
					board_id	: $("#board_id").val()
			}
			
			$.ajax({
				url			: "/board/delete",
				dataType	: "json",
				data		: objParam,
				type		: "POST",
				success		: function(retVal){
					if(retVal.code == "success") {
						alert("게시글을 삭제하였습니다.");
						location.href = "/";
					} else{
						alert("삭제에 실패하였습니다.");
					}
				},
				error		: function(request, status, error){
        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
       			}
			});
		});
		
		//댓글 등록
		$(".insert").click(function() {
			var replyCnt = parseInt($(".commentView > span").text());
			var writer = "${sessionScope.user_email}";
			var nickname = "${sessionScope.user_nickname}";
			var reply_content = $(".c_inputBox").val();
			var objParams = {
					board_id		: $("#board_id").val(),
					parent_id		: 0,
					depth			: 0,
					reply_content	: reply_content,
					reply_writer	: writer
			}
			
			$.ajax({
				url			: "/board/reply/save",
				dataType	: "json",
				data		: objParams,
				type		: "POST",
				async		: false,
				success		: function(retVal) {
					if(retVal.code == "success") {
						$(".c_inputBox").val("");
						$(".modal-footer").append(
								"<div class='replyWrapper'>" + 
								"<div class='MaincommetWrap'>" +
								"<input type='hidden' id='reply_id' name='reply_id' value='"+ retVal.reply_id +"' />" +
								"<span class='reply_user'>" + nickname +"</span>&nbsp;&nbsp;" +
								"<span><a style='color: green;' class='reply_comment'>답글</a></span>" +
								"<span class='replyWriterBtn'>" + 
								"<a style='color: red;' class='reply_modify'>수정</a>" +
								"<a style='color: blue;' class='reply_delete'>삭제</a></span>" +
								"<div class='commentContent'>"+ reply_content +"</div>" +
								"<span class='reply_date'>" + retVal.regDate + "</span></div></div>"
							);
						$(".commentView > span").text(replyCnt++);
					} else{
						alert(retVal.message);
					}
				},
				error		: function(request, status, error){
        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
       			}
			});
		});
		
		//댓글 삭제
		$(document).on("click", ".reply_delete", function(){
			var replyCnt = parseInt($(".commentView > span").text());
			var parent  = $(this).parent().parent().parent();
			var objParam = {
					reply_id	: parent.find("#reply_id").val()
			}
			
			$.ajax({
				url			: "/board/reply/delete",
				dataType	: "json",
				data		: objParam,
				type		: "POST",
				success		: function(retVal){
					if(retVal.code == "success") {
						alert("댓글을 삭제하였습니다.");
						parent.remove();
						$(".commentView > span").text(replyCnt--);
					} else{
						alert("삭제에 실패하였습니다.");
					}
				},
				error		: function(request, status, error){
        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
       			}
			});
		});
		
		var content;
		//댓글 수정
		$(document).on("click", ".reply_modify", function(){
			var contentDiv = $(this).parent().siblings(".commentContent");
			content = contentDiv.text();
			$(this).text("취소");
			$(this).attr("class","cancel");
			
			contentDiv.html(
					"<textarea class='modifyBox' cols='20'>" + content + "</textarea>" + 
					"<input type='button' class='btn btn-outline-secondary reply_modifySave' value='수정'>"
				);
		});
		
		//댓글 수정 저장
		$(document).on("click", ".reply_modifySave", function(){
			var contentDiv  = $(this).parent();
			var reply_content = $(".modifyBox").val();
			var reply_id = $(this).parent().siblings("#reply_id").val();
			var objParams = {
					reply_id		: reply_id,
					reply_content	: reply_content
			}
			
			$.ajax({
				url			: "/board/reply/modify",
				dataType	: "json",
				data		: objParams,
				type		: "POST",
				success		: function(retVal) {
					if(retVal.code == "success") {
						contentDiv.html(reply_content);
						$(".cancel").text("수정");
						$(".cancel").attr("class","reply_modify");
					} else{
						alert("댓글 수정에 실패하였습니다.");
					}
				},
				error		: function(request, status, error){
        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
       			}
			});
		});
		
		//댓글 수정 취소
		$(document).on("click", ".cancel", function(){ 
			var div = $(this).parent().siblings(".commentContent");
			$(this).text("수정");
			$(this).attr("class","reply_modify");
			div.empty();
			div.text(content);
		});
		
		//답글 버튼 클릭
		$(document).on("click", ".reply_comment", function(){
			var parent = $(this).parent().parent().parent();
			parent.find(".commentWrap").remove();
			parent.append(
					"<div class='commentWrap'>" +
					"<div class='arrow'><img src='/resources/img/commnet_Arrow.png'></div>&nbsp;" +
					"<div class='writeComment'>" +
					"<div class='c_writer'>${sessionScope.user_nickname}</div>" + 
					"<textarea class='c_inputBox' placeholder='내용을 입력해주세요:)' cols='20'></textarea>" +
					"<input type='button' class='btn btn-outline-secondary commentInsert' value='등록'></div></div>"
				);
		});
		
		//답글 등록
		$(document).on("click", ".commentInsert", function(){
			var replyCnt = parseInt($(".commentView > span").text());
			var writer = "${sessionScope.user_email}";
			var nickname = "${sessionScope.user_nickname}";
			var reply_content = $(this).siblings(".c_inputBox").val();
			var parent_id = $(this).parent().parent().siblings(".MaincommetWrap").find("#reply_id").val();
			var parent = $(this).parent().parent();
			
			var objParams = {
					board_id		: $("#board_id").val(),
					parent_id		: parent_id,
					depth			: 1,
					reply_content	: reply_content,
					reply_writer	: writer
			}
			
			$.ajax({
				url			: "/board/reply/save",
				dataType	: "json",
				data		: objParams,
				type		: "POST",
				success		: function(retVal) {
					if(retVal.code == "success") {
						$(".c_inputBox").val("");
						parent.find(".writeComment").remove();
						parent.append(
								"<div class='SubcommetWrap'>" +
								"<input type='hidden' id='reply_id' name='reply_id' value='"+ retVal.reply_id +"' />" +
								"<span class='reply_user'>" + nickname +"</span>&nbsp;&nbsp;" +
								"<span class='replyWriterBtn'>" + 
								"<a style='color: red;' class='reply_modify'>수정</a>" +
								"<a style='color: blue;' class='reply_delete'>삭제</a></span>" +
								"<div class='commentContent'>"+ reply_content +"</div>" +
								"<span class='reply_date'>" + retVal.regDate + "</span></div>"
							);
						$(".commentView > span").text(replyCnt++);
							
					} else{
						alert(retVal.message);
					}
				},
				error		: function(request, status, error){
        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
       			}
			});
		});
	});
</script>