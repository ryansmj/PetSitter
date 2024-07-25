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
			position: relative;
            height: 120px;
            background-color: #6799FF;
            color: black;
            padding: 10px 20px;
            text-align: left;
            box-shadow: 0 5px 6px #C4DEFF;
            display: flex;
            justify-content: space-between; /* 요소들을 좌우로 정렬 */
            align-items: center; /* 수직 정렬 */
            flex-shrink: 0;
            z-index: 2000;
            
        }
        .header-left {
            display: flex;
            align-items: center; /* 요소 수직 정렬 */
        }
      
	.a-tag{
		
	}
	
	
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
		
<!-- 7/8 -->
		<script src="/project/resources/js/httpRequest.js"></script>		
		<script>
			function sitterCheck(){
				let url = "sitterSubmitted.do";
				let param = "user_idx=" + ${sessionScope.user.user_idx};
				
				sendRequest(url, param, resultSC, "post");
			}
			function resultSC(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('이미 제출하셨습니다');
						return;
					}else{
						location.href="sitterForm.do";
					}
				}
			}
		</script>
	
	</head>
	
	<body>
		
<!-- Header -->
    <header id="header">
    
    	<div class="a-tag">
    	<a href="loginAfterUser.do">
        <img style="width: 600px; height: 100px;" src="/project/resources/image/돌봐줄개.jpg" alt="돌봐줄개" class="header-image">
    	</a>
    	</div>
    	
        
        <div id="menu">
            <ul class="main-menu">
                <li><a href="service">서비스</a></li>
                <li><a href="findSitter.do">댕시터찾기</a></li>
                <li><a href="reviewList.do">이용 후기</a></li>
                <li><a href="#" onclick="sitterCheck();">댕시터 지원하기</a></li> <!-- 7/9 -->
                <li><a href="myPage.do?user_idx=${sessionScope.user.user_idx }">마이페이지</a></li> <!-- 7/9 -->
                <li>고객센터
                	<ul class="notice">
               			<li><a href="gongList.do">공지사항</a></li>
                		<li><a href="faqList.do">자주 묻는 질문</a></li>
                		<li><a href="oneInquiryForm.do">1 : 1 문의</a></li> <!--7/9  -->
                	</ul>
                </li>
            </ul>
        </div>
	</header>