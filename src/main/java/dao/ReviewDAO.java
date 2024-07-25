package dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import vo.ReviewVO;

public class ReviewDAO {

	private SqlSession sqlSession;

	public ReviewDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 게시글 조회
	public List<ReviewVO> selectList(Map<String, Object> map) {
		List<ReviewVO> list = sqlSession.selectList("review.selectList", map);
		return list;
	}

	public int insert(ReviewVO vo) {
		int res = sqlSession.insert("review.review_insert", vo);
		return res;
	}

	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("review.review_count", map);
		return count;
	}

	public int delete(int review_user_idx) {
		int res = sqlSession.delete("review.review_delete", review_user_idx);
		return res;
	}
}
