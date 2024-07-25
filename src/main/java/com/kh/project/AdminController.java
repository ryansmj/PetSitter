package com.kh.project;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AdminDAO;
import dao.MyPageDAO;
import dao.SitterDAO;
import dao.UserDAO;
import util.Common;
import vo.AdminVO;
import vo.PaymentVO;
import vo.SitterApprovalVO;
import vo.SitterVO;
import vo.UserVO;

@Controller
public class AdminController {

	@Autowired
	HttpSession session;

	AdminDAO admin_dao;

	public void setAdmin_dao(AdminDAO admin_dao) {
		this.admin_dao = admin_dao;
	}

	@RequestMapping("/login_admin.do")
	public String adminLogin() {
		return Common.Admin.VIEW_PATH_ADMIN + "admin_login.jsp";
	}

	@RequestMapping("/adminRegForm.do")
	public String adminRegForm() {
		return Common.Admin.VIEW_PATH_ADMIN + "admin_reg_form.jsp";
	}

	@RequestMapping("/admin_idCheck.do")
	@ResponseBody
	public String admin_idCheck(String admin_id) {
		String result = "no";

		AdminVO vo = admin_dao.selectOne_id(admin_id);

		if (vo == null) {
			result = "yes";
		}
		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	}

	// admin 회원가입
	@RequestMapping("/insertAdmin.do")
	public String insertAdmin(AdminVO vo) {
		vo.setAdmin_tel("-");
		vo.setAdmin_type(4);

		String encodePwd = Common.SecurePwd.encodePwd(vo.getAdmin_pwd());

		vo.setAdmin_pwd(encodePwd);

		admin_dao.insertAdmin(vo);
		return "redirect:login_admin.do";
	}

	// admin 로그인
	@RequestMapping("/admin_loginCheck.do")
	@ResponseBody
	public String admin_loginCheck(AdminVO vo) {
		AdminVO admin_loginVO = admin_dao.selectOne_id(vo.getAdmin_id());

		if (admin_loginVO == null) {
			return "[{'result' : 'no_id'}]";
		}

		boolean isValid = Common.SecurePwd.admin_decodePwd(vo, admin_dao);

		if (isValid) {

			// 로그인 후 세션유지
			session.setAttribute("admin", admin_loginVO);
			session.setMaxInactiveInterval(60 * 30);

			return "[{'result' : 'yes'}]";
		} else if (!isValid) {
			return "[{'result' : 'no_pwd'}]";
		} else {
			return "[{'result' : 'error'}]";
		}
	}

	@RequestMapping("/login_after_admin.do")
	public String login_after_admin() {
		return Common.Admin.VIEW_PATH_ADMIN + "admin_login_after.jsp";
	}

	@RequestMapping("/admin_go_client.do")
	public String admin_go_client(UserVO vo, String admin_searchWord, String admin_search_select, String page,
			Model model) {

		int nowPage = 1;

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		Map<String, Object> map = new HashMap<String, Object>();

		int start = (nowPage - 1) * Common.Admin.BLOCKLIST + 1;
		int end = start + Common.Admin.BLOCKLIST - 1;

		map.put("start", start);
		map.put("end", end);

		if (admin_search_select != null) {

			if (admin_search_select.equals("selectAll")) {

			} else if (admin_search_select.equals("user_idx")) {
				map.put("user_idx", admin_searchWord);
			} else if (admin_search_select.equals("user_id")) {
				map.put("user_id", admin_searchWord);
			} else if (admin_search_select.equals("user_name")) {
				map.put("user_name", admin_searchWord);
			} else if (admin_search_select.equals("user_address")) {
				map.put("user_address", admin_searchWord);
			}
		}

		List<UserVO> list = admin_dao.select_allUser(map);

		// 남자, 여자로 출력
		for (int i = 0; i < list.size(); i++) {
			if ("1".equals(list.get(i).getUser_gender()) || "3".equals(list.get(i).getUser_gender())) {
				list.get(i).setUser_gender("남자");
			} else {
				list.get(i).setUser_gender("여자");
			}
		}

		// 이용자, 제공자로 출력
		for (int i = 0; i < list.size(); i++) {
			if ("0".equals(list.get(i).getUser_type())) {
				list.get(i).setUser_type("이용자");
			} else {
				list.get(i).setUser_type("제공자");
			}
		}

		int row_total = admin_dao.getRowTotal(map);

		// 페이징 처리
		String search_param = String.format("admin_search_select=%s&admin_searchWord=%s", admin_search_select,
				admin_searchWord);
		String pageMenu = util.Paging._getPaging("admin_go_client.do", nowPage, row_total, search_param,
				// 보낼 액션, 현재 페이지 수, 전체 게시글 수
				Common.Admin.BLOCKLIST,
				// 페이지에 보여줄 게시글 수
				Common.Admin.BLOCKPAGE);
		// 페이지에 보여줄 페이지 개수의 수

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Admin.VIEW_PATH_ADMIN + "admin_go_client.jsp";
	}

