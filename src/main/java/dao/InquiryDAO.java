package dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import vo.InquiryVO;

public class InquiryDAO {

    private SqlSession sqlSession;

    public InquiryDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    // 게시글 조회
    public List<InquiryVO> selectList() {
        List<InquiryVO> list = sqlSession.selectList("inquiry.selectList");
        return list;
    }
    
}

