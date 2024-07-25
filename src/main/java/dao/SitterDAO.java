package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.ReserveVO;
import vo.SitterApprovalVO;
import vo.SitterVO;

public class SitterDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//시터정보 등록
	public int sitterInsert(SitterVO vo) {
		int res = sqlSession.insert("sitter.sitter_insert", vo);
		return res;
	}
	
	//시터 승인여부 테이블에 등록
	public int sitterApprovalinsert(SitterVO vo) {
		int res = sqlSession.insert("sitter.sitter_approval_insert", vo);
		return res;
	}
// 7/9 여기 map에 user_idx 추가되어 있음. mapper 바뀐 거 확인
	//시터 전체 목록
	public List<SitterVO> selectSitterList(Map<String, Object> map) {
		List<SitterVO> sitter_list = sqlSession.selectList("sitter.sitter_list", map);
		return sitter_list;
	}

	//도/시 선택 후 군/구 가져오기
	public List<String> getDistrict(String selectedCity) {
		List<String> district_list = sqlSession.selectList("sitter.district_list", selectedCity);
		return district_list;
	}

	//시터 승인 여부 자세히 보기
	public SitterApprovalVO selectOne_status() {
		SitterApprovalVO vo = sqlSession.selectOne("sitter.selectOne_status");
		return vo;
	}
	
	//총 시터 수 카운트 (페이징용)
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("sitter.sitter_count", map);
		return count;
	}
	
//7/1	
	//시터 자세히 보기 (시터vo, users의 주소 동시에 가져와서 map에 담아 보낸다)
	public Map<String, Object> sitterSelectOne(SitterVO vo){
		System.out.println("DAO sitter_idx : " + vo.getSitter_idx());
		SitterVO res_vo = sqlSession.selectOne("sitter.sitter_select_one", vo);
		String user_address = sqlSession.selectOne("sitter.user_address", vo);
			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("res_vo", res_vo);
		map.put("user_address", user_address);
			
		return map;
	}	 
// 7/3	
	//예약하기 테이블에 입력
	public int reserveInsert(ReserveVO vo) {
		int res = sqlSession.insert("sitter.reserve_insert", vo);
		return res;
	}
	
//즐겨찾기에 존재하는지 확인
	public int favoriteExists(Map<String, Integer> map) {
        return sqlSession.selectOne("sitter.favorite_exists", map);
    }
	
//즐겨찾기 추가
	public int favoriteInsert(Map<String, Integer> map) {
		int res = sqlSession.insert("sitter.favorite_insert", map);
		return res;
	}
	
// 7/8
//댕시터 지원하기 클릭시 sitter테이블에 존재여부 확인
	public int sitterSubmitted(int user_idx) {
		int count = sqlSession.selectOne("sitter.sitter_submitted_count", user_idx);
		return count;
	}

}
