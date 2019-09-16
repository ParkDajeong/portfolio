package com.dajeong.myapp.serviceImpl;

import java.io.PrintWriter;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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
	
	@Autowired
	JavaMailSender mailSender;
	
	@Override
	public int setUser(Map<String, Object> paramMap) {
		String encPassword = passwordEncoder.encode(paramMap.get("password").toString());
		paramMap.put("password", encPassword);
		
		return userDao.setUser(paramMap);
	}
	
	@Override
	public void sendMailAuthKey(Map<String, Object> paramMap, String subject, String content) {
		String email = paramMap.get("email").toString();
		MimeMessage mail = mailSender.createMimeMessage();
		
		try {
			mail.setSubject(subject, "UTF-8");
			mail.setContent(content, "text/html; charset=utf-8");
			mail.setRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateUserAuthKey(Map<String, Object> paramMap, HttpServletResponse response) throws Exception {
		int result = userDao.updateUserAuthKey(paramMap);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.println("<script>");
			out.println("alert('인증이 완료되었습니다. 이제 로그인이 가능합니다.');");
			out.println("location.href = '/login';");
			out.println("</script>");
			out.close();
		} else {
			out.println("<script>");
			out.println("alert('인증에 실패하였습니다. 조금 뒤에 다시 시도해주세요.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}
	}

	@Override
	public int checkUser(Map<String, Object> paramMap) {
		User user = userDao.getUserData(paramMap.get("email").toString());
		String pw = user.getPassword();
		String rawPw = paramMap.get("password").toString();
		
		if(passwordEncoder.matches(rawPw, pw)) {
			paramMap.put("password", pw);
			if(!(userDao.checkAuthKey(paramMap).equals("Y")))
				return -1;
		}
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
		out.println("if(document.referrer == 'http://localhost:8888/mypage' && "
				+ "document.referrer == 'http://localhost:8888/board/edit' && "
				+ "document.referrer.indexOf('admin') != -1){");
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

	@Override
	public int changeToTempPassword(Map<String, Object> paramMap) {
		String encPassword = passwordEncoder.encode(paramMap.get("tempPW").toString());
		paramMap.put("tempPW", encPassword);
		
		return userDao.changeToTempPassword(paramMap);
	}
}
