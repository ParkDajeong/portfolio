package com.dajeong.myapp.service;

import java.util.List;
import java.util.Map;

import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.User;

public interface AdminService {

	//게시글 삭제
	int deleteAdminPost(List<String> dropList);

	//게시글 고정
	int changePostType(int board_id, int type);

	//전체 유저 수
	int getAllUserCnt();

	//전체 유저 리스트
	List<User> getUserList(Pagination pagination);

	//유저 탈퇴
	int adminDeleteUser(String email);

	//유저 비밀번호 변경
	int adminUpdateUserPassword(Map<String, Object> paramMap);

	//유저 인증 상태 변경
	int adminUpdateUserAuth(String email);

	//검색한 유저 데이터 개수
	int getSearchUserDataCnt(Map<String, Object> paramMap);

	List<User> getSearchUserDataList(Map<String, Object> paramMap);
	
}
