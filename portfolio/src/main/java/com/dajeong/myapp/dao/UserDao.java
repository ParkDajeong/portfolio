package com.dajeong.myapp.dao;

import java.util.Map;

import com.dajeong.myapp.dto.User;

public interface UserDao {

	int setUser(Map<String, Object> paramMap);
	
	int updateUserAuthKey(Map<String, Object> paramMap);

	String checkAuthKey(Map<String, Object> paramMap);
	
	int checkUser(Map<String, Object> paramMap);

	User getUserData(String email);

	int checkUserNickname(String nickname);

	int checkUserEmail(String email);

	int updateUserNickname(Map<String, Object> paramMap);

	int updateUserHouse(Map<String, Object> paramMap);
	
	int updateUserPassword(Map<String, Object> paramMap);

	int deleteUser(Map<String, Object> paramMap);
}
