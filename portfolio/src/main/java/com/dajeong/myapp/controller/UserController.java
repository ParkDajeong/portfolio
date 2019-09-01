package com.dajeong.myapp.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	public String moveLogin() {
		
		return "login";
	}
	
	//로그인
	@ResponseBody
	@RequestMapping(value = "/login/login", method = RequestMethod.POST)
	public Object userLogin(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, Model model) {

		Map <String, Object> retVal = new HashMap<String, Object>();
		int result = userService.checkUser(paramMap);
		String nickname = userService.getUserData(paramMap.get("email").toString()).getNickname();
		
		if(result > 0) {
			retVal.put("code", "success");
			HttpSession session = request.getSession();
			session.setAttribute("user_email", paramMap.get("email"));
			session.setAttribute("user_nickname", nickname);
		}else {
			retVal.put("code", "fail");
		}
		retVal.put("data", paramMap.get("email"));
		
		return retVal;
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletResponse response) throws Exception {
        session.invalidate();
        userService.logOut(response);
        
        return "redirect:/";
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
	@RequestMapping(value = "/join/join", method = RequestMethod.POST)
	public String userJoin(@RequestParam Map<String, Object> paramMap, Model model) {
		
		int result = userService.setUser(paramMap);
		
		if(result > 0) {
			return "redirect:/login";
		} else {
			return "redirect:/join";
		}
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
