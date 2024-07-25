<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
	<!-- 글꼴 -->
    <link rel="preconnect" href="https://fonts.googleapis.com"> 
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
    <link href="https: //fonts.googleapis.com/css2?family=Gamja+Flower&display=swap" rel="stylesheet">
    <!-- 글꼴 여기까지 -->
	
	<style>
		
* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: NanumGothicCoding;
			}
	#header {
		height:120px;
	    background-image:url("/project/resources/image/돌봐줄개.jpg");
	    background-size: contain;
	    background-position: left;
	    background-repeat: no-repeat;
	    background-color:#6799FF;
	    color: black;
	    padding: 10px 20px;
	    text-align: left;
	    border-bottom: 3px solid black;
	    display: flex; /* 플렉스 컨테이너로 설정하여 내부 요소들을 배치 */
	    align-items: flex-end;
	    justify-content:flex-end;
	}
	
	/* .main_name {
	    text-align: left;
	    font-size: 50px;
	    font-weight: bold;
	    color: #F2CB61;
	    margin :30px 0 0 30px;
	    text-shadow: 2px 2px 4px rgba(0, 34, 102, 0.5); 그림자 효과
	    font-family: "Gamja Flower", sans-serif;
	    font-weight: 400;
		font-style: normal;
		
	} */
	
	
	
	/* 메뉴 컨테이너 스타일 */
	#menu {
	    display: flex;
	    justify-content:flex-end;
	    align-items: center;
	    text-shadow: 2px 2px 4px rgba(0, 10, 10, 0.1);
	    
	}
	
	/* 메인 메뉴와 사용자 메뉴 스타일 */
	#menu .main-menu,
	#menu .user-menu {
	    list-style-type: none;
	    margin: 0;
	    padding: 0;
	    display: flex;
	    align-items: center;
	    
	}
	
	/* 메인 메뉴 스타일 */
	#menu .main-menu {
	    flex: 1;
	    justify-content: flex-end;
	    margin-right: 60px;
	}
	
	/* 사용자 메뉴 스타일 */
	#menu .user-menu {
	    justify-content: flex-end;
	    
	}
	
	/* 메뉴 항목 공통 스타일 */
	#menu li {
	    margin: 0 10px;
	    font-size: 20px;
	    cursor: pointer;
	    font-weight: bold;
	    transition: color 0.3s ease, background-color 0.3s ease;
	    padding: 10px 20px;
	    border-radius: 5px;
	    position: relative;
	    
	}
	
	/* 메뉴 항목에 호버 시 색상 변경 */
	#menu li:hover {
	    color: black;
	    background-color: #FFFFD2;
	}
	
	/* 공지사항 메뉴 스타일 */
	.notice {
	    display: none;
	    position: absolute;
	    background-color: #FFFFD2;
	    top: 100%;
	    left: 0;
	    width: 200px;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	    border-radius: 5px;
	    /* 삭제 padding: none; */
	    opacity: 0;
	    transition: opacity 0.3s ease;
	    z-index: 1000; /* 다른 요소 위에 표시하기 위해 z-index 설정 */
	}
	
	.notice li a{
		color: black;
	}
	.notice li {
		/* 추가 */ list-style : none; 
	    color: black;
	    padding: 5px 0;
	    cursor: pointer;
	    
	}
	
	.notice li:hover {
	    color: black;
	    background-color: #FAED7D;
	}
	
	
	
	
	/* 호버 시 하위 메뉴 표시 */
	#menu li:hover .notice {
	    display: block;
	    opacity: 1;
	}
	
	li a {text-decoration:none;
		  color:black;}
		
		</style>
	



</head>
<body>
	
	<!-- Header -->
    <header id="header">
        <h1 class="main_name"></h1>
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
                <li><a href="/project/loginUser.do">이용자 서비스로 가기</a></li>
                
            </ul>
        </div>
    </header>
	
	
	
</body>
</html>