package com.dajeong.myapp.serviceImpl;

import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.dajeong.myapp.dao.UserDao;
import com.dajeong.myapp.dto.User;
import com.dajeong.myapp.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource(name="userDao")
	private UserDao userDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public int setUser(Map<String, Object> paramMap) {
		String encPassword = passwordEncoder.encode(paramMap.get("password").toString());
		paramMap.put("password", encPassword);
		
		return userDao.setUser(paramMap);
	}

	@Override
	public int checkUser(Map<String, Object> paramMap) {
		User user = userDao.getUserData(paramMap.get("email").toString());
		String pw = user.getPassword();
		String rawPw = paramMap.get("password").toString();
		
		if(passwordEncoder.matches(rawPw, pw))
			paramMap.put("password", pw);
		
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
		out.println("if(document.referrer == 'http://localhost:8888/mypage'){");
		out.println("location.href = '/';} else {");
		out.println("location.href = document.referrer;}");
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
	public int updateUserPassword(Map<String, Object> paramMap) {
		User user = userDao.getUserData(paramMap.get("email").toString());
		String pw = user.getPassword();
		String rawPw = paramMap.get("current_pwd").toString();
		
		if(passwordEncoder.matches(rawPw, pw)) {
			paramMap.put("current_pwd", pw);
			paramMap.put("new_pwd", passwordEncoder.encode(paramMap.get("new_pwd").toString()));
		}
		
		return userDao.updateUserPassword(paramMap);
	}

	@Override
	public int deleteUser(Map<String, Object> paramMap) {
		User user = userDao.getUserData(paramMap.get("email").toString());
		String pw = user.getPassword();
		String rawPw = paramMap.get("password").toString();
		
		if(passwordEncoder.matches(rawPw, pw))
			paramMap.put("password", pw);
		
		return userDao.deleteUser(paramMap);
	}
}
