package service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailSendService {

	private JavaMailSender javaMailSender;
	private int authNumber = 0;
	private String randPwd;

	// 생성자 인젝션으로 JavaMailSender받을 준비
	public MailSendService(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	// 난수로 인증번호 만들기
	public void makeRandomNumber() {
		Random rnd = new Random();
		// 난수범위 111111 ~ 999999
		int checkNum = rnd.nextInt(999999 - 111111 + 1) + 111111;
		System.out.println("인증번호 : " + checkNum);
		authNumber = checkNum;
	}

	public void makeRandomPwd() {
		String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
		String numbers = "0123456789";
		String specialChars = "!@";

		// 위에 단어들이 랜덤으로 합쳐져서 나옴
		String word = upperCaseLetters + lowerCaseLetters + numbers + specialChars;

		Random rnd = new Random();
		StringBuilder sb = new StringBuilder(8);

		for (int i = 0; i < 8; i++) {
			int randomIndex = rnd.nextInt(word.length());
			sb.append(word.charAt(randomIndex));
		}
		randPwd = sb.toString();

	}

	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = "khteamfour@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "인증번호 알림 이메일 입니다."; // 이메일 제목
		//이메일 내용
		String content = "인증번호는 '<b>" + authNumber + "</b>' 입니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(authNumber);
	} // joinEmail

//**************************************************************
////////////////////////////////////////////////////////////////
// 아이디 찾기
	public String findId_Email(String email, String id) {
		String setFrom = "khteamfour@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "아이디 찾기 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = "회원님의 아이디는 '<b>" + id + "</b>' 입니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(id);
	} // joinEmail

//**************************************************************
////////////////////////////////////////////////////////////////
// 비밀번호 찾기
	public String findPwd_Email(String email) {
		makeRandomPwd();
		String setFrom = "khteamfour@naver.com";// 발송자의 메일주소
		String toMail = email; // 발송할 메일주소
		String title = "변경된 비밀번호 알림 이메일 입니다."; // 이메일 제목
		// 이메일 내용
		String content = "회원님의 새로운 비밀번호는 '<b>" + randPwd + "</b>' 입니다.\n 보안에 취약하니 로그인 즉시 변경바랍니다.";
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			javaMailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
			// 메일 전송 실패 처리
		}
		return String.valueOf(randPwd);
	} // joinEmail

}