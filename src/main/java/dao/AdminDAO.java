package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminVO;
import vo.PaymentVO;
import vo.SitterVO;
import vo.UserVO;

public class AdminDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public AdminVO selectOne_id(String admin_id) {
		AdminVO vo = sqlSession.selectOne("admin.id_check", admin_id);
		return vo;
	}

	// admin controller에서 넘어옴

	// 유저 전체 보기
	public List<UserVO> select_allUser(Map<String, Object> map) {
		List<UserVO> list = sqlSession.selectList("admin.client_list", map);
		return list;
	}
	public List<PaymentVO> select_allPayment(Map<String, Object> map) {
		List<PaymentVO> list = sqlSession.selectList("admin.payment_list", map);
		System.out.println("사이즈는" + list.size());
		return list;
	}

	// 특정 유저 검색
	public List<UserVO> selectList(Map<String, Object> map) {
		List<UserVO> list = sqlSession.selectList("user.select_list", map);
		return list;
	}

	public SitterVO selectList_findOne(int user_idx) {
		SitterVO vo = sqlSession.selectOne("sitter.selectList_findOne", user_idx);
		return vo;
	}

	public int insertAdmin(AdminVO vo) {
		int res = sqlSession.insert("admin.insert_admin", vo);
		return res;
	}

	public List<AdminVO> select_allClient() {
		List<AdminVO> list = sqlSession.selectList("admin.client_list");
		return list;
	}

	// 검색한 전체 게시글 수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("admin.client_count", map);
		System.out.println(count);
		return count;
	}
	
	// 검색한 전체 게시글 수
	public int getPaymentTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("admin.payment_count", map);
		System.out.println(count);
		return count;
	}

	// 제출된 자소서 폼들 모아서 보기
	public List<SitterVO> selectList_findList(Map<String, Object> map) {
		List<SitterVO> list = sqlSession.selectList("admin.selectList_findList", map);
		return list;
	}

	public int getRowTotal_confirmForm(Map<String, Object> map) {
		int count = sqlSession.selectOne("admin.client_count_confirmForm", map);
		System.out.println(count);
		return count;
	}

	public int update_sitterApproval_comfirm(int user_idx) {
		int res = sqlSession.update("sitter.update_sitterApproval_comfirm", user_idx);
		return res;
	}

	public int update_sitterApprovalReason_comfirm(int user_idx) {
		int res = sqlSession.update("sitter.update_sitterApprovalReason_comfirm", user_idx);
		return res;
	}

	public int update_userToProvider(int user_idx) {
		int res = sqlSession.update("user.update_userToProvider", user_idx);
		return res;
	}

	public int update_SitterApprovalRefuseReason(int user_idx, String refuseReason) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_idx", user_idx);
		map.put("refuseReason", refuseReason);
		int res = sqlSession.update("sitter.update_SitterApprovalRefuseReason", map);
		return res;
	}

	public int update_sitterApprovalStatus(int user_idx) {
		int res = sqlSession.update("sitter.update_sitterApprovalStatus", user_idx);
		return res;
	}

	///////////////////////////////////////////////// 그래프관련
	////////////////////////////////////////

	public int selectOne_findGender(String gender1, String gender2) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("gender1", gender1);
		map.put("gender2", gender2);
		int count = sqlSession.selectOne("admin.findGender", map);
		System.out.println(count);
		return count;
	}

	public int selectOne_day(String date) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("date", date);
		int count = sqlSession.selectOne("admin.selectOne_day", map);
		System.out.println(count);
		return count;
	}

	public int selectOne_userProvider(int userType) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("userType", userType);
		int count = sqlSession.selectOne("admin.selectOne_userProvider", map);
		System.out.println(count);
		return count;
	}

	public int selectOne_ageRange(int startAge, int endAge) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startAge", startAge);
		map.put("endAge", endAge);
		int count = sqlSession.selectOne("admin.selectOne_ageRange", map);
		System.out.println(count);
		return count;
	}

	public int selectOne_userLocation(String location) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("location", location);
		int count = sqlSession.selectOne("admin.selectOne_location", map);
		System.out.println("Location: " + location + ", Count: " + count);
		return count;
	}

	public int selectDogSizeCount(String sizeType) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("sizeType", sizeType);
		return sqlSession.selectOne("admin.selectDogSizeCount", map);
	}

	public int selectOne_sitterHouse(String house) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("house", house);
		int count = sqlSession.selectOne("admin.selectOne_sitterHouse", map);
		return count;
	}

	public int selectlicenseCount(String license) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("license", license);
		return sqlSession.selectOne("admin.selectlicenseCount", map);
	}
	
	// 07/ 11 추가
	public int selectOne_day_payment(String date) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("date", date);
		int count = sqlSession.selectOne("admin.selectOne_day_payment", map);
		System.out.println("카운트는" + count);
		return count;
	}

}
