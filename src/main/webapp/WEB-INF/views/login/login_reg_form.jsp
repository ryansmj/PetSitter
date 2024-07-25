	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%
		boolean tel_isChecked = false;
		boolean id_isChecked = false;
		boolean user_email_front_isChecked = false;
		boolean user_email_select_isChecked = false;
		boolean user_email_write_isChecked = false;
	
		pageContext.setAttribute("tel_isChecked", tel_isChecked);
		pageContext.setAttribute("id_isChecked", id_isChecked);
		pageContext.setAttribute("user_email_front_isChecked", user_email_front_isChecked);
		pageContext.setAttribute("user_email_select_isChecked", user_email_select_isChecked);
		pageContext.setAttribute("user_email_write_isChecked", user_email_write_isChecked);
	%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- 폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap"
		rel="stylesheet">
	
	<!-- 폰트2 -->
	<link
		href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
		rel="stylesheet">
	
	<style>
	#id_check_message {
		margin-top: 5px;
		display: block;
		font-size: 10px;
	}
	</style>
	
	<link rel="stylesheet"
		href="/project/resources/css/login/login_reg_form.css">
	<!-- CSS 파일 링크 -->
	
	
	<script src="/project/resources/js/httpRequest.js"></script>
	<script src="/project/resources/js/login_id.js"></script>
	<script src="/project/resources/js/login_tel.js"></script>
	<script src="/project/resources/js/login_emailCheck.js"></script>
	
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<script>
	/* 최초 실행 부분  */
		 window.onload = function() {
	         document.getElementById("id_check_message").innerHTML = "아이디를 입력해주세요.";
	         document.getElementById("id_check_message").style.color = "red";
	         document.getElementById("id_check_message").style.display = "block";
	     }
	</script>
	
	<!-- 주소 관련 시작 -->
	
	<script>
	/* 주소 API */
		function execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수
	
					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}
	
					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if (data.userSelectedType === 'R') {
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraAddr !== '') {
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						document.getElementById("extraaddress").value = extraAddr;
	
					} else {
						document.getElementById("extraaddress").value = '';
					}
	
					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById("address").value = addr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("detailaddress").focus();
				}
			}).open();
		}
	</script>
	<!-- 주소 관련 끝 -->
	
	
	<!-- 가입하기 시작 -->
	<script>
	/* 컨트롤러로 값 전달 */
				function send(f){
				
					let user_id =  f.user_id.value;
					let user_pwd =  f.user_pwd.value;
					let user_pwd_check =  f.user_pwd_check.value;
					let user_name =  f.user_name.value;
					let user_tel =  f.user_tel.value;
					let user_birth = f.user_birth.value;
					let user_gender = f.user_gender.value;
					let user_email = f.user_email.value;
					let user_postcode =  f.user_postcode.value;
					let user_address =  f.user_address.value;
					let user_detailaddress =  f.user_detailaddress.value;
					let user_extraaddress =  f.user_extraaddress.value;
					
					if (!user_id || !user_pwd || !user_pwd_check || !user_name || !user_tel || 
						!user_birth || !user_gender || !user_email) {
				        alert("주소 외 모든 항목은 필수입니다.");
				        return;
				    }
					
					let id_isChecked = document.getElementById('id_isChecked').value;
					if(id_isChecked === "false"){
						alert("아이디를 체크를 해주세요.");
						return;
					}
					
					if(user_pwd != user_pwd_check){
						alert("비밀번호 확인을 해주세요.");
						return;
					}
					
					let check_pwd = /^(?=\S+$).{4,20}$/;
					if(!check_pwd.test(user_pwd)){
						alert("비밀번호 확인을 해주세요.");
					}
					
					let check_name = /^[가-힣a-zA-Z\s]{1,20}$/;
					if (!check_name.test(user_name)){
						alert("이름을 다시 입력해주세요.");
						return;
					}
					
					let tel_isChecked = document.getElementById('tel_isChecked').value;
					if(tel_isChecked === "false"){
						alert("번호 중복 체크를 해주세요.");
						return;
					}
					
					// 월, 일 까지 체크하는 생년월일 조건식
					let check_birth = /^(?:\d{2})(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])$/;
					// 1,2,3,4 인지 체크하는 조건식
					let check_gender = /^[1-4]$/;
					if(!check_birth.test(user_birth) || !check_gender.test(user_gender)){
						alert("생년월일을 다시 입력해주세요.");
						return;
					}
	
					
					
					
					let user_email_front_isChecked = 
						document.getElementById("user_email_front_isChecked").value;
					
					let user_email_select_isChecked = 
						document.getElementById("user_email_select_isChecked").value;
					
					let user_email_write_isChecked = 
						document.getElementById("user_email_write_isChecked").value;
					
					if(user_email_front_isChecked === "false" || user_email_select_isChecked ==="false"
							|| user_email_write_isChecked ==="false"){
						alert("메일 인증을 해주세요.");
						return;
					}
					
					
						
					f.method="post";
					f.action="insertUser.do";
					f.submit();
				}
			
	</script>
	<!-- 가입하기 끝 -->
	
	</head>
	<body>
		<form method="post" enctype="multipart/form-data">
			<input type="hidden" id="tel_isChecked" value="${tel_isChecked}">
			<input type="hidden" id="id_isChecked" value="${id_isChecked}">
			<input type="hidden" id="user_email_front_isChecked"
				value="${user_email_front_isChecked}"> <input type="hidden"
				id="user_email_select_isChecked"
				value="${user_email_select_isChecked}"> <input type="hidden"
				id="user_email_write_isChecked" value="${user_email_write_isChecked}">
			<table>
				<tr>
					<th>*아이디</th>
					<td>
						<div class="id-input-container">
							<input name="user_id" id="user_id" autofocus
								onchange="idCheck(this)">
							<!-- 아이디 유효성, 중복 실시간 검사 -->
							<span id="id_check_message"></span>
						</div>
					</td>
				</tr>
				<tr>
					<th>*비밀번호</th>
					<td><input name="user_pwd" type="password"></td>
				</tr>
				<tr>
					<th>*비밀번호 확인</th>
					<td><input name="user_pwd_check" type="password"></td>
				</tr>
				<tr>
					<th>*성함</th>
					<td><input type="text" name="user_name"></td>
				</tr>
				<tr>
					<th>*전화번호</th>
					<td>
						<div class="tel-container">
							<input type="text" name="user_tel" id="user_tel"
								oninput="telCheck_changed()">
							<!-- 전화번호 중복 검사 후 변경할 경우 함수 호출 -->
							<input type="button" value="중복검사" onclick="telCheck()">
						</div>
					</td>
				</tr>
				<tr>
					<th>*생년월일</th>
					<td>
						<div>
							<input name="user_birth" id="user_birth" maxlength="6"> -
							<input name="user_gender" id="user_gender" maxlength="1"
								style="width: 20px;">● ● ● ● ● ●
						</div>
					</td>
				</tr>
				<tr>
					<th>*이메일</th>
					<td>
						<!-- !!!메일인증을 성공하면 전부 true로 바꿔주기!!! --> <!-- mailCheck FUNCTION 아직 완성안됨 -->
						<div class="email-container">
							<input type="text" name="user_email_front" id="user_email_front"
								oninput="user_email_front_changed();"><br> <select
								id="user_email_select" name="user_email_select"
								onchange="user_email_select_changed(); emailWriteCheck();">
								<option value="@naver.com">@naver.com</option>
								<option value="@gmail.com">@gmail.com</option>
								<option value="@kakao.com">@kakao.com</option>
								<option value="@yahoo.com">@yahoo.com</option>
								<option value="@hanmail.com">@hanmail.com</option>
								<option value="@hotmail.com">@hotmail.com</option>
								<option value="write">직접입력</option>
							</select>
						</div>
	
						<div class="email-input-container">
							<input type="text" id="user_email_write" name="user_email_write"
								style="display: none;" placeholder="이메일 입력"
								oninput="user_email_write_changed(); email_backCheck();">
							<span id="user_email_write_warn" style="display: none;"></span>
						</div> <input type="hidden" id="user_email" name="user_email"> <!-- 전체 메일 합칠 부분 -->
						<!-- !!!합쳐야함!!! --> <input type="button" onclick="emailCheck();"
						value="본인인증"> <input id="check_mail_input"
						placeholder="6자리 인증번호" maxlength="6" disabled="disabled"> <input
						type="button" value="확인" onclick="check_mail_input_numberCheck();">
					</td>
				</tr>
				<tr>
					<!-- API링크 : https://postcode.map.daum.net/guide -->
					<td colspan="2"><input type="text" id="postcode"
						name="user_postcode" placeholder="우편번호" readonly> <input
						type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
						<br> <input type="text" id="address" name="user_address"
						placeholder="주소" readonly> <br> <input type="text"
						id="detailaddress" name="user_detailaddress" placeholder="상세주소">
						<input type="text" id="extraaddress" name="user_extraaddress"
						placeholder="참고항목" readonly></td>
				</tr>
				<tr>
					<!--  <td colspan="2">
		                <input type="file" name="photo">
		            </td> -->
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="button"
						value="가입하기" onclick="send(this.form);"> <input
						type="button" value="뒤로가기" onclick="userMain.do"></td>
				</tr>
			</table>
		</form>
	</body>
	</html>