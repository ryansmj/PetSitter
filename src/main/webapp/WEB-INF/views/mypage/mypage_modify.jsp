<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	boolean tel_isChecked = true;
	boolean user_email_front_isChecked = true;
	boolean user_email_select_isChecked = true;
	boolean user_email_write_isChecked = true;

	pageContext.setAttribute("tel_isChecked", tel_isChecked);
	pageContext.setAttribute("user_email_front_isChecked", user_email_front_isChecked);
	pageContext.setAttribute("user_email_select_isChecked", user_email_select_isChecked);
	pageContext.setAttribute("user_email_write_isChecked", user_email_write_isChecked);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- CSS 파일 링크 -->
<link rel="stylesheet" href="/project/resources/css/login/login_reg_form.css"> <!-- CSS 파일 링크 -->

<script src="/project/resources/js/httpRequest.js"></script>
<script src="/project/resources/js/login_id.js"></script>
<script src="/project/resources/js/login_emailCheck.js"></script>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	window.onload = function() {
		let tel_isChecked = document.getElementById('tel_isChecked').value;
		let user_email_front_isChecked = document.getElementById("user_email_front_isChecked").value;
		let user_email_select_isChecked = document.getElementById("user_email_select_isChecked").value;
		let user_email_write_isChecked = document.getElementById("user_email_write_isChecked").value;
		
		tel_isChecked = true;
		user_email_front_isChecked = true;
		user_email_select_isChecked = true;
		user_email_write_isChecked = true;
		
		
		// db에 저장된 이메일 다시 가져오기(값 자르기..)
		let modify_email = document.getElementById("modify_email").value;
		let emailCut = modify_email.split("@");
		let username = emailCut[0];
		let domain = "@" + emailCut[1];
		document.getElementById("user_email_front").value = username;
		document.getElementById("user_email_write").value = domain;
		 document.getElementById("user_email_write").style.display = "block";
	}
</script>
<script>
	function telCheck_changed_modify(){
		document.getElementById("tel_isChecked").value = 'false';
	}
	function modify_telCheck(){
			 let user_tel = document.getElementById("user_tel").value;
			 let user_id = document.getElementById("user_id").value;

			    // 전화번호 유효성 검사 - 조건: "010"으로 시작하는 11자리 숫자
			    let check_tel = /^010\d{8}$/;
			    
			    if (user_tel === "") {
			        alert("전화번호를 입력해주세요.");
			        return;
			    } else if (!check_tel.test(user_tel)) {
			        alert("전화번호는 '010'으로 시작하는 11자리 숫자여야 합니다.");
			        return;
			    }
			
		    let url = "modify_telCheck.do";
		    let param = "user_tel=" + user_tel + "&user_id=" + user_id; // 파라미터 이름도 user_tel로 수정
		    sendRequest(url, param, modify_telCheckFn, "get");
	}
	/// 번호체크번호체크번호체크
	function modify_telCheckFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == "yes") {
				alert("사용 가능한 번호입니다");
				document.getElementById('tel_isChecked').value = 'true';
				return;
			} else if (json[0].result == "exists"){
				alert("중복된 번호입니다. 다시 입력해주세요.");
				document.getElementById('tel_isChecked').value = 'false';
				return;
			} else {
				alert("이미 고객님이 등록하신 번호입니다. 다시 입력해주세요.");
				document.getElementById('tel_isChecked').value = 'false';
				return;
			}
		}
	}

</script>
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

<script>
function send(f){
	
	let user_pwd =  f.user_pwd.value;
	let user_pwd_check =  f.user_pwd_check.value;
	let user_tel =  f.user_tel.value;
	let user_postcode =  f.user_postcode.value;
	let user_address =  f.user_address.value;
	let user_detailaddress =  f.user_detailaddress.value;
	let user_extraaddress =  f.user_extraaddress.value;
	let user_idx =  f.user_idx.value;
	
	
	
	if(user_pwd != user_pwd_check){
		alert("비밀번호 확인을 해주세요.");
		return;
	}
	
	let check_pwd = /^(?=\S+$).{4,20}$/;
	if(user_pwd !== '' && user_pwd !== null){
	if(!check_pwd.test(user_pwd)){
		alert("비밀번호 확인을 해주세요.");
		return;
	}
}
	
	
	let tel_isChecked = document.getElementById('tel_isChecked').value;
	if(tel_isChecked === "false"){
		alert("번호 중복 체크를 해주세요.");
		return;
	}
		
	f.method="post";
	f.action="modify_user.do";
	f.submit();
}
</script>

