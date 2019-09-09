<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true" %>
<html>
	<head>
		<title>포폴 index</title>
		<link href="/resources/css/adminUser.css" type="text/css" rel="stylesheet">
		<link href="/resources/css/boardView.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
		<style>
			.userDel {
				float: right;
				font-size: 14px;
				margin-bottom: 7px;
				margin-right: 5px;
				padding: 5px 15px;
			}
			.userDel {
				background-color: #ca3d3d;
				/*border-color: #c33c49;*/
			}
			.table td {
				vertical-align: middle;
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
			<section>
				<table class="table table-hover userTable">
					<thead>
						<tr>
							<th width="6%">번호</th>
							<th>인증</th>
							<th width="30%">이메일</th>
							<th>닉네임</th>
							<th>기숙사</th>
							<th>가입일자</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="boardList" items="${boardList}">
							<tr>
								<td></td>
								<td></td>
								<td>${boardList.id}</td>
								<td content_id="${boardList.id}" style="cursor: pointer;"><a data-toggle="modal">${boardList.subject} &#40;${boardList.reply_count}&#41;</a></td>
								<td>${boardList.writer_nickname}</td>
								<td>${boardList.register_datetime}</td>
								<td>
									<button type="button" class="btn btn-secondary userDel">수정</button>
									<button type="button" class="btn btn-danger userDel">탈퇴</button>
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
							<option value="email">이메일</option>
							<option value="nickname">닉네임</option>
						</select>
						<input type="text" name="search" id="searchData">
					</div>
					<button type="button" id="searchBtn"><img src="/resources/img/search_black.png"></button>
				</div>
			</section>
		</div>
	</body>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function () {
			//글쓰기
			$(".write").click(function() {
				$(location).attr("href", "/board/edit");
			});
			
			//글 상세보기
			$(".title").click(function() {
				var id = $(this).attr("content_id");
				location.href = "/board/view?board_id=" + id;
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
		});
	</script>
</html>