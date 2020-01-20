package com.dajeong.myapp.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dajeong.myapp.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	//로그인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String moveLogin(HttpServletRequest request, Model model) {
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null && cookies.length > 0) {
			for (int i=0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("rememberId"))
					model.addAttribute("rememberId", cookies[i].getValue().replace("%40", "@"));
			}
		}
		return "login";
	}
	
	//로그인
	@ResponseBody
	@RequestMapping(value = "/login/login", method = RequestMethod.POST)
	public Object userLogin(@RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, Model model) {

		Map <String, Object> retVal = new HashMap<String, Object>();
		int result = userService.checkUser(paramMap);
		HttpSession session = request.getSession();
		
		//로그인 관련 세션 있으면 삭제
		if(session.getAttribute("user_email") != null) {
			session.removeAttribute("user_email");
			session.removeAttribute("user_nickname");
		}
		
		if(result > 0) {
			String nickname = userService.getUserData(paramMap.get("email").toString()).getNickname();
			retVal.put("code", "success");
			session.setAttribute("user_email", paramMap.get("email"));
			session.setAttribute("user_nickname", nickname);
			
			if(paramMap.get("option").equals("saveIdPw")) {
				Cookie logCookie = new Cookie("loginCookie", session.getId());
				logCookie.setPath("/");
				logCookie.setMaxAge(60*60*24*30);
				response.addCookie(logCookie);
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MONTH, 1);
				Date sessionLimit = cal.getTime();
				userService.updateSessionKey(session.getId(), sessionLimit, paramMap.get("email").toString());
			}
			
		}else if(result == -1) {
			retVal.put("code", "notAuth");
		} else {
			retVal.put("code", "fail");
		}
		retVal.put("data", paramMap.get("email"));
		
		return retVal;
	}
	
	//비밀번호 찾기 페이지
	@RequestMapping(value = "/forgot-password", method = RequestMethod.GET)
	public String moveForgotPswd() {
		
		return "forgot-password";
	}
	
	//비번 찾기 - 임시 비번 메일 전송
	@ResponseBody
	@RequestMapping(value = "/forgot-password/mail", method = RequestMethod.POST)
	public Object passwordSendMail(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		String tempPW = RandomStringUtils.randomAlphanumeric(10);
		paramMap.put("tempPW", tempPW);
		String subject = "[해포 커뮤니티] 임시 비밀번호입니다.";
		String content = "<div style='border:1px solid black;text-align:center;'>" + 
				"임시 비밀번호입니다. 로그인 후, 비밀번호를 변경하세요.<br><br>" + 
				"임시 비밀번호 : "+ tempPW + "</div>";
		
		int result = userService.changeToTempPassword(paramMap);
		
		if(result > 0) {
			userService.sendMailAuthKey(paramMap, subject, content);
			retVal.put("code", "OK");
		}else {
			retVal.put("code", "fail");
		}
		
		return retVal;
	}

	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public void logout(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws Exception {
        
        Cookie [] cookies = request.getCookies();
		Cookie logCookie = null;
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("loginCookie"))
				logCookie = cookies[i];
		}
		
		if(logCookie != null) {
			logCookie.setPath("/");
			logCookie.setMaxAge(0);
			response.addCookie(logCookie);
			userService.updateSessionKey("N", new Date(System.currentTimeMillis()), session.getAttribute("user_email").toString());
		}
		session.invalidate();
        userService.logOut(response);
    }
	
	//회원가입 페이지
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String movejoin() {
		
		return "join";
	}
	
	//닉네임 중복 체크
	@ResponseBody
	@RequestMapping(value = "/join/check/nickname", method = RequestMethod.POST)
	public Object checkNickname(@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = userService.checkUserNickname(paramMap.get("nickname").toString());
		
		if(result > 0) {
			retVal.put("result", "overlap");
		} else {
			retVal.put("result", "available");
		}
		
		return retVal;
	}
	
	//이메일 중복 체크
	@ResponseBody
	@RequestMapping(value = "/join/check/email", method = RequestMethod.POST)
	public Object checkEmail(@RequestParam Map<String, Object> paramMap) {
			
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = userService.checkUserEmail(paramMap.get("email").toString());
			
		if(result > 0) {
			retVal.put("result", "overlap");
			retVal.put("message", "이미 등록된 이메일입니다.");
		} else {
			retVal.put("result", "available");
		}
			
		return retVal;
	}
	
	//회원가입
	@ResponseBody
	@RequestMapping(value = "/join/join", method = RequestMethod.POST)
	public Object userJoin(@RequestParam Map<String, Object> paramMap, Model model, HttpServletRequest request) {

		Map<String, Object> retVal = new HashMap<String, Object>();
		String auth_key = RandomStringUtils.randomAlphanumeric(12);
		paramMap.put("auth_key", auth_key);
		String email = paramMap.get("email").toString();
		String nickname = paramMap.get("nickname").toString();
		String subject = "[해포 커뮤니티] 가입 인증 메일입니다.";
		String content = "<div style='border:1px solid black;text-align:center;'>" + 
				"<b>" + nickname + "</b> 님 가입을 환영합니다.<br>" + 
				"하단의 인증 버튼을 클릭하셔야 가입이 정상적으로 완료됩니다.<br><br>" + 
				"<a href=http://localhost:8888/mail/auth?email=" + email + "&auth_key=" + auth_key + ">메일인증</a></div>";
		
		int result = userService.setUser(paramMap);
		
		if(result > 0) {
			userService.sendMailAuthKey(paramMap, subject, content);
			retVal.put("result", "success");
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
	
	//메일 인증
	@RequestMapping(value="/mail/auth", method = RequestMethod.GET)
	public void mailAuth(@RequestParam Map<String, Object> paramMap, Model model, HttpServletResponse response) throws Exception {
		
		System.out.println(paramMap.get("email") + " : " + paramMap.get("auth_key"));
		
		userService.updateUserAuthKey(paramMap, response);
		
	}
	
	//마이페이지
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String moveMypage(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		model.addAttribute("userData", userService.getUserData(session.getAttribute("user_email").toString()));
		
		return "mypage";
	}
	
	//닉네임 변경
	@ResponseBody
	@RequestMapping(value = "/update/nickname", method = RequestMethod.POST)
	public Object updateNickname(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
			
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = userService.updateUserNickname(paramMap);
		
		if(result > 0) {
			retVal.put("result", "success");
			HttpSession session = request.getSession();
			session.setAttribute("user_nickname", paramMap.get("nickname").toString());
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
	
	//비밀번호 변경
	@ResponseBody
	@RequestMapping(value = "/update/password", method = RequestMethod.POST)
	public Object updatePassword(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
			
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = userService.updateUserPassword(paramMap);
		
		if(result > 0) {
			retVal.put("result", "success");
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
	
	//기숙사 변경
	@ResponseBody
	@RequestMapping(value = "/update/house", method = RequestMethod.POST)
	public Object updateHouse(@RequestParam Map<String, Object> paramMap) {
				
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = userService.updateUserHouse(paramMap);
		
		if(result > 0) {
			retVal.put("result", "success");
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
	
	//회원 탈퇴
	@ResponseBody
	@RequestMapping(value = "/user/delete", method = RequestMethod.POST)
	public Object deleteUser(@RequestParam Map<String, Object> paramMap) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = userService.deleteUser(paramMap);
		
		if(result > 0) {
			retVal.put("result", "success");
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
}
