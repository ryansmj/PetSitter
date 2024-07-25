<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review 쓰기</title>

	<!-- 폰트 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap"
		rel="stylesheet">
	
	<!-- 폰트2 -->
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
		rel="stylesheet">
	
	<!-- CSS 파일 링크 -->
	<link rel="stylesheet" href="/project/resources/css/review_write.css">


	<script>
        function send(f) {
            let city = f.review_city.value;
            let service = f.review_service.value;

            if (city === "" || city == null) {
                alert("시/도를 선택해주세요.");
                return; 
            }

            if (service === "" || service == null) {
                alert("서비스를 선택해주세요.");
                return; 
            }

            f.submit();
        }

        const drawStars = (target) => {
            const stars = document.querySelectorAll('.star .stars span');
            const value = parseInt(target.value);

            stars.forEach((star, index) => {
                if (index < value) {
                    star.style.color = '#FFE400'; // 별이 채워질 색상
                } else {
                    star.style.color = 'white'; // 빈 별의 색상
                }
            });

            document.querySelector('input[name="review_star"]').value = value;
        }
    </script>
</head>
<body>

	<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<main>
		<h1><img style="width: 80px; height: 80px;" src="/project/resources/image/노트아이콘.png"> 한줄 후기를 작성해주세요</h1>

		<form name="f" method="post" action="review_insert.do"
			enctype="multipart/form-data">
		<div id="form-group">
			<div class="form-group_containa">
				<input type="hidden" name="review_user_name"
					value="${user.user_name}" readonly>
				<p>작성자 : ${user.user_name}</p>
			
			<div class="form-group">
				<label class="label_name" for="city">지역</label>
				<div>
					<select id="city" onchange="send(this)" name="review_city">
						<option value="">시/도 선택</option>
						<option value="서울">서울특별시</option>
						<option value="부산">부산광역시</option>
						<option value="대구">대구광역시</option>
						<option value="인천">인천광역시</option>
						<option value="광주">광주광역시</option>
						<option value="대전">대전광역시</option>
						<option value="울산">울산광역시</option>
						<option value="세종">세종특별자치시</option>
						<option value="경기">경기도</option>
						<option value="강원">강원도</option>
						<option value="충청북도">충청북도</option>
						<option value="충청남도">충청남도</option>
						<option value="전라북도">전라북도</option>
						<option value="전라남도">전라남도</option>
						<option value="경상북도">경상북도</option>
						<option value="경상남도">경상남도</option>
						<option value="제주">제주특별자치도</option>
					</select>
				</div>
				
			</div>
			
			
			<div class="form-group">
				<label class="label_name" for="service">이용한 서비스</label>
				<div>
					<select id="service" onchange="send(this)" name="review_service">
						<option value="">서비스선택</option>
						<option value="산책">산책</option>
						<option value="돌봄">돌봄</option>
						<option value="케어">케어</option>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				
				<label class="label_name" for="review_sitter_name"> 시터님</label>
				<div>
					<input class="review_box" type="text" name="review_sitter_name">
				</div>
			</div>
			
			
			<div class="form-group">
				<label class="label_name" for="review_title">제목</label>
				
				<div>
					<input class="review_box" type="text" name="review_title" size="50" maxlength="20">
				</div>
				
			</div>
			
			
			<div class="form-group">
				<label class="label_name" for="review_content">한 줄 후기</label>
				<div>
					<textarea class="review_box" rows="1" cols="100" maxlength="27"
						style="resize: none; height: 30px;" name="review_content"></textarea>
				</div>
			</div>
			<div class="form-group">
				
				<label class="label_name" for="review_photo">사진 업로드</label>
			
			<div class="custom-file-input">
		        <div class="btn">파일 선택</div>
		        <input type="file" name="review_photo">
		    </div>
		    
			</div>
			
			<div class="form-group">
				<label class="label_name" for="review_star">별점</label>
				<div>
					<div class="star">
						<div class="stars">
							<span></span>
							<span></span>
							<span></span>
							<span></span>
							<span></span>
						</div>
						<input type="range" oninput="drawStars(this)" name="review_star"
							value="1" step="1" min="1" max="5">
					</div>
				</div>
			</div>
	</div>
		</div>

			<div class="form-actions">
				<input type="button" value="등록" onclick="send(this.form);">
				<input type="button" value="뒤로가기" onclick="history.go(-1);">
			</div>

		</form>

		<div class="form-group">
			<div  align="center">${pageMenu}</div>
		</div>
		
		
	</main>
</body>
</html>