package dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.OneCommentVO;
import vo.OneInquiryVO;

public class OneInquiryDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) { 
		this.sqlSession = sqlSession;
	}
	
	//1:1문의 등록
	public int oneInquiryInsert(OneInquiryVO vo) {
		int res = sqlSession.insert("oneinquiry.oneinquiry_insert", vo);
		return res;
	}
	
	//1:1문의 user_idx별 총 갯수 (페이징용)
	public int myInquiryListRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("oneinquiry.oneinquiry_count", map);
		return count;
	}
	
	//1:1문의 user_idx별 목록
	public List<OneInquiryVO> oneInquiryList(Map<String, Object> map) {
		List<OneInquiryVO> list = sqlSession.selectList("oneinquiry.oneinquiry_list", map);
		return list;
	}
	
	//1:1문의 자세히 보기
	public OneInquiryVO oneInquiryView(int oneinquiry_idx) {
		OneInquiryVO vo = sqlSession.selectOne("oneinquiry.oneinquiry_view", oneinquiry_idx); 
		return vo;
	} 
	
	//1:1문의 코멘트 리스트
	 public List<OneCommentVO> oneCommentList(int oneinquiry_idx){
		 List<OneCommentVO> list = sqlSession.selectList("oneinquiry.onecomment_list", oneinquiry_idx); 
		 return list; 
	}
	 
	 
} 
