package com.dajeong.myapp.service;

import java.util.List;
import java.util.Map;

public interface AdminService {

	//게시글 삭제
	int deleteAdminPost(List<String> dropList);

	//게시글 고정
	int changePostType(int board_id, int type);
	
}
