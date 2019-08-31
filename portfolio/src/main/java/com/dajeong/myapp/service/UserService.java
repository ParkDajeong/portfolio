package com.dajeong.myapp.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.dajeong.myapp.dto.User;

public interface UserService {
	//회원가입
	int setUser(Map<String, Object> paramMap);
	
	//로그인
	int checkUser(Map<String, Object> paramMap);
	
	//유저 데이터 가져오기
	User getUserData(String email);

	//로그아웃
	void logOut(HttpServletResponse response) throws Exception;

	//닉네임 중복 체크
	int checkUserNickname(String nickname);

	//이메일 중복 체크
	int checkUserEmail(String email);

	//닉네임 변경
	int updateUserNickname(Map<String, Object> paramMap);

	//기숙사 변경
	int updateUserHouse(Map<String, Object> paramMap);

	//회원 탈퇴
	int deleteUser(String email);
}
