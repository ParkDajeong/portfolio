<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true" %>
<html>
	<head>
		<title>포폴 index</title>
		<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
		<c:choose>
			<c:when test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
				<link href="/resources/css/index_admin.css" type="text/css" rel="stylesheet">
			</c:when>
			<c:otherwise>
				<link href="/resources/css/index.css" type="text/css" rel="stylesheet">
			</c:otherwise>
		</c:choose>
		<style>
			.writeComment {
				margin: 10px 0;
			}
			.write, .delete {
				float: right;
				font-size: 14px;
				margin-bottom: 7px;
				margin-right: 5px;
				padding: 5px 15px;
			}
			.delete {
				background-color: #ca3d3d;
				/*border-color: #c33c49;*/
			}
			.fix {
				font-size: 14px;
				padding: 3px 11px;
			}
			.table td {
				vertical-align: middle;
			}
			.m_write {
				margin: 0;
			}
		</style>
		<script>
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
		</script>
	</head>
	<body>
		<jsp:include page="menu.jsp"/>
		<div id="main">
			<input type="hidden" name="session" value="${sessionScope.user_nickname}">
			<section>
				<!-- 게시판 -->
				<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
					<button type="button" class="btn btn-danger delete">삭제</button>
				</c:if>
				<button type="button" class="btn btn-outline-secondary write pc_write">글쓰기</button>
				<div class="tableWrap">
					<table class="table table-hover community">
						<thead>
							<tr>
								<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
									<th><input type="checkbox" name="allCheck"></th>
								</c:if>
								<th>번호</th>
								<th class="board-title">제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
								<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
									<th>고정글</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="boardList" items="${boardList}">
								<c:choose>
									<c:when test="${boardList.type != 2}"><tr style="background-color: #f9faff;"></c:when>
									<c:otherwise><tr></c:otherwise>
								</c:choose>
									<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
										<td><input type="checkbox" name="boardChk" class="boardChk" value="${boardList.id}"></td>
									</c:if>
									<c:choose>
										<c:when test="${boardList.type == 0}"><td style="font-weight:bold;">공지</td></c:when>
										<c:when test="${boardList.type == 1}"><td style="font-weight:bold;">고정</td></c:when>
										<c:otherwise><td>${boardList.id}</td></c:otherwise>
									</c:choose>
									<td class="title" content_id="${boardList.id}"><a>${boardList.subject} &#40;${boardList.reply_count}&#41;</a></td>
									<td>${boardList.writer_nickname}</td>
									<td>${boardList.register_datetime}</td>
									<td>${boardList.read_count}</td>
									<c:if test="${sessionScope.user_email == 'sobeast980@gmail.com'}">
										<c:choose>
											<c:when test="${boardList.type == 2}">
												<td><button type="button" class="btn btn-outline-primary fix" data-type="${boardList.type}">고정</button></td>
											</c:when>
											<c:when test="${boardList.type == 1}">
												<td><button type="button" class="btn btn-primary fix" data-type="${boardList.type}">해제</button></td>
											</c:when>
											<c:otherwise>
												<td></td>
											</c:otherwise>
										</c:choose>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- 모바일용 -->
				<table class="table table-hover m-community">
					<thead>
						<tr>
							<th>
								<span>커뮤니티</span>
								<button type="button" class="btn btn-outline-secondary write m_write">글쓰기</button>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="boardList" items="${boardList}">
							<tr>
								<td class="title m_title" content_id="${boardList.id}">
									<div class="m_post-head">
										<span class="m_subject">${boardList.subject}</span>
										<c:if test="${boardList.reply_count > 0}">
											<span class="m_replyCnt">${boardList.reply_count}</span>
										</c:if>
									</div>
									<div class="m_post-info">
										<span class="m_writer">${boardList.writer_nickname}</span>
										<span class="m_date">${boardList.register_datetime}</span>
										<span class="m_readCnt">${boardList.read_count}</span>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br>
				<!-- 페이지네이션 -->
				<div class="paginationWrap">
					<ul class="pagination justify-content-center">
						<c:if test="${pagination.prev}">
							<li class="page-item">
								<a class="page-link" href="#" aria-label="Previous" onClick="prev('${pagination.page}', '${pagination.pageRange}', '${pagination.pageRangeSize}')">
							        <span aria-hidden="true">&laquo;</span>
							        <span class="sr-only">Previous</span>
								</a>
						    </li>
						</c:if>
					    <c:forEach var="index" begin="${pagination.startPage}" end="${pagination.endPage}">
					    	<li class="page-item" ><a class="page-link" href="#" onClick="movePage('${index}', '${pagination.pageRange}')">${index}</a></li>
					    </c:forEach>
					    <c:if test="${pagination.next}">
					    	<li class="page-item">
					    		<a class="page-link" href="#" aria-label="Next" onClick="next('${pagination.page}', '${pagination.pageRange}', '${pagination.pageRangeSize}')">
							        <span aria-hidden="true">&raquo;</span>
							        <span class="sr-only">Next</span>
					      		</a>
					    	</li>
					    </c:if>
					 </ul>
				</div>
				<!-- 검색 -->
				<div class="searchWrap">
					<div class="inputWrap">
						<select id="searchType">
							<option value="allContents">제목+내용</option>
							<option value="writer">글쓴이</option>
						</select>
						<input type="text" name="search" id="searchData">
					</div>
					<button type="button" id="searchBtn"><img src="/resources/img/search_white.png"></button>
				</div>
			</section>
		</div>
		<footer></footer>
	</body>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script>
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
	</script>
</html>