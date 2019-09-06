package com.dajeong.myapp.serviceImpl;

import java.io.IOException;
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
	public void mailSendAuthKey(Map<String, Object> paramMap, HttpServletRequest request) {
		String email = paramMap.get("email").toString();
		String nickname = paramMap.get("nickname").toString();
		String auth_key = paramMap.get("auth_key").toString();
		System.out.println(email);
		MimeMessage mail = mailSender.createMimeMessage();
		String msgHtml = "<div style='border:1px solid black;text-align:center;'>" + 
				"<b>" + nickname + "</b> 님 가입을 환영합니다.<br>" + 
				"하단의 인증 버튼을 클릭하셔야 가입이 정상적으로 완료됩니다.<br><br>" + 
				"<a href='http://localhost:8888/mail/auth?email=" + email + "&auth_key=" + auth_key + "'>메일인증</a></div>";
		try {
			mail.setSubject("[해포 커뮤니티] 가입 인증 메일입니다.", "UTF-8");
			mail.setContent(msgHtml, "text/html; charset=utf-8");
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
