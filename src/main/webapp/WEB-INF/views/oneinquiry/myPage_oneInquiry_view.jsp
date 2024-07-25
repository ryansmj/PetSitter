<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			.table_main{border-collapse:collapse;
				  		width: 700px;
				  		height: 500px;}
				  		
		 	.table_reply{border-collapse:collapse;
				  		width: 700px;
				  		height: 200px;}
		</style>
		
		<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
    	
		<script src="/project/resources/js/httpRequest.js"></script>
		
		
		<script>
			window.onload = function(){
				commList();
			}
			
			function commList(){
				let url = "commentList.do";
				let param = "oneinquiry_idx=" + ${vo.oneinquiry_idx};
				sendRequest(url, param, commListFn, "post");
			}
			function commListFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText; //comment_list.do -> oneComment_list.jsp 갔다가 콜백으로 옴 가지고 온 스트링은 json도 아니라 div에 바로 뿌릴 수 있음
					console.log(data);
					document.getElementById("comment_disp").innerHTML = data;
				}
			}
		</script>
	</head>
	
	<body>
		<div>1:1문의 상세보기</div>
		<table class="table_main" border="1" align="center">
			<tr>
				<td>제목</td>
				<td>${vo.oneinquiry_title }</td>
			</tr>
			
			<tr>
				<td>작성일</td>
				<td>${vo.oneinquiry_regdate }</td>
			</tr>
			
			<tr>
				<td>내용</td>
				<td>${vo.oneinquiry_content }</td>
			</tr>
			
			<tr>
				<td>첨부파일</td>
				<td>
				<c:if test="${vo.oneinquiry_filename ne 'no_file'}">
				<c:choose>
					<c:when test="${vo.oneinquiry_filetype.startsWith('image/')}">
						<img src="${pageContext.request.contextPath}/resources/upload/${vo.oneinquiry_filename}" width="700">
					</c:when>
					<c:otherwise> <!-- 그림 이외의 파일 다운로드 링크 띄우기 -->
						<a href="${pageContext.request.contextPath}/resources/upload/${vo.oneinquiry_filename}" download>download: ${vo.oneinquiry_filename }</a>
					</c:otherwise>
				</c:choose>
				</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="목록보기" onclick="location.href='oneInquiryList.do?user_idx=${sessionScope.user.user_idx}'"></td>
			</tr>
		</table>	
		
		<hr width="700">
		
		<div id="comment_disp"></div>
	</body>
</html>