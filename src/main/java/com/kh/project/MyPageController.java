package com.kh.project;

import java.text.NumberFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MyPageDAO;
import service.MailSendService;
import util.Common;
import util.SitterPaging;
import vo.FavoriteVO;
import vo.PaymentVO;
import vo.ReserveVO;
import vo.SitterApprovalVO;
import vo.SitterVO;
import vo.UserVO;

@Controller
public class MyPageController {

	@Autowired
	ServletContext app;

	@Autowired
	HttpSession session;

	MailSendService mss;
	MyPageDAO mypage_dao;

	public void setMss(MailSendService mss) {
		this.mss = mss;
	}

	public void setMypage_dao(MyPageDAO mypage_dao) {
		this.mypage_dao = mypage_dao;
	}

// 7/9  파라미터가 int일 때 오류잡기
	@RequestMapping("/myPage.do") 
	public String myPage(@RequestParam(value = "user_idx", required = false) Integer user_idx) {
		if (user_idx == null) {
		    throw new IllegalArgumentException("user_idx parameter is required"); 
		}
		return Common.Mypage.VIEW_PATH_MYPAGE + "mypage.jsp";
	}

	// 마이페이지에서 disabled 된 sitterform 보기
	@RequestMapping("/myPage_sitterForm.do")
	public String myPage_sitterForm(int user_idx, Model model) {
		SitterVO vo = mypage_dao.selectList_findOne(user_idx);
		model.addAttribute("vo", vo);

		// 8일 추가본(반려되면이유확인)
		SitterApprovalVO appVO = mypage_dao.selectOne_findApproval(user_idx);
		model.addAttribute("appvo", appVO);

		return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_sitterForm.jsp";
	}

	// 마이페이지에서 disabled 풀린(입력가능한) sitterform 보기
	@RequestMapping("/myPage_sitterFormUpdate.do")
	public String myPage_sitterFormUpdate(int user_idx, Model model) {
		SitterVO vo = mypage_dao.selectList_findOne(user_idx);
		model.addAttribute("vo", vo);
		return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_sitterFormUpdate.jsp";
	}

	// 마이페이지에서 sitterform 적은거 업데이트
	@RequestMapping("/myPage_sitterDoUpdateForm.do")
	public String myPage_sitterDoUpdateForm(SitterVO vo, Model model) {
		int res = mypage_dao.update_sitterForm(vo);
		int res1 = mypage_dao.update_sitterFormReason(vo.getUser_idx());
		/////////////////////////////////////////////
		return "redirect:myPage_sitterForm.do?user_idx=" + vo.getUser_idx();
	}

	@RequestMapping("/modify_form.do")
	public String modify_form(int user_idx, Model model) {
		System.out.println("컨트롤러 파라미터 : " + user_idx);

		UserVO vo = mypage_dao.selectOne_idx(user_idx);
		model.addAttribute("vo", vo);

		return Common.Mypage.VIEW_PATH_MYPAGE + "mypage_modify.jsp";
	}

	@RequestMapping("/modify_telCheck.do") // 번호 유효성 검사
	@ResponseBody
	public String telCheck(UserVO vo) {
		UserVO resVO = mypage_dao.selectOne_modifyTel(vo);
		UserVO existsVO = mypage_dao.selectOne_existsTel(vo);
		// 변경가능
		String result = "yes";

		if (existsVO != null) {
			// 같은 번호를 쓰는 사람이 있음
			result = "exists";
			if (resVO != null) {
				// 이미 내가 저장한 번호 가지고 있음
				result = "no";
			}
		}

		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	}

