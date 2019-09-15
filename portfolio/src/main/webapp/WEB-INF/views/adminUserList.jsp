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
		<link href="/resources/css/adminUser.css" type="text/css" rel="stylesheet">
		<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
		<style>
			.userDel, .userModify {
				font-size: 14px;
				margin-right: 5px;
				padding: 5px 15px;
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
						<c:forEach var="userList" items="${userList}" varStatus="status">
							<tr>
								<td>${(allUserCnt - status.index) - ((pagination.page - 1) * 10)}</td>
								<c:choose>
									<c:when test="${userList.auth_key != 'Y'}">
										<td style="color:red;">미완료</td>
									</c:when>
									<c:otherwise>
										<td>완료</td>
									</c:otherwise>
								</c:choose>
								<td>${userList.email}</td>
								<td>${userList.nickname}</td>
								<td>${userList.house}</td>
								<td>${userList.join_datetime}</td>
								<td data-email = "${userList.email}">
									<button type="button" class="btn btn-outline-secondary userModify">수정</button>
									<button type="button" class="btn btn-outline-danger userDel">탈퇴</button>
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
			$(".userDel").click(function() {
				var returnValue = confirm("해당 유저를 탈퇴시키겠습니까?");
				
				if(returnValue) {
					$.ajax({
						url			: "/admin/user/delete",
						data		: {eamil : $(this).parent().data("email")},
						type		: "POST",
						success		: function(retVal) {
							if(retVal.code == "success"){
				    			alert("해당 회원의 탈퇴가 완료되었습니다.");
				    			location.href = "/admin/user/list";
				    		} else{
				    			alert("탈퇴가 정상적으로 이뤄지지 않았습니다. 다시 시도해주세요.");
				    		}
						},
						error		: function(request, status, error){
				    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
						}
					});
				}
			});
			
			//회원 정보 수정 페이지
			$(".userModify").click(function() {
				var email = $(this).parent().data("email");
				location.href = "/admin/user/view?user_email=" + email;
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
					$(location).attr("href", "/admin/user/list");
				else
					$(location).attr("href", "/admin/user/search?type=" + type + "&data=" + data);
			});
		});
	</script>
</html>