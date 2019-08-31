package com.dajeong.myapp.serviceImpl;

import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.dajeong.myapp.dao.UserDao;
import com.dajeong.myapp.dto.User;
import com.dajeong.myapp.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource(name="userDao")
	private UserDao userDao;
	
	@Override
	public int setUser(Map<String, Object> paramMap) {
		return userDao.setUser(paramMap);
	}

	@Override
	public int checkUser(Map<String, Object> paramMap) {
		return userDao.checkUser(paramMap);
	}

	@Override
	public User getUserData(String email) {
		return userDao.getUserData(email);
	}

	@Override
	public void logOut(HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href=document.referrer;");
		out.println("</script>");
		out.close();
	}

	@Override
	public int checkUserNickname(String nickname) {
		return userDao.checkUserNickname(nickname);
	}

	@Override
	public int checkUserEmail(String email) {
		return userDao.checkUserEmail(email);
	}

	@Override
	public int updateUserNickname(Map<String, Object> paramMap) {
		return userDao.updateUserNickname(paramMap);
	}

	@Override
	public int updateUserHouse(Map<String, Object> paramMap) {
		return userDao.updateUserHouse(paramMap);
	}

	@Override
	public int deleteUser(String email) {
		return userDao.deleteUser(email);
	}
}