	// 회원정보 수정
	@RequestMapping("/modify_user.do")
	public String modify(UserVO vo) {
		// 비밀번호가 수정된 값이 넘어오면 암호화, 비어있으면 패스
		if (vo.getUser_pwd() != "" || vo.getUser_pwd() != null) {
			System.out.println(vo.getUser_pwd());
			String encodePwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
			vo.setUser_pwd(encodePwd);
		}

		/* UserVO checkVO = mypage_dao.selectOne_idx(vo.getUser_idx()); */

		if (vo.getUser_postcode() == null || vo.getUser_postcode().isEmpty()) {
			vo.setUser_postcode("-");
		}
		if (vo.getUser_address() == null || vo.getUser_address().isEmpty()) {
			vo.setUser_address("-");
		}
		if (vo.getUser_detailaddress() == null || vo.getUser_detailaddress().isEmpty()) {
			vo.setUser_detailaddress("-");
		}
		if (vo.getUser_extraaddress() == null || vo.getUser_extraaddress().isEmpty()) {
			vo.setUser_extraaddress("-");
		}

		System.out.println("dd" + vo.getUser_email());
		System.out.println(vo.getUser_tel());

		mypage_dao.update(vo); // 업데이트
		UserVO sessionVO = mypage_dao.selectOne_idx(vo.getUser_idx()); // 업데이트 된 DB정보를 다시 가져와서

		session.setAttribute("user", sessionVO); // 세션에 저장
		session.setMaxInactiveInterval(6000 * 30);

		return Common.Mypage.VIEW_PATH_MYPAGE + "mypage.jsp";
	}

	// 7/4
	///////////////////////////////////////////////////////////////////////////////////////////
	// 마이페이지 - 1. 내가 만든 예약 목록
	@RequestMapping("myReserveList.do")
	public String myReserveList(Model model, Integer user_idx, String page) {// user_idx를 null로 설정해야
																				// IllegalStateException오류 안남

		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Sitter.BLOCKLIST + 1;
		int end = start + Common.Sitter.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("user_idx", user_idx);

		int row_total = mypage_dao.myReserveListRowTotal(map);
		String pageMenu = SitterPaging.myReserveListPaging("myReserveList.do", nowPage, row_total, user_idx,
				Common.Sitter.BLOCKLIST, Common.Sitter.BLOCKPAGE);

		List<ReserveVO> list = mypage_dao.myReserveList(map);
		List<PaymentVO> paymentList = mypage_dao.myPaymentList();
		
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_reserve.jsp";
	}

	// 내가 한 예약 취소
	@RequestMapping("cancelReserve.do")
	@ResponseBody
	public String cancelReserve(Model model, int reserve_idx) {
		int res = mypage_dao.cancelReserve(reserve_idx);

		String resultStr = "";
		String result = "no";
		if (res > 0) {
			result = "yes";
		}

		resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr;
	}

	// 2. 받은 예약 목록
	@RequestMapping("myReceiveList.do")
	public String myReceiveList(Model model, Integer sitter_idx, String page) {
		System.out.println("sitter_idx : " + sitter_idx);
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Sitter.BLOCKLIST + 1;
		int end = start + Common.Sitter.BLOCKLIST - 1;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("sitter_idx", sitter_idx);

		int row_total = mypage_dao.myReceiveListRowTotal(map);
		String pageMenu = SitterPaging.myReceiveListPaging("myReceiveList.do", nowPage, row_total, sitter_idx,
				Common.Sitter.BLOCKLIST, Common.Sitter.BLOCKPAGE);

		List<ReserveVO> list = mypage_dao.myReceiveList(map);

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_receive.jsp";
	}

	// 받은 예약 승인
	@RequestMapping("confirmReceive.do")
	@ResponseBody
	public String confirmReceive(Model model, int reserve_idx) {
		int res = mypage_dao.confirmReceive(reserve_idx);

		String resultStr = "";
		String result = "no";
		if (res > 0) {
			result = "yes";
		}

		resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr;
	}

	// 받은 예약 거절
	@RequestMapping("declineReceive.do")
	@ResponseBody
	public String declineReceive(Model model, int reserve_idx) {
		int res = mypage_dao.declineReceive(reserve_idx);

		String resultStr = "";
		String result = "no";
		if (res > 0) {
			result = "yes";
		}

		resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr;
	}

	// 마이페이지 즐겨찾기 목록
	@RequestMapping("myFavoriteList.do")
	public String myFavoriteList(Model model, Integer user_idx, String page) {
		System.out.println("여기는 컨트롤러");
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Sitter.BLOCKLIST + 1;
		int end = start + Common.Sitter.BLOCKLIST - 1;

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("user_idx", user_idx);

		int row_total = mypage_dao.myFavoriteListRowTotal(map);
		String pageMenu = SitterPaging.myFavoriteListPaging("myFavoriteList.do", nowPage, row_total, user_idx,
				Common.Sitter.BLOCKLIST, Common.Sitter.BLOCKPAGE);

		List<SitterVO> list = mypage_dao.myFavoriteList(map);
		System.out.println("리스트사이즈 : " + list.size());

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_favorite.jsp";
	}

