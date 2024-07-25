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
			table{border-collapse:collapse;}	
		</style>
		
		<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
		<script src="/project/resources/js/payment.js"></script>
		
		
		<script src="/project/resources/js/httpRequest.js"></script>
		<script>
			function cancel(idx){
				if(!confirm('정말 취소하시겠습니까?')){
					reuturn;
				}
				
				let url = "cancelReserve.do";
				let param = "reserve_idx=" + idx;
				
				sendRequest(url, param, resultFn, "post");
			}
			
			function resultFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('예약취소 완료');
						location.href="myReserveList.do?user_idx=" + ${sessionScope.user.user_idx};
					}else{
						alert('예악취소 실패');
					}
				}
			}
		</script>
		
		<script>
		function openPaymentWindow(reserveIdx, userIdx) {
		    const url = "myPagepayment.do?reserve_idx=" + reserveIdx + "&user_idx=" + userIdx;
		    alert(url);
		    const name = "결제 창";
		    const specs = "width=1000,height=800,left=100,top=50";
		    window.open(url, name, specs);
		}
		</script>
		
	</head>
	
	<body>
		<input type="hidden" name="reserve_idx" value="${vo.reserve_idx}">
	
		<h3>내가 만든 예약</h3>
		
		<div id="reserve_containa">
		
			<table>
				<tr>
					<th>예약 스케줄</th>
					<th>돌봄 유형</th>
					<th>담당 시터</th>
					<th>상태</th>
					<th>예약일</th>
					<th>예약취소</th>
					<th colspan="3">결제</th>
				</tr>
				<c:forEach var='vo' items='${list }'>
					<tr>
						<td>${vo.reserve_start }~${vo.reserve_end }</td>
						<td>${vo.reserve_care } ${vo.reserve_walk } ${reserve_pickup }</td>
						<td>${vo.reserve_sitter_name }</td>
						<td>${vo.reserve_status }</td>
						<td>${fn:split(vo.reserve_regdate, ' ')[0] }</td>
						<c:if test="${vo.reserve_cancel ne 0}"> <!-- 0:시터승인대기 1:승인완료 -2:승인거절 -1:예약취소완료 3:결제완료 -->
				            <td><input type="button" value="예약취소" disabled></td>
				        </c:if>
				        <c:if test="${vo.reserve_cancel eq 0}">
				            <td><input type="button" value="예약취소" onclick="cancel('${vo.reserve_idx}');"></td>
				            <td><input type="button" value="대기중" disabled></td>
				        </c:if>
				        <c:if test="${vo.reserve_cancel eq 1}">
				            <td><input type="button" value="결제하기" 
				                 onclick="openPaymentWindow('${vo.reserve_idx}', '${sessionScope.user.user_idx}')">
				            </td>
				        </c:if>
				        <c:if test="${vo.reserve_cancel eq -2}">
				            <td><input type="button" value="승인거절" disabled></td>
				        </c:if>
				        <c:if test="${vo.reserve_cancel eq -1}">
				            <td><input type="button" value="취소완료" disabled></td>
				        </c:if>
				        <c:if test="${vo.reserve_cancel eq 3}">
				            <td><input type="button" value="결제완료" disabled></td>
				        </c:if>
				    </tr>
				</c:forEach>
			</table>
			
			</div>
		<div class="pageMenu">${pageMenu }</div>
		
	</body>
</html>