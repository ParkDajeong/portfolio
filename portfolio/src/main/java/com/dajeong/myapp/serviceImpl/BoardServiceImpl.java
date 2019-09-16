package com.dajeong.myapp.serviceImpl;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
		if(paramMap.get("board_id") == null || paramMap.get("board_id").toString() == "")
			return boardDao.setContent(paramMap);
		else
			return boardDao.modifyContent(paramMap);
	}
	
	@Override
	public void uploadImage(MultipartFile upload, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 업로드할 폴더 경로
		String root = request.getSession().getServletContext().getRealPath("/");
		String realFolder = root + "/../upload/board/";
		UUID uuid = UUID.randomUUID();

		// 업로드할 파일 이름
		String org_filename = upload.getOriginalFilename();
		String filename = uuid.toString() + org_filename;
		String filepath = realFolder + filename;

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		
		String fileUrl = "http://won980125.cafe24.com/board-upload/" + filename;
		
		upload.transferTo(f);
		out.println(fileUrl);
		out.close();
	}
	
	@Override
	public int getAllContentCnt() {
		return boardDao.getAllContentCnt();
	}

	@Override
	public List<Board> getContentList(Pagination pagination) {
		int upCnt = boardDao.getBoardNoticeCnt();
		List<Board> newBoardList = boardDao.getBoardNoticeList();
		
		pagination.setContentViewCnt(pagination.getContentViewCnt() - upCnt);
		if(pagination.getStartContent() != 0) {
			pagination.setStartContent(pagination.getStartContent() - upCnt);
		}
		
		newBoardList.addAll(boardDao.getContentList(pagination));
		
		return newBoardList;
	}

	@Override
	public Board getContent(String board_id) {
		return boardDao.getContent(board_id);
	}

	@Override
	public int deleteContent(Map<String, Object> paramMap) {
		int r1, r2 = 0;
		
		if(boardDao.getContentReply(paramMap) > 0) {
			r1 = boardDao.deleteContent(paramMap);
			r2 = boardDao.deleteContentReply(paramMap);
		} else {
			r1 = boardDao.deleteContent(paramMap);
			r2 = 1;
		}
		if(r1 > 0 && r2 > 0)
			return 1;
		else
			return 0;
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
		int depth = boardDao.checkReplyDepth(paramMap);
		if(depth == 0)
			return boardDao.deleteAllConnectedReply(paramMap);
		else
			return boardDao.deleteOneBoardReply(paramMap);
	}

	@Override
	public int modifyReply(Map<String, Object> paramMap) {
		return boardDao.modifyReply(paramMap);
	}
	
}
