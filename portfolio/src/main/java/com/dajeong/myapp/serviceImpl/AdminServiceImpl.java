package com.dajeong.myapp.serviceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.dajeong.myapp.dao.AdminDao;
import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.User;
import com.dajeong.myapp.service.AdminService;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {
	
	@Resource(name="adminDao")
	AdminDao adminDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public int deleteAdminPost(List<String> dropList) {
		return adminDao.deleteAdminPost(dropList);
	}

	@Override
	public int changePostType(int board_id, int type) {
		if(type == 2) {
			return adminDao.updateToPostTypeFix(board_id);
		} else {
			return adminDao.updateToPostTypeNormal(board_id);
		}
	}

	@Override
	public int getAllUserCnt() {
		return adminDao.getAllUserCnt();
	}

	@Override
	public List<User> getUserList(Pagination pagination) {
		return adminDao.getUserList(pagination);
	}

	@Override
	public int adminDeleteUser(String email) {
		return adminDao.adminDeleteUser(email);
	}

	@Override
	public int adminUpdateUserPassword(Map<String, Object> paramMap) {
		String new_pwd = passwordEncoder.encode(paramMap.get("new_pwd").toString());
		paramMap.put("new_pwd", new_pwd);
		
		return adminDao.adminUpdateUserPassword(paramMap);
	}

	@Override
	public int adminUpdateUserAuth(String email) {
		return adminDao.adminUpdateUserAuth(email);
	}

	@Override
	public int getSearchUserDataCnt(Map<String, Object> paramMap) {
		String type = paramMap.get("type").toString();
		if(type.equals("email"))
			return adminDao.getSearchEmailCnt(paramMap);
		else
			return adminDao.getSearchNicknameCnt(paramMap);
	}

	@Override
	public List<User> getSearchUserDataList(Map<String, Object> paramMap) {
		String type = paramMap.get("type").toString();
		if(type.equals("email"))
			return adminDao.getSearchEmailList(paramMap);
		else
			return adminDao.getSearchNicknameList(paramMap);
	}
}
