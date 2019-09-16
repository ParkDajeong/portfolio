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
		<link href="/resources/css/boardEdit.css" type="text/css" rel="stylesheet">
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="/resources/summer_note/summernote.css">
		<style>
			#save{
				font-size: 15px;
				margin-bottom: 7px;
				margin-right: 5px;
				padding: 6px 16px;
				background-color: #50586d;
				color: white;
			}
		</style>
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
							<input type="hidden" name="postType" value="${boardEdit.type}" />
							<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
								<select name="type" id="type">
									<option value="0">공지</option>
									<option value="1">고정</option>
									<option value="2">일반</option>
								</select>
							</c:if>
							<input type="text" id="subject" name="subject" placeholder="제목" value="${boardEdit.subject}" autocomplete=off>
						</div>
						<textarea name="content" id="content">${boardEdit.content}</textarea>
					</div>
					<div class="btnWrapper">
						<button id="save" type="button" class="btn btn-outline-primary btn_postSave" name="save">저장</button>
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
				placeholder: "내용을 입력해주세요:)",
				height: 500,
				lang: 'ko-KR',
				toolbar: [
					['style', ['bold', 'italic', 'underline']],
					['font', ['strikethrough']],
					['fontsize', ['fontsize']],
					['color', ['color']],
					['para', ['ul', 'ol', 'paragraph']],
					['height', ['height']],
					['Insert', ['picture']],
					['Insert', ['link']],
					['Misc', ['fullscreen']]
				],
				popover: {
					image: [
						['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
					    ['float', ['floatLeft', 'floatRight', 'floatNone']],
					    ['remove', ['removeMedia']]
					]
				},
				minHeight: null,
				maxHeight: null,
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
						sendFile(files[0], this);
			        }
				}
			});
			
			var type = $("input[name=postType]").val();
			if(type == "")
				$("#type option:eq(0)").prop("selected", true);
			else
				$("#type").val(type).prop("selected", true);
			
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
		       	
		       	var type = $("#type").val();
		       	if(typeof type == "undefined")
		       		type = 2;
		       	
		       	var objParams = {
		       		board_id		: $("#board_id").val(),
		       		type			: type,
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