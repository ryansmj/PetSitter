<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    
    <!-- 글꼴 -->
    <link rel="preconnect" href="https://fonts.googleapis.com"> 
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
    <link href="https: //fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
    
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/project/resources/css/login/user_main.css"> 
    
    <script src="/project/resources/js/httpRequest.js"></script>
    
    <script>
    function send() {
    	let user_id = document.getElementById("user_id").value;
		let user_pwd = document.getElementById("user_pwd").value;
		
		if(user_id == '' || user_id == null){
			alert("아이디를 입력해주세요");
			return;
		}
		
		if(user_pwd == '' || user_pwd == null){
			alert("비밀번호를 입력해주세요");
			return;
		}
		
		// idx와 pwd들고 에이잭스 사용하기
		let url = "loginCheck.do";
		let param = "user_id=" + user_id + "&user_pwd=" + encodeURIComponent(user_pwd); //특수문자있으면처리

		sendRequest(url, param, resultFn, "post");
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'no_id') {
				alert("아이디가 존재하지 않습니다.");
				return;
			} else if (json[0].result == 'no_pwd') {
				alert("비밀번호가 잘못되었습니다. 다시 한번 입력해주세요.");
			} else if (json[0].result == 'yes') {
				location.href = "loginAfterUser.do";
			} else{
				alert("오류 발생. 다시 한번 시도해주세요.");
			}
		}
	}
    </script>
</head>
<body>

<!-- 전체 페이지를 감싸는 wrapper -->
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/include/header.jsp"/>
<div class="wrapper">
    

    <!-- Main -->
    <Main>
	     <div id="body">
	     
	     <div id="photo">
	     	 <img src="/project/resources/image/강아지_메인.jpg" alt="메인화면 사진">
	     </div>
	     
	      	<div id="login">
	              <h2>로그인</h2>
	              <div class="form-group">
	                  <label for="user_id">아이디</label>
	                  <input type="text" id="user_id" placeholder="아이디 입력">
	              </div>
	              <div class="form-group">
	                  <label for="user_pwd">비밀번호</label>
	                  <input type="password" id="user_pwd" placeholder="비밀번호 입력">
	              </div>
	              <div class="login-btn-group">
		              <input class="login_btn" type="button" value="로그인" onclick="send();">
		              <input class="join_btn" type="button" value="회원가입" onclick="location.href='loginRegForm.do'">
		              <input class="find_IdPwd_btn" type="button" value="아이디 찾기" onclick="location.href='findIdPwd.do'">
	      		  </div>
	      	</div>
	      </div>
      </Main>

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/include/footer.jsp"/>

</div> 

</body>
</html>
