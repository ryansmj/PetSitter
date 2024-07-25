package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.RequestMapping;

import vo.DoginfoVO;


public class DoginfoDAO {

    private SqlSession sqlSession;

    // 생성자
    public DoginfoDAO(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    public SqlSession getSqlSession() {
        return sqlSession;
    }

    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }
    
    public List<DoginfoVO> selectList(int user_idx) {
        List<DoginfoVO> list = sqlSession.selectList("doginfo.doginfo_list", user_idx);
        return list;
    }
    
    public int insert(DoginfoVO vo) {
    	System.out.println("다오임");
    	int res = sqlSession.insert("doginfo.doginfo_insert",vo);
    	return res;
    }
    
    public DoginfoVO selectOne(int dog_idx) {
		DoginfoVO vo = sqlSession.selectOne("doginfo.select_one", dog_idx);
		return vo;
	}
    
    
    public int update(DoginfoVO vo) {
    	int res = sqlSession.update("doginfo.doginfo_update",vo);
    	return res;
    }
    
    public int delete(int dog_idx) {
  		int res = sqlSession.delete("doginfo.doginfo_delete",dog_idx);
  		return res;
  	}
    
    public int countDogsByUser(int user_idx) {
        return sqlSession.selectOne("doginfo.count_dogs_by_user", user_idx);
    }

}
