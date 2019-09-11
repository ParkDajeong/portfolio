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
        
        #mail_auth {
			margin-top: 10px;
			display: inline-block;
        }
    </style>
</head>
<body>
	<jsp:include page="menu.jsp"/>
    <section>
        <div class="column">
            <div class="column-group group1">
                <div class="column-header">
                    <h2>회원 정보 수정</h2>
                </div>
                <form>
                    <table border="0">
                        <tbody>
                        	<tr>
                                <th scope="row">닉네임</th>
                                <td>
                                    <input type="text" id="user_nickname" name="user_nickname" value="${userData.nickname}" />
                                    <a id="checkNicknamel" name="checkNicknamel" class="bttn-bordered bttn-sm bttn-primary">조회</a>
                                    <a class="bttn-bordered bttn-sm bttn-primary" id="nickname_change" name="nickname_change">수정</a>
                                    <p class="contxt nameResult" style="color:blue">중복 조회는 필수입니다.</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이메일</th>
                                <td>
                                    <span style="color:#555555; font-size: 12px; margin-top: 5px;">현재 <b>${userData.nickname}</b> 님의 이메일 주소입니다.</span><br>
                                    <input type="text" id="user_email" name="user_email"  value="${userData.email}" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">비밀번호 변경</th>
                                <td style="padding: 20px 15px;">
                                    <span style="color:#555555; font-size: 12px; margin-top: 5px;">비밀번호 변경을 원한다면 입력해주세요.</span><br>
                                    <input type="password" id="new_pwd" name="new_pwd" class="pwd" placeholder="새 비밀번호를 입력하세요." />
                                    <a class="bttn-bordered bttn-sm bttn-primary" id="change_pw" name="change_pwd">변경</a><br>
                                    <p class="pwdWarn newChk">비밀번호는 영문+숫자 조합의 8자 이상이어야 합니다.</p>
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
                            <tr>
                                <th scope="row">메일 인증</th>
                                <td style="padding: 20px 15px;">
									<c:choose>
										<c:when test="${userData.auth_key == 'Y'}">
											<span style="color:#555555; font-size: 12px; margin-top: 5px;">현재 회원의 메일 인증 상태는 <b style="color:blue;">인증 완료</b> 입니다.</span><br>
										</c:when>
										<c:otherwise>
											<span style="color:#555555; font-size: 12px; margin-top: 5px;">현재 회원의 메일 인증 상태는 <b style="color:red;">인증 미완료</b> 입니다.</span><br>
											<a class="bttn-bordered bttn-sm bttn-primary" id="mail_auth" name="mail_auth">인증 하기</a>
										</c:otherwise>
									</c:choose>
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
<script src="/resources/js/adminUserView.js" type="text/javascript"></script>
</html>
