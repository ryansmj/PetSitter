<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/project/resources/js/httpRequest.js"></script>

	<style>
		
		main{
			width: 100%;
			height: 100%;
			display: flex;
			align-items: center;
			justify-content: center;
			flex-direction: column;
		}
		
		h1{
			padding: 5%;
		}
		
		table {
				padding: 15px;
				border-radius: 10px;
 			}
 			
 			th{
 				background-color: #C4DEFF;
 				box-shadow: 0 2px 2px #C4DEFF;
 			}
 			
 			td, th{
 				
 				padding:15px;
 				box-shadow: 0 1px 2px #C4DEFF;
 				text-align: center;
 				font-family: Nanum Gothic;
				font-weight: bold;
				border-radius: 5px;
 			}
 			
 			input[type="text"]{
 				padding: 10px;
 				border: 1px solid #C4DEFF;
 				border-radius: 5px;
 			}
 		
			
			input[type="button"]{
				padding: 10px;
				background-color: #C4DEFF;
				border: none;
				border-radius: 5px;
			}
			
			input[type="button"]:hover{
				background-color: #5586EB;
			}
		
		
	</style>


	<script>
		function send() {
			let admin_id = document.getElementById("admin_id").value;
			let admin_pwd = document.getElementById("admin_pwd").value;
	
			if (admin_id == '' || admin_id == null) {
				alert("아이디를 입력해주세요");
				return;
			}
	
			if (admin_pwd == '' || admin_pwd == null) {
				alert("비밀번호를 입력해주세요");
				return;
			}
	
			let url = "admin_loginCheck.do";
			let param = "admin_id=" + admin_id + "&admin_pwd="
					+ encodeURIComponent(admin_pwd); //특수문자있으면처리
			sendRequest(url, param, resultFn, "post");
		}
	
		function resultFn() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				let data = xhr.responseText;
				let json = (new Function('return ' + data))();
	
				if (json[0].result == 'no_id') {
					alert("관리자 계정이 존재하지 않습니다.");
					return;
				} else if (json[0].result == 'no_pwd') {
					alert("비밀번호가 잘못되었습니다. 다시 한번 입력해주세요.");
				} else if (json[0].result == 'yes') {
					location.href = "login_after_admin.do";
				} else {
					alert("오류 발생. 최고 관리자에게 문의 바람.");
				}
			}
		}
	</script>
	
	</head>
	<body>
	
		<main>
		<h1>안녕하세요 관리자 사이트입니다</h1>
	
		<form>
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="admin_id" id="admin_id" placeholder="아이디 입력"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="text" name="admin_pwd" id="admin_pwd"
						placeholder="비밀번호 입력"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="로그인" onclick="send(this.form);">
					<input type="button" value="회원가입"
						onclick="location.href='adminRegForm.do'"></td>
				</tr>
				
			</table>
		</form>
	</main>
	
	</body>
	</html>