<script>
function goMypage(user_idx){
	location.href = "myPage.do?user_idx=" + user_idx;
}
</script>

</head>
<body>
		<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
		<jsp:include page="/WEB-INF/views/include/header.jsp" />
		<main>
		<form method="post"
			  enctype="multipart/form-data">
			   <input type="hidden" id="tel_isChecked" value="${tel_isChecked}">
			   <input type="hidden" id="user_email_front_isChecked" value="${user_email_front_isChecked}">
			   <input type="hidden" id="user_email_select_isChecked" value="${user_email_select_isChecked}">
			   <input type="hidden" id="user_email_write_isChecked" value="${user_email_write_isChecked}">
			   <input type="hidden" id="modify_email" value="${user.user_email}">
			   <input type="hidden" name="user_idx" id="user_idx" value="${user.user_idx}">
			   
		<table>

			<tr>
				<td colspan="2">
					<input type="radio" name="user_type" value="0" id="option1" disabled="disabled"
					 <c:if test="${vo.user_type == 0}">checked</c:if>>
					<label for="option1">이용자*</label><br>
					<input type="radio" name="user_type" value="1" id="option2" disabled="disabled"
					<c:if test="${vo.user_type == 1}">checked</c:if>>
					<label for="option2">제공자*</label><br>
				</td>
			</tr>
			<tr>
				<th>*아이디</th>
				<td>
					<div class="id-input-container">
						<input name="user_id" id="user_id" autofocus onchange="idCheck(this)"
							value="${user.user_id}" readonly="readonly">
						<span id="id_check_message"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>*비밀번호</th>
				<td>
					<input name="user_pwd" type="password" value=''>
				</td>
			</tr>
			<tr>
				<th>*비밀번호 확인</th>
				<td>
					<input name="user_pwd_check" type="password" value=''>
				</td>
			</tr>			
			<tr>
				<th>*성함</th>
				<td>
					<input name="user_name" value="${user.user_name}" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>*전화번호</th>
				<td>
					<div class="tel-container">
						<input type="text" name="user_tel" id="user_tel" oninput="telCheck_changed_modify()" value="${user.user_tel}">
						<input type="button" value="중복검사" onclick="modify_telCheck()">
					</div>
				</td>
			</tr>
			<tr>
				<th>*생년월일</th>
				<td>
					<div>
						<input name="user_birth" id="user_birth" maxlength="6" value="${user.user_birth}" readonly="readonly"> - 
						<input  name="user_gender" id="user_gender" maxlength="1" style="width: 20px;" value="${user.user_gender}" readonly="readonly">● ● ● ● ● ●
					</div>
				</td>
			</tr> 
			<tr>
			 	<th>*이메일</th>
			 	<td> 
			 	<div class="email-modify-container">
					<input type="text" name="user_email_front" id="user_email_front" oninput="user_email_front_changed();" readonly="readonly">
				 	<input type="text" id="user_email_write" name="user_email_write" placeholder="이메일 입력" oninput="user_email_write_changed(); email_backCheck();" readonly="readonly">
				</div>	
				 	<input type="hidden" id="user_email" name="user_email">
			 	</td>
			</tr>
			<tr>
					<!-- API링크 : https://postcode.map.daum.net/guide -->
				<td colspan="2">
					<input type="text" id="postcode" name="user_postcode" placeholder="우편번호" readonly value="${user.user_postcode}">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
					<br>
					<input type="text" id="address" name="user_address" placeholder="주소" readonly value="${user.user_address}">
					<br>
					<input type="text" id="detailaddress" name="user_detailaddress" placeholder="상세주소" value="${user.user_detailaddress}">
					<input type="text" id="extraaddress" name="user_extraaddress" placeholder="참고항목" readonly value="${user.user_extraaddress}">
				</td>
			</tr>
			<tr>
	           <!--  <td colspan="2">
	                <input type="file" name="photo">
	            </td> -->
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수정하기" onclick="send(this.form);">
					<input type="button" value="뒤로가기" onclick="goMypage('${user.user_idx}')">
				</td>
			</tr>
		</table>
	</form>
	
	</main>
</body>
</html>