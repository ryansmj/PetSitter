<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 화면</title>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
		<script src="/project/resources/js/payment.js"></script>
		<script src="/project/resources/js/httpRequest.js"></script>
		
		
		
    <style>
        body {
            margin: 0;
            padding: 0;
            background-image: url('/project/resources/image/주인과노는강아지.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .payment-box {
            width: 1000px;
            height: 600px;
            border: 2px solid black;
            padding: 50px;
            position: relative;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.8); /* 반투명 배경 */
        }
        .payment-box .title {
            font-size: 32px;
            margin-bottom: 10px;
        }
        .payment-box .amount {
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 40px;
        }
        .payment-box .options {
            display: flex;
            justify-content: space-around;
            position: absolute;
            bottom: 80px;
            width: calc(100% - 100px);
        }
        .payment-box .options div {
            font-size: 32px;
        }
        .payment-box .image-placeholder {
            width: 500px;
            height: 250px;
            border: 2px solid black;
            position: absolute;
            top: 50px;
            right: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        .payment-box .image-placeholder img {
            width: 100%;
            height: auto;
        }
        .payment-details {
            position: absolute;
            top: 110px; /* 위에서부터의 거리 */
            left: 110px; /* 왼쪽에서부터의 거리 */
        }
    </style>
</head>
<body>
	<input type="hidden" value="${amount}" id="amount">
	<input type="hidden" value="${vo.reserve_idx}" id="reserve_idx">
	<input type="hidden" value="${vo.reserve_user_idx}" id="reserve_user_idx">
	<input type="hidden" value="${vo.reserve_sitter_idx}" id="reserve_sitter_idx">
	<input type="hidden" value="${vo.reserve_user_name}" id="reserve_user_name">
	<input type="hidden" value="${vo.reserve_sitter_name}" id="reserve_sitter_name">
	
    <div class="container">
        <div class="payment-box">
            <div class="payment-details">
                <div class="title">돌봐줄개 결제</div>
                <div class="amount">${amount} 원</div>
            </div>
            <div class="image-placeholder">
                <img src="/project/resources/image/산책중인강아지.png" alt="강아지 사진">
            </div>
            <div class="options">
                <div><img src="/project/resources/image/카카오페이.png" alt="카카오페이" onclick="KakaoPay();"></div>
                <div><img src="/project/resources/image/KG이니시스.png" alt="KG이니시스" onclick="InicisPay();"></div>
                <div><img src="/project/resources/image/토스페이.png" alt="토스페이" onclick="TossPay();"></div>
            </div>
        </div>
    </div>
    
    <c:if test="${invalidReferer}">
	    <script>
	        alert('올바른 경로로 접근해 주세요.');
	        location.href="myReserveList.do?user_idx=${sessionScope.user.user_idx }";
	    </script>
	</c:if>

</body>
</html>
