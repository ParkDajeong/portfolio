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
	<title>HAPO Community</title>
	<link rel="icon" sizes="16x16" href="/resources/img/lightning.ico">
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
            display: inline-block;
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
    </style>
</head>
<body>
	<jsp:include page="menu.jsp"/>
    <section>
        <div class="column">
            <div class="column-group group1">
                <div class="column-header">
                    <h2>회원 정보</h2>
                </div>
                <form>
                    <table border="0">
                        <tbody>
                        	<tr>
                                <th scope="row">닉네임</th>
                                <td>
                                	<br><span class="info">변경을 원한다면 입력해주세요.</span><br>
                                	<input type="text" id="user_nickname" name="user_nickname" value="${userData.nickname}" />
									<button type="button" id="checkNicknamel" name="checkNicknamel" class="bttn-bordered bttn-sm bttn-primary">조회</button>
									<button type="button" class="bttn-bordered bttn-sm bttn-primary" id="nickname_change" name="nickname_change">수정</button>
                                    <p class="contxt nameResult" style="color:blue">중복 조회는 필수입니다.</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">이메일</th>
                                <td>
                                    <span class="info">현재 ${sessionScope.user_nickname} 님의 이메일 주소입니다.</span><br>
                                    <span class="info">이메일은 변경할 수 없습니다.</span><br>	
                                    <input type="text" id="user_email" name="user_email"  value="${sessionScope.user_email}" readonly/>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">비밀번호<br>변경</th>
                                <td class="pwd_change" style="padding: 20px 15px;">
                                    <span class="info">비밀번호 변경을 원한다면 입력해주세요.</span><br>
                                    <input type="password" id="current_pwd" name="current_pwd" class="pwd" placeholder="현재 비밀번호를 입력하세요." /><br>
                                    <p class="pwdWarn currentChk" style="color:red">현재 비밀번호와 다릅니다.</p>
                                    <input type="password" id="new_pwd" name="new_pwd" class="pwd" placeholder="새 비밀번호를 입력하세요." /><br>
                                    <p class="pwdWarn newChk">비밀번호는 영문+숫자 조합의 8자 이상이어야 합니다.</p>
                                    <input type="password" id="check_pwd" name="check_pwd" class="pwd" placeholder="비밀번호를 확인하세요." />
                                    <button type="button" class="bttn-bordered bttn-sm bttn-primary" id="change_pwd" name="change_pwd">변경</button>
                                    <p class="pwdWarn sameChk" style="color:red">위의 입력된 비밀번호와 다릅니다. 다시 입력해주세요.</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">기숙사</th>
                                <td style="padding-bottom: 25px;">
                                	<input type="hidden" id="user_house" value="${userData.house}">
                                	<span class="info" style="margin-top: 10px;">원하는 기숙사를 선택해주세요.</span>
                                	<button type="button" class="bttn-bordered bttn-sm bttn-primary" id="choice_house" name="choice_house">등록</button>
                                	<br><br>
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
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">회원 탈퇴</th>
                                <td style="padding: 20px 15px;">
                                    <span class="info">탈퇴를 원하신다면 비밀번호를 입력해주세요.</span><br>
                                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요." />
                                    <button type="button" class="bttn-bordered bttn-sm bttn-primary" id="delete_user" name="delete_user">탈퇴하기</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </section>
    <footer></footer>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/mypage.js" type="text/javascript"></script>
</html>
