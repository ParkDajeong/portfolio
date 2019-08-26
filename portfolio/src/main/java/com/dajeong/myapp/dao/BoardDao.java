package com.dajeong.myapp.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dajeong.myapp.dto.Board;
import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.Reply;

public interface BoardDao {

	int setContent(Map<String, Object> paramMap);
	
	int modifyContent(Map<String, Object> paramMap);
	
	int getAllContentCnt();

	List<Board> getContentList(Pagination pagination);

	Board getContent(String board_id);

	int deleteContent(Map<String, Object> paramMap);
	
	int updateBoardViewCnt(String board_id);
	
	int getSearchContentsCnt(Map<String, Object> paramMap);

	int getSearchWriterCnt(Map<String, Object> paramMap);
	
	List<Board> getSearchContentsList(Map<String, Object> paramMap);

	List<Board> getSearchWriterList(Map<String, Object> paramMap);

	int saveReply(Map<String, Object> paramMap);

	List<Reply> getReplyList(String board_id);

	String getReplyDate(String reply_id);

	int deleteReply(Map<String, Object> paramMap);

	int modifyReply(Map<String, Object> paramMap);

}
