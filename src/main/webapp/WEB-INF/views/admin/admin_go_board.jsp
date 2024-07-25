<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
        color: #333;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    h2 {
        color: #0056b3;
        text-align: center;
    }

    form {
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        width: 100%;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }

    input[type="text"], input[type="password"] {
        width: calc(100% - 20px);
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    button {
        background-color: #ff4757;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        width: 100%;
    }

    button:hover {
        background-color: #e84118;
    }

    form label[for="user_id"], 
    form label[for="password"], 
    form label[for="name"] {
        color: #ff4757;
    }
</style>


</head>
<body>
	<form action="/submit_registration" method="post">
		<label for="user_id">ID:</label>
		<input type="text" id="user_id" name="user_id" required><br>
		<br>
		<label for="password">비밀번호:</label>
		<input type="password" id="password" name="password" required><br>
		<br>
		<label for="name">이름:</label>
		<input type="text" id="name" name="name" required><br>
		<br>
		<button type="submit">가입하기</button>
	</form>
</body>
</html>