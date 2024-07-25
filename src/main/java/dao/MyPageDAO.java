package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.FavoriteVO;
import vo.PaymentVO;
import vo.ReserveVO;
import vo.SitterApprovalVO;
import vo.SitterVO;
import vo.UserVO;

public class MyPageDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 유저 인덱스 하나 가져오기
	public UserVO selectOne_idx(int user_idx) {
		UserVO vo = sqlSession.selectOne("mypage.selectOne_idx", user_idx);
		return vo;
	}

	public UserVO selectOne_modifyTel(UserVO vo) {
		UserVO resVO = sqlSession.selectOne("mypage.selectOne_modifyTel", vo);
		return resVO;
	}

	public UserVO selectOne_existsTel(UserVO vo) {
		UserVO existsVO = sqlSession.selectOne("mypage.selectOne_existsTel", vo);
		return existsVO;
	}

	public SitterVO selectList_findOne(int user_idx) {
		SitterVO vo = sqlSession.selectOne("sitter.selectList_findOne", user_idx);
		return vo;
	}

	// 시터 신청 폼 정보 수정
	public int update_sitterForm(SitterVO vo) {
		int res = sqlSession.update("mypage.update_sitterForm", vo);
		System.out.println("dao res : " + res);
		return res;
	}

	// 유저 정보 수정
	public int update(UserVO vo) {
		int res = sqlSession.update("mypage.user_update", vo);
		return res;
	}

	// 7/4
	//////////////////////////////////////////////////////////////////////////////////
	// 내가 만든 예약 취소
	public int cancelReserve(int reserve_idx) {
		int res = sqlSession.update("mypage.reserve_cancel", reserve_idx);
		return res;
	}

	// 내가 만든 예약 전체목록
	public List<ReserveVO> myReserveList(Map<String, Object> map) {
		List<ReserveVO> list = sqlSession.selectList("mypage.reserve_list", map);
		return list;
	}

	// 내가 만든 예약 리스트 카운트 (페이징용)
	public int myReserveListRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("mypage.myreserve_count", map);
		return count;
	}

/////받은 예약 전체목록 (시터에게만 존재하는 예약 목록)
	public List<ReserveVO> myReceiveList(Map<String, Object> map) {
		List<ReserveVO> list = sqlSession.selectList("mypage.receive_list", map);
		return list;
	}

	// 받은 예약 리스트 카운트 (페이징용)
	public int myReceiveListRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("mypage.myreceive_count", map);
		return count;
	}

	// 받은 예약 승인
	public int confirmReceive(int reserve_idx) {
		int res = sqlSession.update("mypage.receive_confirm", reserve_idx);
		return res;
	}

	// 받은 예약 거절
	public int declineReceive(int reserve_idx) {
		int res = sqlSession.update("mypage.receive_decline", reserve_idx);
		return res;
	}

//즐겨찾기 목록
	public List<SitterVO> myFavoriteList(Map<String, Integer> map) {
		List<SitterVO> list = sqlSession.selectList("mypage.favorite_list", map);
		return list;
	}

	// 즐겨찾기 리스트 카운트 (페이징용)
	public int myFavoriteListRowTotal(Map<String, Integer> map) {
		int count = sqlSession.selectOne("mypage.myfavorite_count", map);
		return count;
	}

	// 즐겨찾기 목록에서 삭제
	public int deleteFavorite(Map<String, Integer> map) {
		System.out.println("즐착 삭제 DAO");
		int res = sqlSession.delete("mypage.favorite_delete", map);
		return res;
	}

	// 07/08추가
	public int update_sitterFormReason(int user_idx) {
		int res = sqlSession.update("mypage.update_sitterFormReason", user_idx);
		return res;
	}

	// 07/08추가
	public SitterApprovalVO selectOne_findApproval(int user_idx) {
		SitterApprovalVO appVO = sqlSession.selectOne("mypage.selectOne_findApproval", user_idx);
		return appVO;
	}
	
	// 07/09 결제
	public ReserveVO selectOne_reserve(int reserve_idx) {
		ReserveVO vo = sqlSession.selectOne("mypage.selectOne_reserve", reserve_idx);
		return vo;
	}
	
	public SitterVO selectOne_sitter(int sitter_idx) {
		SitterVO vo = sqlSession.selectOne("mypage.selectOne_sitter", sitter_idx);
		return vo;
	}
	
	public int paySuccess(PaymentVO paymentVO) {
		int res = sqlSession.insert("mypage.paySuccess", paymentVO);
		return res;
	}
	
	public List<PaymentVO> myPaymentList() {
		List<PaymentVO> list = sqlSession.selectList("mypage.myPaymentList");
		return list;
	}
	
	public int updateReserveStatus(int payment_reserve_idx) {
		int res = sqlSession.update("mypage.updateReserveStatus", payment_reserve_idx);
		return res;
	}
	 

}
