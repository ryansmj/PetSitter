<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
		
		<style>
		
			#footer {
				display:flex;
				justify-content:center;
				position:fixed;
			    background-color: #8BBCFF;
			    color: black;
			    text-align: left;
			    bottom: 0; /* 페이지 하단에 위치 */
            	left: 0;
			    padding: 10px 20px;
			    width: 100%; /* 전체 너비 */
			    flex-shrink: 0; /*푸터가 줄어들지 않도록 설정 */
			    margin-top: auto; /* 상단 여백 자동으로 설정 */
			}
			
			p{
				padding-right: 10px; 
			}
			
		</style>
	
	</head>
	<body>
		
		<!-- Footer -->
    <footer id="footer">
        <p>&#8226;Company : 돌봐줄개</p>
        <p>&#8226;대표 : 강용욱</p>
        <p>&#8226;주소: 서울시 강남구 역삼동</p>
        <p>&#8226;고객센터 : 02-2222-3333</p>
    </footer>
		
	</body>
</html>