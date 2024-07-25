package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;


import vo.NoticeVO;

public class NoticeDAO {
	
	SqlSession sqlSession;
	
	public NoticeDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//전체 게시글 조회
	public List<NoticeVO> selectList(){
		List<NoticeVO> list = sqlSession.selectList("notice.notice_list");
		return list;
	}
	
	public int insert(NoticeVO vo) {
		int res = sqlSession.insert("notice.notice_insert",vo);
		return res;
		
	}
	
	//상세보기를 위한 게시글 조회
	public NoticeVO selectOne(int idx) {
	
		NoticeVO vo = sqlSession.selectOne("notice.select_one",idx);
		return vo;
		
	}
	
	 //조회수 증가
	 public int update_readhit(int idx){
		 int res = sqlSession.update("notice.notice_update_readhit",idx);
		 return res;
		
	  }
	 
	 
	
	
	
	
	
}
