package com.dajeong.myapp.serviceImpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dajeong.myapp.dao.BoardDao;
import com.dajeong.myapp.dto.Board;
import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.Reply;
import com.dajeong.myapp.service.BoardService;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name="boardDao")
	private BoardDao boardDao;
	
	@Override
	public int setContent(Map<String, Object> paramMap) {
		if(paramMap.get("id") == null || paramMap.get("id").toString() == "")
			return boardDao.setContent(paramMap);
		else
			return boardDao.modifyContent(paramMap);
	}
	
	@Override
	public int getAllContentCnt() {
		return boardDao.getAllContentCnt();
	}

	@Override
	public List<Board> getContnetList(Pagination pagination) {
		return boardDao.getContentList(pagination);
	}

	@Override
	public Board getContent(String board_id) {
		return boardDao.getContent(board_id);
	}

	@Override
	public int deleteContent(Map<String, Object> paramMap) {
		return boardDao.deleteContent(paramMap);
	}
	
	@Override
	public int updateBoardViewCnt(String board_id) {
		return boardDao.updateBoardViewCnt(board_id);
	}
	
	@Override
	public int getSearchDataCnt(Map<String, Object> paramMap) {
		String type = paramMap.get("type").toString();
		if(type.equals("allContents"))
			return boardDao.getSearchContentsCnt(paramMap);
		else
			return boardDao.getSearchWriterCnt(paramMap);
	}
	
	@Override
	public List<Board> getSearchDataList(Map<String, Object> paramMap) {
		String type = paramMap.get("type").toString();
		if(type.equals("allContents"))
			return boardDao.getSearchContentsList(paramMap);
		else
			return boardDao.getSearchWriterList(paramMap);
	}

	@Override
	public int saveReply(Map<String, Object> paramMap) {
		return boardDao.saveReply(paramMap);
	}

	@Override
	public List<Reply> getReplyList(String board_id) {
		List<Reply> replyList = boardDao.getReplyList(board_id);
        List<Reply> replyListParent = new ArrayList<Reply>();
        List<Reply> replyListChild = new ArrayList<Reply>();
        List<Reply> newReplyList = new ArrayList<Reply>();
 
        for(Reply reply: replyList){
            if(reply.getDepth() == 0){
            	replyListParent.add(reply);
            }else{
            	replyListChild.add(reply);
            }
        }
 
        for(Reply replyParent: replyListParent){
        	newReplyList.add(replyParent);
            for(Reply replyChild: replyListChild){
                if(replyParent.getReply_id() == replyChild.getParent_id()){
                	newReplyList.add(replyChild);
                }
            }
        }
 
        return newReplyList;
	}

	@Override
	public String getReplyDate(String reply_id) {
		return boardDao.getReplyDate(reply_id);
	}

	@Override
	public int deleteReply(Map<String, Object> paramMap) {
		return boardDao.deleteReply(paramMap);
	}

	@Override
	public int modifyReply(Map<String, Object> paramMap) {
		return boardDao.modifyReply(paramMap);
	}
}
