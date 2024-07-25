package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminVO;
import vo.SitterVO;
import vo.UserVO;

public class UserDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 아이디 유효성체크
	public UserVO selectOne_id(String user_id) {
		UserVO vo = sqlSession.selectOne("user.id_check", user_id);
		return vo;
	}

	public UserVO selectOne_tel(String user_tel) {
		UserVO vo = sqlSession.selectOne("user.tel_check", user_tel);
		return vo;
	}

	public int insertUser(UserVO vo) {
		int res = sqlSession.insert("user.insert_list", vo);
		return res;
	}

	public UserVO selectOne_email(String user_email) {
		UserVO vo = sqlSession.selectOne("user.email_check", user_email);
		return vo;
	}
	
	public UserVO selectOne_findId(UserVO vo) {
		// id 찾을때 사용
		UserVO resVO = sqlSession.selectOne("user.find_id", vo);
		return resVO;
	}
	public UserVO selectOne_takeId(String user_email) {
		// id전송하기
		UserVO resVO = sqlSession.selectOne("user.take_id", user_email);
		return resVO;
	}
	public UserVO selectOne_findPwd(UserVO vo) {
		// pwd찾을때 사용
		UserVO resVO = sqlSession.selectOne("user.find_pwd", vo);
		return resVO;
	}
	public int update_Pwd(UserVO vo) {
		// pwd 바꾸기(업데이트)
		int res = sqlSession.update("user.update_pwd", vo);
		return res;
	}
	
//7/5 user_type 이 1일 경우 시터정보 가져오기
	public SitterVO selectOneSitter(int user_idx) {
		SitterVO vo = sqlSession.selectOne("user.select_sitter", user_idx);
		return vo;
	}

}
