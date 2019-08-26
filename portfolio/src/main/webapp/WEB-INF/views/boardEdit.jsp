<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<html>
	<head>
		<link href="/resources/css/boardEdit.css" type="text/css" rel="stylesheet">
		<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- 부트스트랩 -->
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
		<!-- summer note -->
		<script src="/resources/summer_note/summernote.js"></script>
		<link rel="stylesheet" href="/resources/summer_note/summernote.css">
		<script>
			$(document).ready(function () {
				
				$("#content").summernote({
					height: 500,
					minHeight: null,
					maxHeight: null
				});
				
		        $("#save").click(function(){
		        	if($("#subject").val().trim() == ""){
                    	alert("제목을 입력해주세요.");
                    	$("#subject").focus();
                    	return false;
                    }
		        	
		        	var objParams = {
		        			board_id	: $("#board_id").val(),
		        			subject		: $("#subject").val(),
		        			content		: $("#content").val(),
		        			writer		: $("#writer").val()
		        	};
		        	
		        	$.ajax ({
		        		url			: "/board/save",
		        		dataType	: "json",
		        		contentType :	"application/x-www-form-urlencoded; charset=UTF-8",
		        		data		: objParams,
		        		type		: "POST",
		        		success		: function(retVal) {
		        			if(retVal.code == "success"){
		        				location.href = "/";	
		        			} else{
		        				alert("등록에 실패하였습니다.");
		        			}
		        		},
		        		error		: function(request, status, error){
		        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
            			}
		        	});
		        });
			});
		</script>
	</head>
	<body>
		<jsp:include page="top.jsp"/>
		<div id="main">
			<section class="section_editor">
					<input type="hidden" id="board_id" name="board_id" value="${boardEdit.id}" />
					<input type="hidden" id="writer" name="writer" value="${sessionScope.user_email}" />
					<div>
					<div class="editor_wrapper">
						<h2>New Post</h2>
						<div id="post_title">
							<input type="text" id="subject" name="subject" placeholder="제목" value="${boardEdit.subject}" autocomplete=off>
						</div>
						<!-- <textarea placeholder="글을 작성해주세요" name="content" id="content" rows="10" cols="80"></textarea>
						<input type="file" id="fileUP" name="fileUP" multiple/> -->
						<textarea name="content" id="content">${boardEdit.content}</textarea>
					</div>
					<div class="btnWrapper">
						<button id="save" type="button" class="btn_postSave bttn-jelly bttn-md bttn-primary" name="save">저장</button>
					</div>
					</div>
			</section>
		</div>
	</body>
</html>