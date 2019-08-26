package com.dajeong.myapp.service;

import java.util.List;
import java.util.Map;

import com.dajeong.myapp.dto.Board;
import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.Reply;

public interface BoardService {
	//게시글 등록 및 수정
	int setContent(Map<String, Object> paramMap);
	
	//전체 게시글 수
	int getAllContentCnt();
	
	//게시글 목록
	List<Board> getContnetList(Pagination pagination);

	//게시글 상세보기
	Board getContent(String board_id);

	//게시글 삭제
	int deleteContent(Map<String, Object> paramMap);
	
	//조회수
	int updateBoardViewCnt(String board_id);
	
	//검색된 게시글 수
	int getSearchDataCnt(Map<String, Object> paramMap);
	
	//검색 목록
	List<Board> getSearchDataList(Map<String, Object> paramMap);

	//댓글 등록
	int saveReply(Map<String, Object> paramMap);

	//댓글 불러오기
	List<Reply> getReplyList(String board_id);

	//댓글 날짜
	String getReplyDate(String reply_id);

	//댓글 삭제
	int deleteReply(Map<String, Object> paramMap);

	//댓글 수정
	int modifyReply(Map<String, Object> paramMap);
}
