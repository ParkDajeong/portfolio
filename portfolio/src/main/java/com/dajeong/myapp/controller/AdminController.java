package com.dajeong.myapp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminController {

	
	//로그인 페이지
	@RequestMapping(value = "/admin/user", method = RequestMethod.GET)
	public String moveAdminUser() {
		
		return "adminUser";
	}
	
}
