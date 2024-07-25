<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>

<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    
    <link rel="stylesheet" href="/project/resources/css/service_home.css"> <!-- CSS 파일 링크 -->
    
    <script>
        
    </script>
</head>
<body>

<!-- 전체 페이지를 감싸는 wrapper -->
<div class="wrapper">

    <!-- Header -->
    <header id="header">
        <h1 class="main_name">댕댕아야옹해봐</h1>
        <div id="menu">
            <ul class="main-menu">
                <li>프로필 올리기</li>
                <li>신청자 보기</li>
                <li>스케줄 관리</li>
                <li>나의 고객</li>
                <li>고객센터
                	<ul class="notice">
                		<li>공지사항</li>
                		<li>자주 묻는 질문</li>
                		<li>1 : 1 문의</li>
                	</ul>
                </li>
            </ul>
            <ul class="user-menu">
                <li><a href="/project/login.do">이용자</a></li>
                <li>제공자</li>
            </ul>
        </div>
    </header>

    <!-- Body -->
    <form>
        <div id="body">
            <div id="login">
                <h2>로그인</h2>
                <div class="form-group">
                    <label for="user_name">아이디</label>
                    <input type="text" id="user_name" name="user_name" placeholder="아이디 입력">
                </div>
                <div class="form-group">
                    <label for="user_pwd">비밀번호</label>
                    <input type="password" id="user_pwd" name="user_pwd" placeholder="비밀번호 입력">
                </div>
                <input class="btn1" type="button" value="로그인" onclick="send();">
            </div>
        </div>
    </form>

    <!-- Footer -->
    <footer id="footer">
        <p>KH컴퍼니</p>
        <p>대표 : 김길동</p>
        <p>주소: 서울시 강남구 역삼동</p>
        <p>고객센터 : 02-2222-3333</p>
    </footer>

</div> 

</body>
</html>
		
		
	</body>
</html>