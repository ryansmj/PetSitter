<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		
		<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
		<jsp:include page="/WEB-INF/views/include/header.jsp" /> <!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/include/mypage_menu.jsp"/> <!-- 마이페이지 메뉴--> 
		
		<style>
			
		</style>
		
		<script src="/project/resources/js/httpRequest.js"></script>
		<script>
			function delFromFav(f){
				//let sitterIdxElement = f.querySelector('input[name="sitter_idx"]');
				console.log('시터idx:' + f.sitter_idx.value);
				
				if(!confirm('정말 삭제하시겠습니까?')){
					return;
				}
				
				let url = "deleteFavorite.do";
/* 7/11  */		let param = "user_idx=" + ${sessionScope.user.user_idx} + "&sitter_idx=" + f.sitter_idx.value;
				sendRequest(url, param, afterDel, "post");
			}
			function afterDel(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('목록에서 삭제 완료');
						location.href="myFavoriteList.do?user_idx=" + ${sessionScope.user.user_idx}; 
						return;
					}else{
						alert('삭제 실패');
						return;
					}
				}
			}
/* 7/11 */			
			function favDetail(element){
				let f = element.closest('form');
			    if (!f) {
			        console.error("Form not found");
			        return;
			    }

				f.action = "findSitterView.do?user_idx=" + f.user_idx.value + "&sitter_idx=" + f.sitter_idx.value;	
				f.method = "post";
				f.submit();
			}
		</script>
		
	</head>
	
	<body>
	<form id="myPage_favorite_form">
		<%-- <input type="hidden" name="user_idx" value="${sessionScope.user.user_idx }"> --%> <!-- 현재 사용자 user_idx  -->
		
		<h3>나의 즐겨찾기</h3>
		<div class="my_favorite">
		<table >
			<tr>
				<th>시터 이름</th>
				<th>지역</th>
				<th>돌봄 가능 반려견 사이즈</th>
				<th>돌봄 가능 분야</th>
				<th>댕시터 보기</th>
				<th>삭제</th>
			</tr>
			<c:forEach var='vo' items='${list }'>
				<form> <!-- form태그 안으로 집어넣기 -->
				<tr>
					<td>
					<input type="hidden" name="sitter_idx" value="${vo.sitter_idx }"> <!--list에 담긴 시터 sitter_idx  -->
<!-- 7/11  -->		<input type="hidden" name="user_idx" value="${vo.user_idx }"> <!--list에 담긴 시터 user_idx  -->
					${vo.sitter_idx }/${vo.user_name }/${vo.user_idx }</td>
					<td>${vo.sitter_city} ${vo.sitter_district }</td>
					<td>${vo.sitter_small } ${vo.sitter_medium } ${vo.sitter_large }</td>
					<td>${vo.sitter_care} ${vo.sitter_walk } ${vo.sitter_pickup } ${vo.sitter_bath } ${vo.sitter_olddog }</td>
<!-- 7/11 -->		<td><a class="more_Atag" href="#" onclick="favDetail(this); return false;">더보기</a></td>
					<td><input type="button" value="삭제" onclick="delFromFav(this.form);"></td>
				</tr>
				</form>
			</c:forEach>
		</table>
		</div> 
		<div class="pageMenu">${pageMenu }</div>
	
	</form>
	</body>
</html>
		
