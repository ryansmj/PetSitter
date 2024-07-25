<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>        
    
<!DOCTYPE html>
<html>
	<!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/project/resources/css/notice/notice_list.css"> 
	
	<head>
		<meta charset="UTF-8">
		<title>공지사항</title>
	
	<!-- 폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
		
		
	</head>
	
	
	
	<body>
	<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
	<jsp:include page="/WEB-INF/views/include/header.jsp"/>
		
		<main>
		
		<h2>공지사항</h2>
		
		<table>
			
			
			<tr class="top-line" >
				<td class="notis_td"  width="7%">번호</td>
				<td class="notis_td" >제목</td>
				<td class="notis_td" width="20%">작성자</td>
				<td class="notis_td" width="20%">작성일</td>
				<td class="notis_td" width="10%">조회수</td>
			</tr>
			
			<c:forEach var="vo" items="${list}">
			
			<tr>
				<c:if test="${ vo.del_info ne -1 }">
					<td class="notis_td">${vo.notice_idx}</td>
				</c:if>
				
				<c:if test="${ vo.del_info eq -1 }">
					<td class="notis_td">x</td>
				</c:if>
				
				<td class="title">
					<c:if test="${vo.del_info ne -1}">
						<a href="view.do?idx=${vo.notice_idx}&page=${param.page}&search=${param.search}&search_text=${param.search_text}">
						${ vo.notice_title }
						</a>
					</c:if>
					
					<c:if test="${vo.del_info eq -1}">
						<font color="gray">삭제된 게시글 입니다</font>
					</c:if>					
				</td>
				
				<c:if test="${ vo.del_info ne -1 }">
					<td class="notis_td">${vo.notice_name}</td>
				</c:if>
				
				<c:if test="${ vo.del_info eq -1 }">
					<td class="notis_td">unknown</td>
				</c:if>
				
				<td class="notis_td">
				${ fn:split( vo.regdate, ' ' )[0]}
				</td>
				
				<td class="notis_td">${vo.notice_readhit}</td>
				
			</tr>
			
			</c:forEach>
			
		</table>
			<p>${ pageMenu }</p>
		
		</main>
		
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	</body>
</html>