	// 제출 된 폼들 모아진거 보기
	@RequestMapping("/admin_go_confirm.do")
	public String admin_go_confirm(SitterVO vo, String admin_searchWord, String admin_search_select, String page,
			Model model) {

		int nowPage = 1;

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		Map<String, Object> map = new HashMap<String, Object>();

		int start = (nowPage - 1) * Common.Admin.BLOCKLIST + 1;
		int end = start + Common.Admin.BLOCKLIST - 1;

		map.put("start", start);
		map.put("end", end);

		if (admin_search_select != null) {

			if (admin_search_select.equals("selectAll")) {

			} else if (admin_search_select.equals("user_idx")) {
				map.put("user_idx", admin_searchWord);
			} else if (admin_search_select.equals("user_name")) {
				map.put("user_name", admin_searchWord);
			} else if (admin_search_select.equals("sitter_title")) {
				map.put("sitter_title", admin_searchWord);
			} else if (admin_search_select.equals("sitter_city")) {
				map.put("sitter_city", admin_searchWord);
			}
		}

		List<SitterVO> list = admin_dao.selectList_findList(map);
		
		int row_total = admin_dao.getRowTotal_confirmForm(map);

		// 페이징 처리
		String search_param = String.format("admin_search_select=%s&admin_searchWord=%s", admin_search_select,
				admin_searchWord);
		String pageMenu = util.Paging._getPaging("admin_go_confirm.do", nowPage, row_total, search_param,
				// 보낼 액션, 현재 페이지 수, 전체 게시글 수
				Common.Admin.BLOCKLIST,
				// 페이지에 보여줄 게시글 수
				Common.Admin.BLOCKPAGE);
		// 페이지에 보여줄 페이지 개수의 수

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		return Common.Admin.VIEW_PATH_ADMIN + "admin_go_confirm.jsp";
	}

	// sitterform보고 승인, 거절 창 가기
	@RequestMapping("/admin_go_sitterConfirm.do")
	public String admin_go_sitterConfirm(int user_idx, Model model) {
		SitterVO vo = admin_dao.selectList_findOne(user_idx);
		model.addAttribute("vo", vo);

		return Common.Admin.VIEW_PATH_ADMIN + "admin_go_sitterConfirm.jsp";
	}

	@RequestMapping("/adminSitterFormConfirm.do")
	public String adminSitterFormConfirm(int user_idx, Model model) {
		System.out.println("dd");
		int res = admin_dao.update_sitterApproval_comfirm(user_idx);
		admin_dao.update_sitterApprovalReason_comfirm(user_idx);
		admin_dao.update_userToProvider(user_idx);
		System.out.println(res);
		return "redirect:admin_go_confirm.do";
	}
	
	@RequestMapping("/adminSitterFormRefuseReason.do")
	   public String adminSitterFormRefuseReason(int user_idx, String refuseReason, Model model) {
	      
	      admin_dao.update_SitterApprovalRefuseReason(user_idx, refuseReason);
	      admin_dao.update_sitterApprovalStatus(user_idx);
	      
	      return "redirect:admin_go_confirm.do";
	   }
	
	////////////////////////////////////////////////////////////////
	////////// 그래프 관련

