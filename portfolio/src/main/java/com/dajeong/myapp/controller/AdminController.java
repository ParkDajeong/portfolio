package com.dajeong.myapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.service.AdminService;
import com.dajeong.myapp.service.UserService;

@Controller
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	UserService userService;
	
	//관리자 - 회원 목록 페이지
	@RequestMapping(value = "/admin/user/list", method = RequestMethod.GET)
	public String moveAdminUserList(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int pageRange, Model model) {
		
		int userCnt = adminService.getAllUserCnt();
		
		Pagination pagination = new Pagination();
		pagination.pageInfo(userCnt, page, pageRange);
		
		model.addAttribute("allUserCnt", userCnt);
		model.addAttribute("pagination", pagination);
		model.addAttribute("userList", adminService.getUserList(pagination));
		
		return "adminUserList";
	}
	
	//관리자 - 게시글 삭제
	@ResponseBody
	@RequestMapping(value = "/admin/board/delete", method = RequestMethod.POST)
	public Object boardDelete(@RequestParam("drop[]") List<String> dropList) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = adminService.deleteAdminPost(dropList);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
	
	//관리자 - 게시글 고정
	@ResponseBody
	@RequestMapping(value = "/admin/board/type", method = RequestMethod.POST)
	public Object boardUpdateType(@RequestParam(value = "board_id") int board_id, @RequestParam(value = "type") int type) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = adminService.changePostType(board_id, type);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
	
	//관리자 - 유저 탈퇴
	@ResponseBody
	@RequestMapping(value = "/admin/user/delete", method = RequestMethod.POST)
	public Object AdminuserDelete(@RequestParam("eamil") String email) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = adminService.adminDeleteUser(email);
		System.out.println(result);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
	
	//관리자 - 유저 정보 수정
	@RequestMapping(value = "/admin/user/view", method = RequestMethod.GET)
	public String moveAdminUserView(@RequestParam("user_email") String email, Model model) {
		
		model.addAttribute("userData", userService.getUserData(email));
		
		return "adminUserView";
	}
	
	//관리자 - 유저 비밀번호 변경
	@ResponseBody
	@RequestMapping(value = "/admin/update/password", method = RequestMethod.POST)
	public Object adminUpdatePassword(@RequestParam Map<String, Object> paramMap) {
			
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = adminService.adminUpdateUserPassword(paramMap);
		
		if(result > 0) {
			retVal.put("result", "success");
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
	
	//관리자 - 메일 인증
	@ResponseBody
	@RequestMapping(value = "/admin/update/auth", method = RequestMethod.POST)
	public Object adminUpdateAuth(@RequestParam("email") String email) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = adminService.adminUpdateUserAuth(email);
		
		if(result > 0) {
			retVal.put("result", "success");
		} else {
			retVal.put("result", "fail");
		}
		
		return retVal;
	}
}