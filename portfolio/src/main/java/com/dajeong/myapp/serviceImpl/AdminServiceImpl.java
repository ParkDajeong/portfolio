package com.dajeong.myapp.serviceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dajeong.myapp.dao.AdminDao;
import com.dajeong.myapp.service.AdminService;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {
	
	@Resource(name="adminDao")
	AdminDao adminDao;

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
}
