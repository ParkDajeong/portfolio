package com.dajeong.myapp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dajeong.myapp.service.AdminService;

@Controller
public class AdminController {

	@Autowired
	AdminService adminService;
	
	//로그인 페이지
	@RequestMapping(value = "/admin/user", method = RequestMethod.GET)
	public String moveAdminUser() {
		
		return "adminUser";
	}
	
	//관리자 게시글 삭제
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
	
	//관리자 게시글 고정
	@ResponseBody
	@RequestMapping(value = "/admin/board/fix", method = RequestMethod.POST)
	public Object boardFix(@RequestParam(value = "board_id") int board_id, @RequestParam(value = "type") int type) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = adminService.changePostType(board_id, type);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
}
