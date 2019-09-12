package com.dajeong.myapp.controller;


import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.multipart.MultipartFile;

import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.Reply;
import com.dajeong.myapp.service.BoardService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	//게시글 목록
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "1") int pageRange, Model model) {
		
		int contentCnt = boardService.getAllContentCnt();
		
		Pagination pagination = new Pagination();
		pagination.pageInfo(contentCnt, page, pageRange);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("boardList", boardService.getContnetList(pagination));
		
		return "index";
	}
	
	//게시글 검색
	@RequestMapping(value = "/board/search", method = RequestMethod.GET)
	public String boardSearch(@RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "1") int pageRange,
			@RequestParam Map<String, Object> paramMap, Model model) {
		
		int contentCnt = boardService.getSearchDataCnt(paramMap);
		
		Pagination pagination = new Pagination();
		pagination.pageInfo(contentCnt, page, pageRange);
		paramMap.put("startContent", pagination.getStartContent());
		paramMap.put("contentViewCnt", pagination.getContentViewCnt());
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("boardList", boardService.getSearchDataList(paramMap));
		
		return "index";
	}
	
	//게시글 상세보기
	@RequestMapping(value = "/board/view", method = RequestMethod.GET)
	public String boardView(@RequestParam(value="board_id", required=false) String board_id, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		
		HttpSession session = request.getSession();
		Cookie[] cookies = request.getCookies();
		Cookie viewCheck = null;
		
		if(cookies != null && cookies.length > 0) {
			 for (int i = 0; i < cookies.length; i++) {
				 if (cookies[i].getName().equals("viewBoard_" + board_id)) { 
					 viewCheck = cookies[i];
				 }
			 }
		}
		if(viewCheck == null){
			Cookie c1 = new Cookie("viewBoard_" + board_id, board_id);
			c1.setMaxAge(1*24*60*60);
			response.addCookie(c1);
			
			boardService.updateBoardViewCnt(board_id);
		}
		
		List<Reply> replyView = new ArrayList<Reply>();
		replyView = boardService.getReplyList(board_id);
		
		model.addAttribute("boardView", boardService.getContent(board_id));
		model.addAttribute("replyView", replyView);
		model.addAttribute("replyCnt", replyView.size());
		
		return "boardView";
	}
	
	//게시글 작성
	@RequestMapping(value = "/board/edit", method = RequestMethod.GET)
	public String boardEdit(@RequestParam(value="board_id", required = false) String board_id , Model model) {
		
		model.addAttribute("boardEdit", boardService.getContent(board_id));
		
		return "boardEdit";
	}
	
	//게시글 저장
	@ResponseBody
	@RequestMapping(value="/board/save", method = RequestMethod.POST)
	public Object boardSave(@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = boardService.setContent(paramMap);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
		
		return retVal;
	}
	
	//이미지 서버 업로드
	@ResponseBody
	@RequestMapping(value="/board/image", method = RequestMethod.POST)
	public void boardImageSave(@RequestParam(value = "file") MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boardService.uploadImage(upload, response, request);
		
	}
	
	//게시글 삭제
	@ResponseBody
	@RequestMapping(value = "/board/delete", method = RequestMethod.POST)
	public Object boardDelete(@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = boardService.deleteContent(paramMap);
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
	
	//댓글 저장
	@ResponseBody
	@RequestMapping(value = "/board/reply/save", method = RequestMethod.POST)
	public Object boardReplySave(@RequestParam Map<String, Object> paramMap, Model model) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = boardService.saveReply(paramMap);
		
		if(result > 0) {
			String regDate = boardService.getReplyDate(paramMap.get("reply_id").toString());
			retVal.put("code", "success");
			retVal.put("reply_id", paramMap.get("reply_id"));
			retVal.put("regDate", regDate);
		} else {
			retVal.put("code", "fail");
			retVal.put("message", "댓글 등록에 실패하였습니다.");
		}
		
		return retVal;
	}
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/board/reply/delete", method = RequestMethod.POST)
	public Object boardReplyDelete(@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = boardService.deleteReply(paramMap);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
	
	//댓글 수정
	@ResponseBody
	@RequestMapping(value = "/board/reply/modify", method = RequestMethod.POST)
	public Object boardReplyModify(@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		int result = boardService.modifyReply(paramMap);
		
		if(result > 0) {
			retVal.put("code", "success");
		} else {
			retVal.put("code", "fail");
		}
			
		return retVal;
	}
}
