<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<html>
	<head>
		<link href="/resources/css/boardEdit.css" type="text/css" rel="stylesheet">
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="/resources/summer_note/summernote.css">
	</head>
	<body>
		<jsp:include page="menu.jsp"/>
		<div id="main">
			<section class="section_editor">
				<form name="writeForm" >
					<input type="hidden" id="board_id" name="board_id" value="${boardEdit.id}" />
					<input type="hidden" id="writer_nickname" name="writer_nickname" value="${sessionScope.user_nickname}" />
					<input type="hidden" id="writer_email" name="writer_email" value="${sessionScope.user_email}" />
					<div>
					<div class="editor_wrapper">
						<h2>New Post</h2>
						<div id="post_title">
							<input type="text" id="subject" name="subject" placeholder="제목" value="${boardEdit.subject}" autocomplete=off>
						</div>
						<textarea name="content" id="content">${boardEdit.content}</textarea>
					</div>
					<div class="btnWrapper">
						<button id="save" type="button" class="btn_postSave bttn-jelly bttn-md bttn-primary" name="save">저장</button>
					</div>
					</div>
				</form>
			</section>
		</div>
	</body>
	
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	<script src="/resources/summer_note/summernote.js"></script>
	<script>
		$(document).ready(function () {
			$("#content").summernote({
				height: 500,
				minHeight: null,
				maxHeight: null,
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
						sendFile(files[0], this);
			        }
				}
			});
			
			function sendFile(file, el) {
				var form_data = new FormData();
		      	form_data.append('file', file);
		      	$.ajax({
		        	data: form_data,
		        	type: "POST",
		        	url: '/board/image',
		        	cache: false,
		        	contentType: false,
		        	enctype: 'multipart/form-data',
		        	processData: false,
		        	success: function(img_name) {
		          		$(el).summernote('editor.insertImage', img_name);
		        	},
					error		: function(request, status, error){
	        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
	       			}
		      	});
			}
			
			$("#save").click(function(){
		       	if($("#subject").val().trim() == ""){
					alert("제목을 입력해주세요.");
                   	$("#subject").focus();
                   	return false;
				}
		       	
		       	var objParams = {
		       		board_id		: $("#board_id").val(),
		       		subject			: $("#subject").val(),
		       		content			: $("#content").val(),
		       		writer_email	: $("#writer_email").val(),
		       		writer_nickname	: $("#writer_nickname").val()
		       	};
		       	
		       	$.ajax ({
		       		url			: "/board/save",
		       		dataType	: "json",
		       		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
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
</html>