<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	
<table align="center" border="1">
	<tr>
		<th>고유 번호</th>
		<th>글 제목</th>
		<th>신청 상황</th>
	</tr>
	<c:forEach var="vo" items="${list}">
		<tr>
			<td>${vo.sitter_idx}</td>
			<td>${vo.sitter_title}</td>
			<td>대기</td>
		</tr>
	</c:forEach>
</table>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>