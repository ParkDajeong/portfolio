//페이지 이동
function movePage(page, pageRange) {
	location.href = "/?page=" + page + "&pageRange=" + pageRange;
}
//이전 버튼
function prev(page, pageRange, pageRangeSize) {
	var page = parseInt(page);
	var pageRange = parseInt(pageRange);
	page = ((pageRange - 2) * pageRangeSize) + 1;
	pageRange = pageRange - 1;
				
	location.href = "/?page=" + page + "&pageRange=" + pageRange;
}
//다음 버튼
function next(page, pageRange, pageRangeSize) {
	var page = parseInt(page);
	var pageRange = parseInt(pageRange);
	var pageRangeSize = parseInt(pageRangeSize);
	
	page = pageRange * pageRangeSize + 1;
	pageRange = pageRange + 1;
	
	location.href = "/?page=" + page + "&pageRange=" + pageRange;
}

$(document).ready(function () {
	var session = $("input[name=session]").val();
	//글쓰기
	$(".write").click(function() {
		if(session == "") {
			alert("로그인 후, 작성 가능합니다.");
		} else {
			$(location).attr("href", "/board/edit");
		}
	});
	
	//글 상세보기
	$(".title").click(function() {
		var id = $(this).attr("content_id");
		location.href = "/board/view?board_id=" + id;
	});
	
	//검색 엔터 이벤트
	$("#searchData").keydown(function(key) {
        if (key.keyCode == 13)
        	$("#searchBtn").click();
    });
	
	//검색
	$("#searchBtn").click(function() {
		var type = $("#searchType option:selected").val();
		var data = $("#searchData").val();
		if(data == "")
			$(location).attr("href", "/");
		else
			$(location).attr("href", "/board/search?type=" + type + "&data=" + data);
	});
	
	//관리자 - 게시글 전체 선택
	$("input[name='allCheck']").click(function() {
		if($("input[name=allCheck]").prop("checked")) {
			$("input[name=boardChk]").prop("checked", true);
		} else {
			$("input[name=boardChk]").prop("checked", false);
		}
	});
	
	//관리자 - 게시글 삭제
	$(".delete").click(function() {
		var boardChkArr = [];
		$("input[name=boardChk]:checked").each(function() {
				boardChkArr.push($(this).val());
		});
		
		if(boardChkArr.length == 0) {
			alert("삭제할 게시글을 선택해주세요.");
			return;
		}else {
			if(confirm("정말 삭제하시겠습니까?") == true){
				$.ajax({
					url			: "/admin/board/delete",
					data		: {"drop" : boardChkArr},
					type		: "POST",
					success		: function(retVal){
						if(retVal.code == "success") {
							alert("게시글을 삭제하였습니다.");
							location.href = "/";
							boardChkArr = new Array();
						} else{
							alert("삭제에 실패하였습니다.");
						}
					},
					error		: function(request, status, error){
	        			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
	       			}
				});
			}
		}
	});
	
	//관리자 - 게시글 고정
	$(".fix").click(function() {
		
		$.ajax({
			url			: "/admin/board/type",
			data		: {board_id : $(this).parent().siblings(".title").attr("content_id"),type : $(this).data("type")},
			type		: "POST",
			success		: function(retVal) {
				if(retVal.code == "success") {
					location.href = "/";
				} else{
					alert("고정에 실패하였습니다.");
				}
			},
			error		: function(request, status, error){
    			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
   			}
		});
	});
});
