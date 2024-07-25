<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link
			href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
			rel="stylesheet">
		
		<!-- CSS 파일 링크 -->
		<link rel="stylesheet" href="/project/resources/css/myPage/mypage.css">
		
		
		<script>
			function mypage_modify(){
				let user_idx = document.getElementById("user_idx").value;
				location.href="modify_form.do?user_idx=" + user_idx;
			}
			
			function myPage_sitterForm(){
				let user_idx = document.getElementById("user_idx").value;
				location.href="myPage_sitterForm.do?user_idx=" + user_idx;
			}
			
			
/* 7/5 세션에 시터vo가 null이 아닐 경우 receive페이지로 이동*/			
			function mypage_receive(){
				console.log("mypage_receive함수");
				let sitter_idx = document.getElementById("sitter_idx").value;
				
				if(sitter_idx == null || sitter_idx == ''){ //''로 undefined도 잡아야 함
					console.log("sitter_idx 는 null");
					alert("댕시터 미등록 사용자입니다");
					return;
				}else{
					console.log("sitter_idx: " + sitter_idx);
					location.href="myReceiveList.do?sitter_idx=" + sitter_idx;
				}
			}
			
			function mypage_dogsubmit(){
				let user_idx = document.getElementById("user_idx").value;
				location.href="dogwrite.do?user_idx=" + user_idx;
			}

			function mypage_doginfo_my(){
				let user_idx = document.getElementById("user_idx").value;
				location.href="dogList.do?user_idx=" + user_idx;
			}
		
		</script>
	</head>
	
	<body>
		<main id="myPage_menu_main">
		
		<div class="maPage_menu">
		<input type="hidden" value="${user.user_idx}" id="user_idx" name="user_idx"> <!-- 세션에 있는 user_idx -->
		<input type="hidden" value="${sitter.sitter_idx}" id="sitter_idx" name="sitter_idx"> <!-- 7/5 세션에 있는 sitter_idx -->
	    <div class="left-menu">
	        <ul>
	        	<li><a href="javascript:mypage_modify();">정보수정</a></li>
	            <li><a href="javascript:myPage_sitterForm();">나의신청</a></li>
	            <li><a href="myReserveList.do?user_idx=${sessionScope.user.user_idx }">만든예약</a></li> <!-- 7/5 -->
	            <li><a href="javascript:mypage_receive()">받은예약</a></li>
	            <li><a href="myFavoriteList.do?user_idx=${sessionScope.user.user_idx }">즐겨찾기</a></li>
	             <li><a href="oneInquiryList.do?user_idx=${sessionScope.user.user_idx }">1:1문의</a></li><!-- 7/9 -->

	        </ul>
	        
	    </div>
	    </div>
		</main>
	</body>
</html>