	// 즐겨찾기 목록에서 삭제
	@RequestMapping("deleteFavorite.do")
	@ResponseBody
	public String deleteFavorite(Integer user_idx, Integer sitter_idx) {//세션에서 꺼낸 값은 객체이므로 Integer로 받아야 함
		System.out.println("즐찾 삭제 컨트롤러");
		System.out.println("즐찾 user_idx : " + user_idx);
		System.out.println("즐찾 sitter_idx : " + sitter_idx);
		int res = 0;
		if(user_idx != null && sitter_idx != null) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_idx", user_idx);
		map.put("sitter_idx", sitter_idx);

		res = mypage_dao.deleteFavorite(map);
		}

		String resultStr = "";
		String result = "no";
		if (res > 0) {
			result = "yes";
		}

		resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr;
	}

	// 07/09 결제추가
    @RequestMapping("/myPagepayment.do")
    public String myPage_payment(HttpServletRequest request, int reserve_idx, int user_idx, Model model) {
       
       String referer = request.getHeader("Referer");
        String expectedReferer = request.getContextPath() + "/myReserveList.do";

        if (referer == null || !referer.contains(expectedReferer)) {
            model.addAttribute("invalidReferer", true); // invalidReferer 플래그를 모델에 추가
        } else {
            model.addAttribute("invalidReferer", false); // 올바른 경우 플래그를 false로 설정
        }

       ReserveVO vo = mypage_dao.selectOne_reserve(reserve_idx);

       // 씨터의 시간 or 당일 요금 확인하기 위해서
       SitterVO sitterVO = mypage_dao.selectOne_sitter(vo.getReserve_sitter_idx());

       String start = vo.getReserve_start();
       String end = vo.getReserve_end();
       String type = vo.getReserve_type();
       int half_pay = sitterVO.getSitter_price_half();
       int full_pay = sitterVO.getSitter_price_full();

       DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

       int amount = 0;

       if (type.equals("1시간")) {
          LocalDateTime startTime = LocalDateTime.parse(start, formatter);
          LocalDateTime endTime = LocalDateTime.parse(end, formatter);
          Duration duration = Duration.between(startTime, endTime);
          int hoursDifference = (int) duration.toHours();
          amount = half_pay * hoursDifference;
       } else if (type.equals("종일")) {
          DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
          LocalDate startDate = LocalDate.parse(start, dateFormatter);
          LocalDate endDate = LocalDate.parse(end, dateFormatter);
          long daysDifference = Duration.between(startDate.atStartOfDay(), endDate.plusDays(1).atStartOfDay())
                .toDays();
          amount = full_pay * (int) daysDifference;
       }

       // 000 사이에 쉼표 넣어주기 (10,000원)
       NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
       String formattedAmount = numberFormat.format(amount);

       model.addAttribute("vo", vo);
       model.addAttribute("amount", formattedAmount);

       return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_payment.jsp";
    }

    @RequestMapping("/ifPaySuccess.do")
    public String ifPaySuccess(Model model, String payment_amount, int payment_reserve_idx, int payment_user_idx,
          int payment_sitter_idx, String payment_user_name, String payment_sitter_name, String payment_merchant_uid) {
       System.out.println("d");
       PaymentVO paymentVO = new PaymentVO();
       String amountWithoutCommas = payment_amount.replace(",", "");
       int paymentAmount = Integer.parseInt(amountWithoutCommas);
       
       paymentVO.setPayment_amount(paymentAmount);
       paymentVO.setPayment_reserve_idx(payment_reserve_idx);
       paymentVO.setPayment_user_idx(payment_user_idx);
       paymentVO.setPayment_sitter_idx(payment_sitter_idx);
       paymentVO.setPayment_user_name(payment_user_name);
       paymentVO.setPayment_sitter_name(payment_sitter_name);
       paymentVO.setPayment_uid(payment_merchant_uid);
       paymentVO.setPayment_method("카카오페이");
       paymentVO.setPayment_status("결제완료");
       
       mypage_dao.paySuccess(paymentVO);
       mypage_dao.updateReserveStatus(payment_reserve_idx);
       
       
       model.addAttribute("user_idx", payment_user_idx);
       
       return Common.Mypage.VIEW_PATH_MYPAGE + "myPage_paymentSuccess.jsp";
    }

}
