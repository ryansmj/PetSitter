package util;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.AdminDAO;
import dao.UserDAO;
import vo.AdminVO;
import vo.UserVO;

public class Common {

	public static class Login {
		public static final String VIEW_PATH_LOGIN = "/WEB-INF/views/login/";
		public static final String VIEW_PATH_SERVICE = "/WEB-INF/views/service/";
	}

	public static class Sitter {
		public static final String VIEW_PATH_SITTER = "/WEB-INF/views/sitter/";
// 6/28 추가		
		public static final int BLOCKLIST = 5;
		public static final int BLOCKPAGE = 3;
	}

	public static class Admin {
	      public static final String VIEW_PATH_ADMIN = "/WEB-INF/views/admin/";
	      
	      public final static int BLOCKLIST = 5;
	      public final static int BLOCKPAGE = 3;
	   }

	public static class Mypage {
		public static final String VIEW_PATH_MYPAGE = "/WEB-INF/views/mypage/";
	}

	public static class Include {
		public static final String VIEW_PATH_INCLUDE = "/WEB-INF/views/include/";
	}

	public static class Qna {
		public static final String VIEW_PATH_QNA = "/WEB-INF/views/inquiry/";
	}

	public static class Gong {
		public static final String VIEW_PATH_GONG = "/WEB-INF/views/notice/";
	}
	
	public static class Review {
		public static final String VIEW_PATH_REVIEW = "/WEB-INF/views/review/";
		
		public static final int BLOCKLIST = 10;
		public static final int BLOCKPAGE = 5;
	}
	
//7/9
	public static class OneInquiry {
	public static final String VIEW_PATH_ONEINQUIRY = "/WEB-INF/views/oneinquiry/"; 
	}
	
	public static class Doginfo {
		public static final String VIEW_PATH_DOGINFO = "/WEB-INF/views/doginfo/";
		
		
	}

	public static class SecurePwd {

		// 비밀번호 암호화 메서드
		public static String encodePwd(String pwd) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodePwd = encoder.encode(pwd);// 비밀번호 암호화
			return encodePwd;
		}

		// 비밀번호 복호화 메서드
		public static boolean decodePwd(UserVO vo, UserDAO user_dao) {
			boolean isValid = false;

			// 원래 아이디중복검사용 dao인데 필요 기능은 똑같아서 재활용
			UserVO resultVO = user_dao.selectOne_id(vo.getUser_id());
			System.out.println("디비에 있는 암호" + resultVO.getUser_pwd());
			System.out.println("입력한 나의 암호" + vo.getUser_pwd());
			if (resultVO != null) {
				// 입력한 비밀번호와, DB의 암호화된 비밀번호가 일치하면
				// isValid가 true가 된다
				isValid = BCrypt.checkpw(vo.getUser_pwd(), resultVO.getUser_pwd());
			}
			System.out.println(isValid);
			return isValid;
		}

		// 비밀번호 복호화 메서드
		public static boolean admin_decodePwd(AdminVO vo, AdminDAO admin_dao) {
			boolean isValid = false;

			// 원래 아이디중복검사용 dao인데 필요 기능은 똑같아서 재활용
			AdminVO resultVO = admin_dao.selectOne_id(vo.getAdmin_id());
			if (resultVO != null) {
				// 입력한 비밀번호와, DB의 암호화된 비밀번호가 일치하면
				// isValid가 true가 된다
				isValid = BCrypt.checkpw(vo.getAdmin_pwd(), resultVO.getAdmin_pwd());
			}
			System.out.println(isValid);
			return isValid;
		}

	}

}
