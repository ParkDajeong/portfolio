package com.dajeong.myapp.daoImpl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dajeong.myapp.dao.AdminDao;
import com.dajeong.myapp.dto.Pagination;
import com.dajeong.myapp.dto.User;

@Repository("adminDao")
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int deleteAdminPost(List<String> dropList) {
		return sqlSession.delete("adminDeletePost", dropList);
	}

	@Override
	public int updateToPostTypeFix(int board_id) {
		return sqlSession.update("updateToPostTypeFix", board_id);
	}

	@Override
	public int updateToPostTypeNotice(int board_id) {
		return sqlSession.update("updateToPostTypeNotice", board_id);
	}

	@Override
	public int updateToPostTypeNormal(int board_id) {
		return sqlSession.update("updateToPostTypeNormal", board_id);
	}

	@Override
	public int getAllUserCnt() {
		return sqlSession.selectOne("selectAllUserCnt");
	}

	@Override
	public List<User> getUserList(Pagination pagination) {
		return sqlSession.selectList("selectUserList", pagination);
	}

	@Override
	public int adminDeleteUser(String email) {
		return sqlSession.delete("adminDeleteUser", email);
	}

	@Override
	public int adminUpdateUserPassword(Map<String, Object> paramMap) {
		return sqlSession.update("adminUpdateUserPassword", paramMap);
	}

	@Override
	public int adminUpdateUserAuth(String email) {
		return sqlSession.update("adminUpdateUserAuthKey", email);
	}
}