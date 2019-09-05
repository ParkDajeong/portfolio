$(document).ready(function () {
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
			var writer = $("#user_email").val();
			var nickname = $("#user_nickname").val();
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
				success		: function(retVal) {
					if(retVal.code == "success") {
						$(".c_inputBox").val("");
						$(".content-footer").append(
								"<div class='replyWrapper'>" + 
								"<div class='MaincommetWrap'>" +
								"<div class='comment-header'>" + 
								"<input type='hidden' id='reply_id' name='reply_id' value='"+ retVal.reply_id +"' />" +
								"<span class='reply_user'>" + nickname +"</span>&nbsp;&nbsp;" +
								"<span class='reply_date'>" + retVal.regDate + "</span>" + 
								"<span class='replyWriterBtn'>" + 
								"<span><a style='color: green;' class='reply_comment r_edit'>답글</a></span>" +
								"<a style='color: red;' class='reply_modify'>수정 </a>" +
								"<a style='color: blue;' class='reply_delete'>삭제</a></span><div>" +
								"<div class='commentContent'>"+ reply_content +"</div></div>"
							);
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
			var parent  = $(this).parent().parent().parent().parent();
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
			var contentDiv = $(this).parent().parent().siblings(".commentContent");
			content = contentDiv.text();
			$(this).text("취소");
			$(this).attr("class","cancel r_edit");
			
			contentDiv.html(
					"<textarea class='modifyBox' cols='20'>" + content + "</textarea>" + 
					"<input type='button' class='btn btn-outline-secondary reply_modifySave' value='수정'>"
				);
		});
		
		//댓글 수정 저장
		$(document).on("click", ".reply_modifySave", function(){
			var contentDiv  = $(this).parent();
			var reply_content = $(".modifyBox").val();
			var reply_id = $(this).parent().siblings(".comment-header").find("#reply_id").val();
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
						$(".cancel").attr("class","reply_modify r_edit");
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
			$(this).attr("class","reply_modify r_edit");
			div.empty();
			div.text(content);
		});
		
		//답글 버튼 클릭
		$(document).on("click", ".reply_comment", function(){
			var parent = $(this).parent().parent().parent().parent();
			parent.find(".commentWrap").remove();
			parent.after(
					"<div class='commentWrap'>" +
					"<div class='arrow'><img src='/resources/img/commnet_Arrow.png'></div>&nbsp;" +
					"<div class='writeComment'>" +
					"<div class='c_writer'>" + $("#user_nickname").val() + "</div>" + 
					"<textarea class='c_inputBox' placeholder='내용을 입력해주세요:)' cols='20'></textarea>" +
					"<input type='button' class='btn btn-outline-secondary commentInsert' value='등록'></div></div>"
				);
		});
		
		//답글 등록
		$(document).on("click", ".commentInsert", function(){
			var writer = $("#user_email").val();
			var nickname = $("#user_nickname").val();
			var reply_content = $(this).siblings(".c_inputBox").val();
			var parent_id = $(this).parent().parent().siblings(".MaincommetWrap").find("#reply_id").val();
			var inputBox = $(this).parent().parent();
			var parent = $(this).parent().parent().parent();
			
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
						inputBox.remove();
						parent.append(
								"<div class='commentWrap'>" + 
								"<div class='arrow'><img src='/resources/img/commnet_Arrow.png'></div>&nbsp;" + 
								"<div class='SubcommetWrap'>" +
								"<div class='comment-header'>" + 
								"<input type='hidden' id='reply_id' name='reply_id' value='"+ retVal.reply_id +"' />" +
								"<span class='reply_user'>" + nickname +"</span>&nbsp;&nbsp;" +
								"<span class='reply_date'>" + retVal.regDate + "</span>" +
								"<span class='replyWriterBtn'>" + 
								"<a style='color: red;' class='reply_modify r_edit'>수정</a>" +
								"<a style='color: blue;' class='reply_delete r_edit'>삭제</a></span></div>" +
								"<div class='commentContent'>"+ reply_content +"</div></div></div>"
							);
							
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
});