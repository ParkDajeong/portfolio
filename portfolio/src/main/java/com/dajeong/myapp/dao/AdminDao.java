package com.dajeong.myapp.dao;

import java.util.List;
import java.util.Map;

import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.User;

public interface AdminDao {

	int deleteAdminPost(List<String> dropList);

	int updateToPostTypeNotice(int board_id);
	
	int updateToPostTypeFix(int board_id);

	int updateToPostTypeNormal(int board_id);

	int getAllUserCnt();

	List<User> getUserList(Pagination pagination);

	int adminDeleteUser(String email);

	int adminUpdateUserPassword(Map<String, Object> paramMap);

	int adminUpdateUserAuth(String email);

	int getSearchEmailCnt(Map<String, Object> paramMap);

	int getSearchNicknameCnt(Map<String, Object> paramMap);

	List<User> getSearchEmailList(Map<String, Object> paramMap);

	List<User> getSearchNicknameList(Map<String, Object> paramMap);
}