	@RequestMapping("/admin_go_chart.do")
	public String admin_go_chart(Model model) {

		Map<String, Object> map = new HashMap<String, Object>();

		// 가입자 성별 보기
		int findMan = admin_dao.selectOne_findGender("1", "3");
		int findWomen = admin_dao.selectOne_findGender("2", "4");
		model.addAttribute("findMan", findMan);
		model.addAttribute("findWomen", findWomen);

		// 5일간 가입자 수 구하기
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		for (int i = 0; i < 5; i++) {
			LocalDate date = LocalDate.now().minusDays(i);
			String formattedDate = date.format(formatter);
			int dayCount = admin_dao.selectOne_day(formattedDate);
			model.addAttribute("day" + (i + 1), dayCount);
		}

		// 이용자, 제공자 비교
		int user = admin_dao.selectOne_userProvider(0);
		int provider = admin_dao.selectOne_userProvider(1);
		model.addAttribute("user", user);
		model.addAttribute("provider", provider);

		// 가입자 나이대 비교
		int[] ageRanges = { 10, 20, 30, 40, 50 };
		for (int i = 0; i < ageRanges.length; i++) {
			int ageCount = admin_dao.selectOne_ageRange(ageRanges[i], ageRanges[i] + 9);
			model.addAttribute("age" + (i + 1), ageCount);
		}
		
		// 가입자 지역 보기
		String[] location = { "서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", 
				"충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주"};
		for(int i = 0; i < location.length; i++) {
			int locationCount = admin_dao.selectOne_userLocation(location[i]);
			model.addAttribute("location" + (i + 1), locationCount);
		}
		
		// 케어 가능 동물 사이즈 보기
		int small = admin_dao.selectDogSizeCount("small");
	    int medium = admin_dao.selectDogSizeCount("medium");
	    int large = admin_dao.selectDogSizeCount("large");
	    model.addAttribute("small", small);
	    model.addAttribute("medium", medium);
	    model.addAttribute("large", large);
	    
	    // 케어 환경 보기
	    String[] house = { "단독주택", "빌라", "아파트", "오피스텔", "원룸" };
		for(int i = 0; i < house.length; i++) {
			int houseCount = admin_dao.selectOne_sitterHouse(house[i]);
			System.out.println(houseCount);
			model.addAttribute("place" + (i + 1), houseCount);
		}
		
		// 자격증 개수 보기
		int license0 = admin_dao.selectlicenseCount("license0");
		int license1 = admin_dao.selectlicenseCount("license1");
		int license2 = admin_dao.selectlicenseCount("license2");
		int license3 = admin_dao.selectlicenseCount("license3");
		System.out.println("license0:" + license0);
		System.out.println("license1:" + license1);
		System.out.println("license2:" + license2);
		System.out.println("license3:" + license3);
		model.addAttribute("license0", license0);
		model.addAttribute("license1", license1);
		model.addAttribute("license2", license2);
		model.addAttribute("license3", license3);
		
		return Common.Admin.VIEW_PATH_ADMIN + "admin_go_chart.jsp";
	}
	
	
	@RequestMapping("/admin_go_payment.do")
	public String admin_go_payment(PaymentVO vo, String admin_payment_searchWord, String admin_payment_search_select, String page,
			Model model) {
		int nowPage = 1;

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		Map<String, Object> map = new HashMap<String, Object>();

		int start = (nowPage - 1) * Common.Admin.BLOCKLIST + 1;
		int end = start + Common.Admin.BLOCKLIST - 1;

		map.put("start", start);
		map.put("end", end);

		if (admin_payment_search_select != null) {

			if (admin_payment_search_select.equals("selectAll")) {

			} else if (admin_payment_search_select.equals("payment_user_name")) {
				map.put("payment_user_name", admin_payment_searchWord);
			} else if (admin_payment_search_select.equals("payment_sitter_name")) {
				map.put("payment_sitter_name", admin_payment_searchWord);
			} else if (admin_payment_search_select.equals("payment_uid")) {
				map.put("payment_uid", admin_payment_searchWord);
			} 
		}
		List<PaymentVO> list = admin_dao.select_allPayment(map);
		System.out.println(list.size());
		int row_total = admin_dao.getPaymentTotal(map);

		// 페이징 처리
		String search_param = String.format("admin_payment_search_select=%s&admin_payment_searchWord=%s", admin_payment_search_select,
				admin_payment_searchWord);
		String pageMenu = util.Paging._getPaging("admin_go_payment.do", nowPage, row_total, search_param,
				// 보낼 액션, 현재 페이지 수, 전체 게시글 수
				Common.Admin.BLOCKLIST,
				// 페이지에 보여줄 게시글 수
				Common.Admin.BLOCKPAGE);
		// 페이지에 보여줄 페이지 개수의 수
		
		// 그래프 관련
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		for (int i = 0; i < 5; i++) {
			LocalDate date = LocalDate.now().minusDays(i);
			String formattedDate = date.format(formatter);
			int dayCount = admin_dao.selectOne_day_payment(formattedDate);
			System.out.println("데이카운트는 : " + dayCount);
			model.addAttribute("day" + (i + 1), dayCount);
		}

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		
		return Common.Admin.VIEW_PATH_ADMIN + "admin_go_payment.jsp";
	}
	

	@RequestMapping("/admin_go_board.do")
	   public String admin_go_board() {
		return Common.Admin.VIEW_PATH_ADMIN + "admin_go_board.jsp";
	   }
	
	
	
	
	
}
