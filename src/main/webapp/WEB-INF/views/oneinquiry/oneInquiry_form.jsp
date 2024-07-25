<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<!-- 폰트 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
		
		<!-- 폰트2 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		
		<!-- CSS 파일 링크 -->
    	<link rel="stylesheet" href="/project/resources/css/oneinquiry/oneinquiry_form.css">
		<script src="/project/resources/js/httpRequest.js"></script>
		
		<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
		
		<style>
			table{border-collapse: collapse;}
		</style>
		<!-- FormData사용 위해 이거 안쓰고 밑에서 xhr선언. FormData는 헤더 자동설정-->
		<script src="/project/resources/js/httpRequest.js"></script> 
		<script>
			function oneInqSubmit(f){
			    console.log("ontinqsub함수");
			    let title = f.oneinquiry_title.value;
			    let category = f.oneinquiry_category.value;
	
			    if(title == '' || title == null){
			        alert("글 제목을 입력하세요");
			        return;
			    }
			    if(category == '' || category == null){
			        alert("카테고리를 선택하세요");
			        return;
			    }
	
			    let url = 'oneInquiryInsert.do';
			    let param = new FormData(f);
	
			    // FormData 데이터 확인
			    for (let pair of param.entries()) {
			        console.log(pair[0] + ', ' + pair[1]);
			    }
	
			    // XMLHttpRequest 객체 생성
			    var xhr = new XMLHttpRequest();
			    xhr.open("POST", url, true);
	
			    // 작업이 완료된 후 호출될 콜백메서드 지정
			    xhr.onreadystatechange = function() {
			        if (xhr.readyState === 4 && xhr.status === 200) {
			            let data = xhr.responseText;
			            let json = (new Function('return ' + data))();
			            
			            if(json[0].result === 'yes'){
			                alert("1:1문의가 등록되었습니다");
			                location.href = "oneInquiryList.do?user_idx=" + ${sessionScope.user.user_idx};
			            } else {
			                alert("등록실패");
			            }
			        }
			    };
	
			    // 요청 전송
			    xhr.send(param);
			}
				
		</script>
	</head>
	
	<body>
	
		<!-- 헤더  -->
		<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	
	
	<main>
	<form method="post" enctype="multipart/form-data">
		<input type="hidden" name="oneinquiry_user_idx" value="${sessionScope.user.user_idx }">
		
		
		<h2>1:1 문의</h2>
		
		<div id="oneinquiry_form">
		
		<div class="oneinquiry_top">
		<p>1:1 문의는 마이페이지에서 확인 가능합니다</p>
	 	<div>제목 <input name="oneinquiry_title" placeholder="제목을 입력하세요"></div>
	 	<br>
	 	<div>
	 	<p>카테고리</p>
	 	<input type="radio" name="oneinquiry_category" value="oneinquiry_care">돌봄
	 	<input type="radio" name="oneinquiry_category" value="oneinquiry_walk">산책(+실외배변)
	 	<input type="radio" name="oneinquiry_category" value="oneinquiry_pickup">픽업
	 	<input type="radio" name="oneinquiry_category" value="oneinquiry_etc">기타
	 	</div>

	 	</div>
	 	
	 	<div>
	 	<p>내용</p>
	 	<textarea name="oneinquiry_content" rows="20" cols="100" style="resize:none" wrap="on"></textarea>
	 	</div>
	 	
	 	<div>
	 	<p>첨부파일</p>
	 	<input type="file" name="oneinquiry_file">
	 	</div>
	 	
	 	<input type="button" value="등록" onclick="oneInqSubmit(this.form)">
	 
	 </div>
	 </form>
	 
	 </main>
	</body>
</html>