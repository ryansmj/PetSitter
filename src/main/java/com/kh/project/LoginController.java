package com.kh.project;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.DoginfoDAO;
import dao.UserDAO;
import service.MailSendService;
import util.Common;
import vo.SitterVO;
import vo.UserVO;

@Controller
public class LoginController {

	@Autowired
	ServletContext app;

	@Autowired
	HttpSession session;

	MailSendService mss;
	UserDAO user_dao;
	
	DoginfoDAO doginfo_dao;

	public void setMss(MailSendService mss) {
		this.mss = mss;
	}

	public void setUserTest_dao(UserDAO userTest_dao) {
		this.user_dao = userTest_dao;
	}

	@RequestMapping(value = { "/", "loginBeforeMain.do" }) // 최초 실행 페이지
	public String loginBeforeAll() {
		return Common.Login.VIEW_PATH_LOGIN + "login_user.jsp";
	}

	@RequestMapping("loginAfterUser.do") // 로그인 후 이용자메인
	public String loginAfterUser(Model model, Integer dog_user_idx) {
		return Common.Login.VIEW_PATH_LOGIN + "login_after_user.jsp";
	}

//7/5
	@RequestMapping("/loginCheck.do") // 로그인 전 아이디 비번 유무 및 일치 검사
	@ResponseBody
	public String loginCheck(UserVO vo) {
		UserVO loginVO = user_dao.selectOne_id(vo.getUser_id());

		if (loginVO == null) {
			return "[{'result' : 'no_id'}]";
		}

		boolean isValid = Common.SecurePwd.decodePwd(vo, user_dao);

//7/5 user_type이 1일 경우 시터정보 가져와서 세션에 담기
		SitterVO sitter_vo = null;
		if (isValid) {
			
			String user_type = loginVO.getUser_type();
			if(user_type.equals("1")) {
				sitter_vo = user_dao.selectOneSitter(loginVO.getUser_idx());
			}
			
			//시터정보 세션에 담기
			session.setAttribute("sitter", sitter_vo);

			// 로그인 후 세션유지를 위해 유저 정보 세션에 담기
			session.setAttribute("user", loginVO);
			session.setMaxInactiveInterval(60 * 30); // 7/2

			return "[{'result' : 'yes'}]";
		} else if (!isValid) {
			return "[{'result' : 'no_pwd'}]";
		} else {
			return "[{'result' : 'error'}]";
		}
	}

	@RequestMapping("/loginUser.do")
	public String loginUser(UserVO vo) {
		// 로그인 부분

		return Common.Login.VIEW_PATH_LOGIN + "login_user.jsp";
	}

	@RequestMapping("/sitterMain.do")
	public String sitterMain() {
		return Common.Login.VIEW_PATH_LOGIN + "login_sitter.jsp";
	}

	@RequestMapping("/loginRegForm.do")
	public String loginRegForm() {
		return Common.Login.VIEW_PATH_LOGIN + "login_reg_form.jsp";
	}

	@RequestMapping("/idCheck.do") // 아이디 유효성 검사
	@ResponseBody
	public String idCheck(String user_id) {
		String result = "no";

		UserVO vo = user_dao.selectOne_id(user_id);

		if (vo == null) {
			result = "yes";
		}
		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	}

	@RequestMapping("/telCheck.do") // 번호 유효성 검사
	@ResponseBody
	public String telCheck(String user_tel) {
		UserVO vo = user_dao.selectOne_tel(user_tel);

		String result = "no";

		if (vo == null) {
			result = "yes";
		}
		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	}

	@RequestMapping("/insertUser.do")
	   public String insertUser(UserVO vo) {
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

	      String encodePwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());

	      vo.setUser_pwd(encodePwd);
      
	      vo.setUser_type("0");

	      user_dao.insertUser(vo);
	      return "redirect:loginBeforeMain.do";
	   }

	@RequestMapping("/mailCheck.do")
	@ResponseBody
	public String mailCheck(String user_email) {
		System.out.println("내 메일은 : [" + user_email + "]");
		String res = mss.joinEmail(user_email);
		return res;
	}

	// 메일 중복 체크
	@RequestMapping("/emailCheck.do")
	@ResponseBody
	public String emailCheck(String user_email) {
		UserVO vo = user_dao.selectOne_email(user_email);

		String result = "no";

		if (vo == null) {
			result = "yes";
		}
		String resultStr = String.format("[{'result' : '%s'}]", result);
		System.out.println(resultStr);
		return resultStr;
	}

	@RequestMapping("/findIdPwd.do")
	public String findIdPwd() {
		return Common.Login.VIEW_PATH_LOGIN + "login_find_idPwd.jsp";
	}

	// 아이디 찾을 때 db에 이름, 메일있는지 확인
	@RequestMapping("/find_id_check.do")
	@ResponseBody
	public String find_id_check(UserVO vo) {
		UserVO resVO = user_dao.selectOne_findId(vo);

		// 있는 이름 -> 아이디 찾을 수 있음
		String result = "no";

		if (resVO == null) {
			// 없는 이름 -> 아이디 찾을 수 없음
			result = "yes";
		}
		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	}

	// 내 아이디 메일로 전송하기
	@RequestMapping("/emailCheck_sendId.do")
	@ResponseBody
	public String emailCheck_sendId(String user_email, String name) {
		// 전송할 메일 주소 가져오기
		UserVO vo = user_dao.selectOne_takeId(user_email);
		// 메일 주소랑 찾는 아이디 함께 보내기
		String res = mss.findId_Email(user_email, vo.getUser_id());
		return res;
	}

	// 비번 바꿀 때 db에 아이디, 이름, 메일있는지 확인
	@RequestMapping("/find_pwd_check.do")
	@ResponseBody
	public String find_pwd_check(UserVO vo) {
		UserVO resVO = user_dao.selectOne_findPwd(vo);

		// 있는 정보 -> 비번 바꿀 수 있음
		String result = "no";
		System.out.println("비번바꾸기 가능");

		if (resVO == null) {
			System.out.println("정보가없어서 못바꿈");
			// 없는 정보 -> 비번 바꿀 수 없음
			result = "yes";
		}
		String resultStr = String.format("[{'result' : '%s'}]", result);
		return resultStr;
	}

	// 내 아이디 메일로 전송하기
	@RequestMapping("/emailCheck_sendPwd.do")
	@ResponseBody
	public String emailCheck_sendPwd(String user_email) {
		String res = mss.findPwd_Email(user_email);
		// 여기는 먼저 메일을 쏴서 비번을 바꾸는 동시에 db에 update
		System.out.println("pwd메일service의 res : [" + res + "]");
		UserVO vo = new UserVO();
		String encodePwd = Common.SecurePwd.encodePwd(res);
		vo.setUser_pwd(encodePwd);
		vo.setUser_email(user_email);
		user_dao.update_Pwd(vo);
		return res;
	}

	@RequestMapping({ "/service", "/service1", "/service2", "/service3" })
	public String handleServiceRequests(HttpServletRequest request) {
		String viewPath = Common.Login.VIEW_PATH_SERVICE;
		String uri = request.getRequestURI();
		String pageName = uri.substring(uri.lastIndexOf("/") + 1) + ".jsp";
		return viewPath + pageName;
	}

}
