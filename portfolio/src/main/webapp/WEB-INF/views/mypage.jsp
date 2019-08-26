<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/resources/css/mypage.css">
	<link rel="stylesheet" href="/resources/css/bttn.css">
    <style>
        .bttn-bordered.bttn-xs {
            padding: 10px 5px 8px 5px;
        }

        .bttn-jelly.bttn-md {
            font-size: 14px;
        }

        .bttn-bordered.bttn-sm {
            padding: 4px 10px;
            font-size: 13px;
            font-family: inherit;
        }

        section {
            margin-top: 0;
        }

        .column-group {
            border: none;
        }

        .group1 {
            margin: 0;
        }

        .column-content .right span {
            margin: 0;
        }

        section {
            background-color: white;
        }

        section .column {
            width: 70%;
            margin: 0 15%;
        }

        @media only screen and (max-width: 629px) {
            section .column {
                float: none;
                width: 100%;
                margin: 0;
            }
        }
    </style>
</head>
<body>
	<jsp:include page="top.jsp"/>
    <section>
        <div class="column">
            <div class="column-group group1">
                <div class="column-header">
                    <h2>연락처 수정</h2>
                    <p class="contxt">pPtizen의 대표 프로필과 별명을 수정 하실 수 있습니다.</p>
                </div>
                <form>
                    <table border="0">
                        <tbody>
                        	<tr>
                                <th scope="row">닉네임</th>
                                <td>
                                	<br><span style="color:#555555; font-size: 12px; margin-top: 5px;">변경을 원한다면 입력해주세요.</span><br>
                                    <input type="text" id="user_nickname" name="user_nickname" value="${userData.nickname}" />
                                    <a id="checkNicknamel" name="checkNicknamel" class="bttn-bordered bttn-sm bttn-primary">조회</a>
                                    <a class="bttn-bordered bttn-sm bttn-primary" id="nickname_change" name="nickname_change">수정</a>
                                    <p class="contxt nameResult" style="color:blue">중복 조회는 필수입니다.</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이메일</th>
                                <td>
                                    <span style="color:#555555; font-size: 12px; margin-top: 5px;">현재 ${sessionScope.user_nickname} 님의 이메일 주소입니다.</span><br>
                                    <span style="color:#555555; font-size: 12px; margin-top: 5px;">이메일은 변경할 수 없습니다.</span><br>	
                                    <input type="text" id="user_email" name="user_email"  value="${sessionScope.user_email}" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">기숙사</th>
                                <td style="padding-bottom: 25px;">
                                	<input type="hidden" id="user_house" value="${userData.house}">
                                	<br><span style="color:#555555; font-size: 12px; margin-top: 5px;">원하는 기숙사를 선택해주세요.</span><br><br>
                                	<label class="radio-img">
                                		<input type="radio" name="house" value="gryffindor" />
                                		<img src="/resources/img/Gryffindor.png">
                                	</label>
                                	<label class="radio-img">
                                		<input type="radio" name="house" value="slytherin" />
                                		<img src="/resources/img/Slytherin.png">
                                	</label>
                                	<label class="radio-img">
                                		<input type="radio" name="house" value="ravenclaw" />
                                		<img src="/resources/img/Ravenclaw.png">
                                	</label>
                                	<label class="radio-img">
                                		<input type="radio" name="house" value="hufflepuff" />
                                		<img src="/resources/img/Hufflepuff.png">
                                	</label>
                                	<a class="bttn-bordered bttn-sm bttn-primary" id="choice_house" name="choice_house">등록</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </section>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/mypage.js" type="text/javascript"></script>
</html>
