<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	boolean adminId_isChecked = false;

	pageContext.setAttribute("adminId_isChecked", adminId_isChecked);
%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/project/resources/js/httpRequest.js"></script>


<script>
	function check_adminId(f) {
		
		let admin_id = f.admin_id.value; // 입력된 id 값
		// 아이디 유효성 검사 - 조건: 앞뒤 공백 없음, 5자에서 12자 길이, 대문자.소문자.숫자만 허용
		let check_id = /^[a-zA-Z0-9]{5,12}$/;
		if (admin_id === "" || admin_id === null) {
			alert("아이디를 입력해주세요");
			return;
		} else if (!check_id.test(admin_id)) {
			alert("영문자 또는 숫자, 5자에서 12자 사이.");
			return;
		}

		let url = "admin_idCheck.do"; // 중복 체크
		let param = "admin_id=" + admin_id;

		sendRequest(url, param, idCheckFn, "post");
	}
	function idCheckFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == "yes") {
				document.getElementById('adminId_isChecked').value = 'true';
				alert("사용 가능한 아이디입니다.");
			} else {
				document.getElementById('adminId_isChecked').value = 'false';
				alert("중복된 아이디입니다. 다시 입력해주세요.");
				return;
			}
		}
	}
	
	function adminIdCheck_changed(){
		let adminId_isChecked = document.getElementById('adminId_isChecked').value;
		adminId_isChecked = false;
	}
	
	function send(f){
		let admin_id =  f.admin_id.value;
		let admin_pwd =  f.admin_pwd.value;
		let admin_pwd_check =  f.admin_pwd_check.value;
		let admin_name =  f.admin_name.value;
		
		if (!admin_id || !admin_pwd || !admin_pwd_check || !admin_name) {
	        alert("모든 항목은 필수입니다.");
	        return;
	    }
		
		let adminId_isChecked = document.getElementById('adminId_isChecked').value;
		if(adminId_isChecked === "false"){
			alert("아이디를 체크를 해주세요.");
			return;
		}
		
		if(admin_pwd != admin_pwd_check){
			alert("비밀번호 확인을 해주세요.");
			return;
		}
		
		let check_pwd = /^(?=\S+$).{4,20}$/;
		if(!check_pwd.test(admin_pwd)){
			alert("비밀번호 확인을 해주세요.");
			return;
		}
		
		let check_name = /^[가-힣a-zA-Z\s]{1,20}$/;
		if (!check_name.test(admin_name)){
			alert("이름을 다시 입력해주세요.");
			return;
		}
		
		f.method="post";
		f.action="insertAdmin.do";
		f.submit();
	}
</script>
</head>
<body>
	<form>
		<input type="hidden" id="adminId_isChecked" value="${adminId_isChecked}">
	
		<table>
			<tr>
				<th>아이디</th>
				<td><input name="admin_id" id="admin_id" oninput="adminIdCheck_changed()"></td>
				<td><input type="button" value="중복체크" onclick="check_adminId(this.form)"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="admin_pwd" id="admin_pwd"></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="admin_pwd_check" id="admin_pwd_check"></td>
			</tr>
			<tr>
				<th>성함</th>
				<td><input name="admin_name" id="admin_name"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="계정등록" onclick="send(this.form)"></td>
			</tr>
		</table>

	</form>

</body>
</html>