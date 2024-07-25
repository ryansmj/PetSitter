<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    body {
        font-family: 'Arial', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        background-color: #f4f4f9;
    }
    .container {
        background: #fff;
        padding: 40px 60px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    h2 {
        color: #333;
        margin-bottom: 10px;
    }
    h3 {
        color: #555;
        margin-bottom: 30px;
    }
    .buttons {
        display: flex;
        justify-content: space-between;
    }
    .button {
        margin: 0 10px;
        padding: 20px 30px;
        border: none;
        border-radius: 5px;
        text-decoration: none;
        color: #fff;
        font-size: 16px;
        background-color: #007BFF;
        transition: background-color 0.3s, transform 0.3s;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        display: inline-block;
    }
    .button:hover {
        background-color: #0056b3;
        transform: translateY(-3px);
    }
</style>

</head>
<body>
<div class="container">
	<h2>안녕하세요 ${admin.admin_name}님!</h2>
	<h3>어떤 업무를 진행하시겠습니까?</h3>
	
	<div class="buttons">
        <a href="admin_go_client.do?page=1" class="button">
            고객보러가기
        </a>
        <a href="admin_go_confirm.do" class="button">
            제공자 승인 관리
        </a>
        <a href="admin_go_board.do" class="button">
            게시판 관리
        </a>
        <a href="admin_go_payment.do" class="button">
            수익 관리
        </a>
        <a href="admin_go_chart.do" class="button">
            기타 관리자 업무
        </a>
    </div>
</div>
</body>
</html>