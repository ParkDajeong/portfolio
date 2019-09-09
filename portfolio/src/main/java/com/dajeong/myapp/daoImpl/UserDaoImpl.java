package com.dajeong.myapp.daoImpl;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dajeong.myapp.dao.UserDao;
import com.dajeong.myapp.dto.User;


@Repository("userDao")
public class UserDaoImpl implements UserDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int setUser(Map<String, Object> paramMap) {
		return sqlSession.insert("insertUser", paramMap);
	}
	
	@Override
	public int updateUserAuthKey(Map<String, Object> paramMap) {
		return sqlSession.update("updateUserAuthKey", paramMap);
	}
	
	@Override
	public String checkAuthKey(Map<String, Object> paramMap) {
		return sqlSession.selectOne("checkAuthKey", paramMap);
	}

	@Override
	public int checkUser(Map<String, Object> paramMap) {
		return sqlSession.selectOne("checkUser", paramMap);
	}

	@Override
	public User getUserData(String email) {
		return sqlSession.selectOne("selectUserData", email);
	}

	@Override
	public int checkUserNickname(String nickname) {
		return sqlSession.selectOne("checkUserNickname", nickname);
	}

	@Override
	public int checkUserEmail(String email) {
		return sqlSession.selectOne("checkUserEmail", email);
	}

	@Override
	public int updateUserNickname(Map<String, Object> paramMap) {
		return sqlSession.update("updateUserNickname", paramMap);
	}

	@Override
	public int updateUserHouse(Map<String, Object> paramMap) {
		return sqlSession.update("updateUserHouse", paramMap);
	}
	
	@Override
	public int updateUserPassword(Map<String, Object> paramMap) {
		return sqlSession.update("updateUserPassword", paramMap);
	}

	@Override
	public int deleteUser(Map<String, Object> paramMap) {
		return sqlSession.delete("deleteUser", paramMap);
	}

	@Override
	public int changeToTempPassword(Map<String, Object> paramMap) {
		return sqlSession.update("updateToTempPassword", paramMap);
	}
}
