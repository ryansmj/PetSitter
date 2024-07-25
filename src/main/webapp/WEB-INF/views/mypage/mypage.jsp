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
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap"
			rel="stylesheet">
		<!-- 폰트2 -->
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
			rel="stylesheet">
		
		<!-- CSS 파일 링크 -->
		<link rel="stylesheet" href="/project/resources/css/review.css">
		
		<style>
			/* body {
			    margin: 0;
			    padding: 0;
			    font-family: Arial, sans-serif;
			}
			
			
			header, footer {
			    background-color: #f4f4f4;
			    padding: 10px;
			    text-align: center;
			}
			
			
			.container {
			    display: flex;
			}
			
			
			
			.content {
			    padding: 20px;
			    flex: 1;
			} */
		</style>

		
	</head>
	
	<body>
		<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
		
		<header>
		<jsp:include page="/WEB-INF/views/include/header.jsp" /> <!-- 헤더 -->
		</header>
		
		<main>
		<div id="myPage">
		
		
		<jsp:include page="/WEB-INF/views/include/mypage_menu.jsp" /> <!-- 마이페이지 메뉴 -->
			<h3><img style="width: 50px; height: 50px;" src="/project/resources/image/클릭아이콘.png"> 이용하실 서비스를 선택해 주세요</h3>
			<img class="mypage_img" src="/project/resources/image/행복한댕.png">
		</div>
		
		</main>
	</body>
</html>