<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>돌봐줄개</title>

		<!-- CSS 파일 링크 -->
		<link rel="stylesheet" href="/project/resources/css/login/login_after_user.css"> 
		
		<!-- 폰트 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
		
		<!-- 폰트2 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
	
	<script>
	function dogList(f){
		let url = "dogList.do";
		let param = "user_idx=" + f.user_idx.value;
		
		f.submit();
	}
	</script>
		

</head>
<body>
   <jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
   <!-- 헤더  -->
   <jsp:include page="/WEB-INF/views/include/header.jsp"/>
   
   
   <!-- Main -->
   <main>
   		<div id="body">
   		<div id="photo">
	     	 <img src="/project/resources/image/강아지_메인.jpg" alt="강아지 사진">
	     </div>
   		
   		<div>
	   <div id="user_info">
	   
	   <div class="user_pet_info">
	   <p>${user.user_name }님, (${user.user_id })</p>
	   <a href="dogList.do?user_idx=${user.user_idx}" style="text-decoration: none;">
	   <input class="pet_btn" type="button" value="반려견 정보" onclick="dogList(this.form)">
	   </a>
		
	   </div>

	    <div class="user_name">
	   <p>TEL: ${user.user_tel }</p>
	   <p>EMAIL: ${user.user_email }</p>
	    </div>
	   
	   <p class="pet">반려견</p>
	   <div class="pet_name">
	   <c:if test="${not empty user.dog_name}">
	    
	    <p>이름 : ${user.dog_name}</p> 
	    <p>나이 : ${user.dog_age} 세</p>
	  
	   </c:if>
	   <c:if test="${empty user.dog_name }">
	   <p>반려견 정보를 입력해주세요.</p>
	   </c:if>
	   </div>
	   
	   <div id="send_btn">
	   <input class="after" type="button" value="펫시터지원하기" onclick="location.href='sitterForm.do'">
	   <a href="myPage.do?user_idx=${user.user_idx}" style="text-decoration: none;">
	        <button class="after" type="button">마이페이지</button>
	    </a>
	        <button class="after" type="button">로그아웃</button>
   	   </div>
	   </div>
	   
	
		
   
   </div>
   </div>
   </main>
   
   <!-- footer jsp -->
   <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>