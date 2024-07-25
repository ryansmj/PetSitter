<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강아지 리스트</title>

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
<link rel="stylesheet"
	href="/project/resources/css/doginfo/doginfo_my.css">

<script>	
    		function send(form){
    			
    			
    			
    			f.submit();	
    		}

    </script>


</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/include/header.jsp" />
	</header>

	<main>


		<h2>나의 강아지 정보</h2>

		<c:forEach var="vo" items="${list}">
			<div id="my_doginfo_containa">
				<form>
					<input type="hidden" name="dog_user_idx" value="${vo.dog_user_idx}">
					<input type="hidden" name="dog_idx" value=${vo.dog_idx }>
				</form>

				<div id="dog_name">
					<p><img style="width: 30px; height: 30px;" src="/project/resources/image/강아지정보아이콘.png"> ${vo.dog_name}의정보</p>
				</div>

				<div id="doginfo_content">
					<div class="dog_photo">
						<c:if test="${ vo.dog_photo_name ne 'no_file' }">
							<img style="width: 200px; height: 200px;"
								src="/project/resources/upload/${vo.dog_photo_name}" width="200">
						</c:if>
					</div>

					<div class="dog_info">
						<div>
							<p>이름 : ${vo.dog_name}</p>
							
							<p>나이 : ${vo.dog_age}살</p>
							
							<p>${vo.dog_size}견</p>
							
							<p>특이사항 : ${vo.dog_care}</p>
						</div>
						<br>
					</div>

				</div>

			</div>

		<div class="dog_send_btn">
			<a href="dog_modify.do?dog_idx=${vo.dog_idx}">
				<button class="after" type="button">수정하기</button>
			</a> <a href="dog_delete.do?dog_idx=${vo.dog_idx }">
				<button class="after" type="button">삭제하기</button>
			</a>
		</div>
		</c:forEach>
	</main>

</body>
</html>
