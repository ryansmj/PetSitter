<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boolean user_email_front_isChecked = false;
	boolean user_email_select_isChecked = false;
	boolean user_email_write_isChecked = false;
	boolean user_email_front_isChecked_pwd = false;
	boolean user_email_select_isChecked_pwd = false;
	boolean user_email_write_isChecked_pwd = false;

	pageContext.setAttribute("user_email_front_isChecked", user_email_front_isChecked_pwd);
	pageContext.setAttribute("user_email_select_isChecked", user_email_select_isChecked_pwd);
	pageContext.setAttribute("user_email_write_isChecked", user_email_write_isChecked_pwd);
	pageContext.setAttribute("user_email_front_isChecked_pwd", user_email_front_isChecked_pwd);
	pageContext.setAttribute("user_email_select_isChecked_pwd", user_email_select_isChecked_pwd);
	pageContext.setAttribute("user_email_write_isChecked_pwd", user_email_write_isChecked_pwd);
%>    
    
    
<!DOCTYPE html>
<html>

	<!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/project/resources/css/login/login_find_idpwd.css"> 

<head>

	<!-- 폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">

<meta charset="UTF-8">
<title>아이디/ 비밀번호 찾기</title>

<script src="/project/resources/js/httpRequest.js"></script> <!-- AJAX -->
<script src="/project/resources/js/login_emailCheck.js"></script> <!-- 이메일검사 -->
<script src="/project/resources/js/login_findId.js"></script> <!-- 아이디찾기 -->
<script src="/project/resources/js/login_findPwd.js"></script> <!-- 비밀번호찾기 -->

</head>
<body>

	<header>
		<!-- 헤더 include  -->
		<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	</header>
	
	<main>
	
	<input type="hidden" id="user_email_front_isChecked" value="${user_email_front_isChecked}">
	<input type="hidden" id="user_email_select_isChecked" value="${user_email_select_isChecked}">
	<input type="hidden" id="user_email_write_isChecked" value="${user_email_write_isChecked}">
	<input type="hidden" id="user_email_front_isChecked_pwd" value="${user_email_front_isChecked_pwd}">
	<input type="hidden" id="user_email_select_isChecked_pwd" value="${user_email_select_isChecked_pwd}">
	<input type="hidden" id="user_email_write_isChecked_pwd" value="${user_email_write_isChecked_pwd}">
	

	<div>
	<h2>아이디 찾기</h2>
		<div>	
		
		<table align="center" border="1">
			<tr>
				<th>이름</th>
				<td><input type="text" name="user_name" id="user_name"></td>
			</tr>
			<tr>
				<th>메일 인증</th>
				<td> <!-- !!!메일인증을 성공하면 전부 true로 바꿔주기!!! -->
			 	<!-- mailCheck FUNCTION 아직 완성안됨 -->
	             <div class="email-container">
					 <input type="text" name="user_email_front" id="user_email_front" oninput="user_email_front_changed_id();"><br>
					 	<select id="user_email_select" name="user_email_select" style="width:200px;" onchange="user_email_select_changed_id(); emailWriteCheck_id();">
					 		<option value="@naver.com">@naver.com</option>
					 		<option value="@gmail.com">@gmail.com</option>
					 		<option value="@kakao.com">@kakao.com</option>
					 		<option value="@yahoo.com">@yahoo.com</option>
					 		<option value="@hanmail.com">@hanmail.com</option>
					 		<option value="@hotmail.com">@hotmail.com</option>
					 		<option value="write">직접입력</option>
					 	</select>
				</div>
				
				 	<input type="text" id="user_email_write" name="user_email_write" style="display:none;" placeholder="이메일 입력" oninput="user_email_write_changed_id(); email_backCheck_id();">
				 	<span id="user_email_write_warn" style="display:none;"></span>	
				 	<input type="hidden" id="user_email" name="user_email">
    				<input type="button" style="width:200px;" onclick="find_emailCheck();" value="본인인증"><br>
    				<input id="check_mail_input" placeholder="6자리 인증번호"
    					maxlength="6" disabled="disabled">
    				<input type="button" value="확인" style="width:200px;" onclick="check_mail_input_numberCheck();">
			 	</td>
			</tr>

				
		</table>

			<input type="button" value="아이디 찾기" style="width:200px;" onclick="id_send();">

		
		</div>
	</div>	 
	
	<div>
	<h2>비밀번호 찾기</h2>
<form>	
		<div>
		<table align="center" border="1">
			
			<tr>
				<th>아이디</th>
				<td><input type="text" name="user_id" id="user_id_pwd"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="user_name" id="user_name_pwd"></td>
			</tr>
			<tr>
				<th>메일 인증</th>
				<td> <!-- !!!메일인증을 성공하면 전부 true로 바꿔주기!!! -->
	             <div class="email-container">
					 <input type="text" name="user_email_front" id="user_email_front_pwd" oninput="user_email_front_changed_pwd();"><br>
					 	<select id="user_email_select_pwd" name="user_email_select" onchange="user_email_select_changed_pwd(); emailWriteCheck_pwd();">
					 		<option value="@naver.com">@naver.com</option>
					 		<option value="@gmail.com">@gmail.com</option>
					 		<option value="@kakao.com">@kakao.com</option>
					 		<option value="@yahoo.com">@yahoo.com</option>
					 		<option value="@hanmail.com">@hanmail.com</option>
					 		<option value="@hotmail.com">@hotmail.com</option>
					 		<option value="write">직접입력</option>
					 	</select>
				</div>
				
				 	<input type="text" id="user_email_write_pwd" name="user_email_write" style="display:none;" placeholder="이메일 입력" oninput="user_email_write_changed_pwd(); email_backCheck_pwd();">
				 	<span id="user_email_write_warn_pwd" style="display:none;"></span>	
				 	<input type="hidden" id="user_email_pwd" name="user_email">
    				<input type="button" style="width:200px;" onclick="find_emailCheck_pwd();" value="본인인증"><br>
    				<input id="check_mail_input_pwd" placeholder="6자리 인증번호"
    					maxlength="6" disabled="disabled">
    				<input type="button" value="확인" style="width:200px;" onclick="check_mail_input_numberCheck_pwd();">
			 	</td>
			</tr>
		</table>

			<input type="button" value="비밀번호 찾기" style="width:200px;" onclick="pwd_send()">
		
		</div>  	
	</form>	
	</div>	

</main>

	<footer>
	<!-- footer jsp -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	</footer>
		
</body>
</html>