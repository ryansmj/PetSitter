<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			table{border-collapse: collapse;}
		</style>
		
		<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
    	
		<script src="/project/resources/js/httpRequest.js"></script>
		
	</head>
	
	<body>
		<form>
		<input type="hidden" name="oneinquiry_user_idx" value="${vo.oneinquiry_idx }">
		<div>나의 1:1문의</div>
		<table border="1">
			<tr>
 				<th>번호</th>
 				<th>제목</th>
 				<th>카테고리</th>
 				<th>작성일</th>
 				<th>상태</th>
 			</tr>
 			
 			<c:forEach var="vo" items="${list }">
 			<tr>
				<td>${vo.oneinquiry_idx }</td>
				<td><a href="oneInquiryView.do?oneinquiry_idx=${vo.oneinquiry_idx }">${vo.oneinquiry_title }</a></td>
				<td>${vo.oneinquiry_category }</td>
				<td>${vo.oneinquiry_regdate }</td>
				<td>${vo.oneinquiry_status }</td>
			</c:forEach>
		</table>
		<div>${pageMenu }</div>
 		</form>
	</body>
</html>