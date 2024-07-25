<%@ page language='java' contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

		<!-- 폰트 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
		<!-- 폰트2 -->
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQs</title>
    <link rel="stylesheet" href='/project/resources/css/inquiry.css' />
    
</head>
	<body>
	
	<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
		
	<header>
		<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	</header>
	
	<main>
	<br>
	    <h1>자주 묻는 질문들</h1>
	    <br><br>
	
	<div class="select_menu">
		<nav class="faq-index">
		    <div class="index-item" onclick="showCategory('all')">전체Q&A</div>
		    <div class="index-item" onclick="showCategory('2001')"> 서비스 </div>
		    <div class="index-item" onclick="showCategory('5001')">예약관련</div>
		</nav>
	</div>
	
	<div class="faq-container" id="all">
	    <c:forEach var="vo" items="${list}">
	    
	        <div class="faq" data-category="${vo.inquiry_code}">
	            <div class="question" onclick="toggleAnswer(this)">
	                <h3> ${vo.inquiry_question}</h3>
	            </div>
	            <div class="answer">
	                <p>&nbsp; ${vo.inquiry_answer}</p>
	            </div> 
	        </div>
	    </c:forEach>
	</div>
	
	
		<script>
	    function showCategory(category) {
	        const faqs = document.querySelectorAll('.faq');
	        faqs.forEach(faq => {
	            if (category === 'all' || faq.dataset.category == category) {
	                faq.style.display = 'block';
	            } else {
	                faq.style.display = 'none';
	            }
	        });
	    }
	
	    function toggleAnswer(element) {
	        const answer = element.nextElementSibling;
	        answer.style.display = (answer.style.display === 'block') ? 'none' : 'block';
	        element.classList.toggle('open');
	    }
		</script>
		
	</main>
	
		<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	</body>
	</html>