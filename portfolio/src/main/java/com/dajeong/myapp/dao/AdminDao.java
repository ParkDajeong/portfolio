package com.dajeong.myapp.dao;

import java.util.List;
import java.util.Map;

public interface AdminDao {

	int deleteAdminPost(List<String> dropList);

	int updateToPostTypeNotice(int board_id);
	
	int updateToPostTypeFix(int board_id);

	int updateToPostTypeNormal(int board_id);
}
