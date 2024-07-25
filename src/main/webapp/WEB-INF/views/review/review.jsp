<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>이용후기 게시판</title>

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
<link rel="stylesheet" href="/project/resources/css/review.css">
<script src="/project/resources/js/httpRequest.js"></script>

<script>
        function showCategory(category) {
            const reviews = document.querySelectorAll('.review');
            reviews.forEach(review => {
                if (category === 'all' || review.dataset.category == category) {
                    review.style.display = 'block';
                } else {
                    review.style.display = 'none';
                }
            });
        }

        function toggleAnswer(element) {
            // 클릭된 요소의 부모인 .review-group 요소를 찾습니다.
            const reviewGroup = element.closest('.review-group');
            
            // 현재 클릭된 .title 요소의 부모 .review-group에서만 .content를 토글합니다.
            const content = reviewGroup.querySelector('.content');
            content.style.display = (content.style.display === 'block') ? 'none' : 'block';
            
            // 클릭된 .title 요소에만 'open' 클래스를 토글합니다.
            element.classList.toggle('open');
        }
    </script>


<script>
        window.onload = function() {
            let search = document.getElementById("search");
            let search_array = ['all', 'sitter', 'title', 'service'];

            for (let i = 0; i < search_array.length; i++) {
                if ('${param.search}' == search_array[i]) {
                    search[i].selected = true;
                    document.getElementById("search_text").value = '${param.search_text}';
                }
            }
        }
        function search() {
            let search = document.getElementById("search").value;
            
            let search_text =
               document.getElementById("search_text").value;

            if (search != 'all' && search_text == '') {
                alert("검색할 내용을 입력하세요");
                return;
            }
            location.href = "reviewList.do?search="+search+
                  "&search_text="+encodeURIComponent(search_text)+
                  "&page=1";
        }
    </script>

<script>
    function del(f){
            
            let idx = document.getElementById('user_idx').value;
            
            
            let url = "delete.do";
            let param = "idx="+idx;
            sendRequest( url, param, resultFn, "post" );
         }
         
         function resultFn(){
            if( xhr.readyState == 4 && xhr.status == 200 ){
               
               let data = xhr.responseText;
               let json = (new Function('return '+data))();
               
      
                  if()
                  
            }
         }
         </script>

</head>

<body>

	<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
	<!-- 헤더 include  -->
	<jsp:include page="/WEB-INF/views/include/header.jsp" />


	<main>

		<h1>한줄후기 게시판</h1>
		<br>
		<br>


		<div class="select_menu">
			<nav class="review-index">
				<div class="index-item" onclick="showCategory('all')">전체</div>
				<div class="index-item" onclick="showCategory('서울')">서울특별시</div>
				<div class="index-item" onclick="showCategory('부산')">부산광역시</div>
				<div class="index-item" onclick="showCategory('대구')">대구광역시</div>
				<div class="index-item" onclick="showCategory('인천')">인천광역시</div>
				<div class="index-item" onclick="showCategory('광주')">광주광역시</div>
				<div class="index-item" onclick="showCategory('대전')">대전광역시</div>
				<div class="index-item" onclick="showCategory('울산')">울산광역시</div>
				<div class="index-item" onclick="showCategory('세종')">세종특별자치시</div>
			</nav>
			<nav class="review-index">
				<div class="index-item" onclick="showCategory('경기')">경기도</div>
				<div class="index-item" onclick="showCategory('강원')">강원도</div>
				<div class="index-item" onclick="showCategory('충청북도')">충청북도</div>
				<div class="index-item" onclick="showCategory('충청남도')">충청남도</div>
				<div class="index-item" onclick="showCategory('전라북도')">전라북도</div>
				<div class="index-item" onclick="showCategory('전라남도')">전라남도</div>
				<div class="index-item" onclick="showCategory('경상북도')">경상북도</div>
				<div class="index-item" onclick="showCategory('경상남도')">경상남도</div>
				<div class="index-item" onclick="showCategory('제주')">제주특별자치도</div>
			</nav>
		</div>

		<div class="review-container" id="all">
			<c:forEach var="vo" items="${list}">
				<div class="review-group">
					<div class="review" data-category="${vo.review_city}">
						<div class="title" onclick="toggleAnswer(this)">
							<h3>이 시터님을 이용한 후기예요</h3>
							<br>
							
							<div class="sitter_review">
							<h2>${vo.review_sitter_name}</h2>
							<P> ${vo.review_city } 지역</P>
							</div>
							
							<br> <P>리뷰 제목 < ${vo.review_title} ><P>
								 <br>

							<div class="star-rating">
								<c:forEach var="i" begin="1" end="${vo.review_star}">
	                            ★
	                        </c:forEach>
								<c:forEach var="i" begin="${vo.review_star + 1}" end="5">
	                            ☆
	                        </c:forEach>
							</div>
							${vo.review_regdate }
						</div>

						<div class="content">
							<c:if test="${ vo.review_photo_name ne 'no_file' }">
								<img style="width: 400px; height: 250px;"
									src="/project/resources/upload/${vo.review_photo_name}">
							</c:if>
							<br> 
							<p>${vo.review_user_name} 회원님의 후기<p>
								<br><br>						
							<p>한줄 후기</p>
							<h3> ${vo.review_content} </h3>

						</div>
						<input type="button" value="삭제" onclick="del(this.form)">
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="search-containa">

		<div id="search">
		<select>
			<option value="all">통합</option>
			<option value="sitter">훈련사이름으로검색</option>
			<option value="title">제목으로검색</option>
			<option value="service">서비스로검색</option>
		</select> 
			<input id="search_text" >
		 <input type="button" value="검색" onclick="search();"> 
		</div>
		
		<div class="page-menu">
      	    ${pageMenu} 
      	</div>
      	
		
		</div>
      	<div class="write-btn">    
			<input type="button"
			id="review_write" value="글쓰기"
			onclick="location.href='review_write.do'">
		</div>
	</main>
</body>

</html>
