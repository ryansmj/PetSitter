<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
		<jsp:include page="/WEB-INF/views/include/header.jsp" /> <!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/include/mypage_menu.jsp"/> <!-- 마이페이지 메뉴-->
		
		<style>
			table{border-collapse:collapse;}	
		</style>
		
		<script src="/project/resources/js/httpRequest.js"></script>
		<script>
		/* 예약 승인  */
			function confirmReceive(idx){
				if(!confirm('예약을 승인하시겠습니까?')){
					return;
				}
				
				let url = "confirmReceive.do";
				let param = "reserve_idx=" + idx;
				
				sendRequest(url, param, confirmFn, "post");
			}
			function confirmFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('예약승인 완료');
						location.href="myReceiveList.do?sitter_idx=" + ${sessionScope.sitter.sitter_idx};
					}else{
						alert('예악승인 실패');
					}
				}
			}
			
		/* 예약 거절 */	
			function declineReceive(idx){
				if(!confirm('예약을 거절하시겠습니까?')){
					return;
				}
				
				let url = "declineReceive.do";
				let param = "reserve_idx=" + idx;
				
				sendRequest(url, param, declineFn, "post");
			}
			function declineFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('예약거절 완료');
						location.href="myReceiveList.do?sitter_idx=" + ${sessionScope.sitter.sitter_idx};
					}else{
						alert('예악거절 실패');
					}
				}
			}
		
		</script>
	</head>
	
	<body>
		<input type="hidden" name="reserve_idx" value="${vo.reserve_idx }">
		
		<h3>내가 받은 예약</h3>
		
		<div id="reserve_containa">
		
		<table>
			<tr>
				<th>예약 스케줄</th>
				<th>돌봄 유형</th>
				<th>예약자</th>
				<th>상태</th>
				<th>예약일</th>
				<th colspan="2">예약승인</th>
			</tr>
			<c:forEach var='vo' items='${list }'>
				<tr>
					<td>${vo.reserve_start } ~ ${vo.reserve_end }</td>
					<td>${vo.reserve_care } ${vo.reserve_walk } ${reserve_pickup }</td>
					<td>${vo.reserve_user_name }</td>
					<td>${vo.reserve_status }</td>
					<td>${fn:split(vo.reserve_regdate, ' ')[0] }</td>
					<c:if test="${vo.reserve_cancel ne 0 }"> <!-- 0:시터승인대기 1:승인완료 2:승인거절 -1:예약취소완료  -->
						<td><input type="button" value="예약승인" disabled></td>
						<td><input type="button" value="예약거절" disabled></td>
					</c:if>
					<c:if test="${vo.reserve_cancel eq 0 }">
						<td><input type="button" value="예약승인" onclick="confirmReceive('${vo.reserve_idx}');"></td>
						<td><input type="button" value="예약거절" onclick="declineReceive('${vo.reserve_idx}');"></td>
					</c:if>
					
				</tr>
			</c:forEach>
		</table>
		</div>
		<div class="pageMenu">${pageMenu }</div>
		
	</body>
</html>