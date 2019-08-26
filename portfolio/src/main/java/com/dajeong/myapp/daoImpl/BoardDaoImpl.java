package com.dajeong.myapp.daoImpl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dajeong.myapp.dao.BoardDao;
import com.dajeong.myapp.dto.Board;
import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.Reply;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int setContent(Map<String, Object> paramMap) {
		return sqlSession.insert("insertBoardContent", paramMap);
	}
	
	@Override
	public int modifyContent(Map<String, Object> paramMap) {
		return sqlSession.update("updateBoardContent", paramMap);
	}
	
	@Override
	public int getAllContentCnt() {
		return sqlSession.selectOne("selectBoardContentCnt");
	}

	@Override
	public List<Board> getContentList(Pagination pagination) {
		return sqlSession.selectList("selectBoardContentList", pagination);
	}

	@Override
	public Board getContent(String board_id) {
		return sqlSession.selectOne("selectBoardContent", board_id);
	}

	@Override
	public int deleteContent(Map<String, Object> paramMap) {
		return sqlSession.delete("deleteBoardContent", paramMap);
	}
	
	@Override
	public int updateBoardViewCnt(String board_id) {
		return sqlSession.update("updateBoardViewCnt",board_id);
	}
	
	@Override
	public int getSearchContentsCnt(Map<String, Object> paramMap) {
		return sqlSession.selectOne("selectBoardSearchContentCnt", paramMap);
	}

	@Override
	public int getSearchWriterCnt(Map<String, Object> paramMap) {
		return sqlSession.selectOne("selectBoardSearchWriterCnt", paramMap);
	}
	
	@Override
	public List<Board> getSearchContentsList(Map<String, Object> paramMap) {
		return sqlSession.selectList("selectBoardSearchContentList", paramMap);
	}

	@Override
	public List<Board> getSearchWriterList(Map<String, Object> paramMap) {
		return sqlSession.selectList("selectBoardSearchWriterList", paramMap);
	}

	@Override
	public int saveReply(Map<String, Object> paramMap) {
		return sqlSession.insert("insertBoardReply", paramMap);
	}

	@Override
	public List<Reply> getReplyList(String board_id) {
		return sqlSession.selectList("selectReplyList", board_id);
	}

	@Override
	public String getReplyDate(String reply_id) {
		return sqlSession.selectOne("selectReplyDate", reply_id);
	}

	@Override
	public int deleteReply(Map<String, Object> paramMap) {
		return sqlSession.delete("deleteBoardReply", paramMap);
	}

	@Override
	public int modifyReply(Map<String, Object> paramMap) {
		return sqlSession.update("updateBoardReply", paramMap);
	}
	
}
