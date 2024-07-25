
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); %>
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
    	<link rel="stylesheet" href="/project/resources/css/findSitter_view.css?v=<%= timeStamp %>">
		
		<!-- time  -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	    <link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_blue.css">
		<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
		<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
		
		<script src="/project/resources/js/httpRequest.js"></script>
		
		<style>
		.flatpickr-time input {
    		color: white;
    		background-color: #88a9f2 ;
    		font-weight: bold;
		}
		</style>
		
		<script>
		    
			/* 선택한 서비스 타입에 따른 스케줄 형식 */
			function updateFlatpickr(){
				let selectedRadio = document.querySelector('input[name="reserve_type"]:checked');
				if(!selectedRadio){
					console.log("no radio selected");
					return;
				}
				
				let selectedValue = selectedRadio.value;
				
				let flatpickrOptions = {
					enableTime: selectedValue == '1시간',
					noCalendar: false,
					dateFormat: selectedValue == '1시간' ? 'Y-m-d H:i' : 'Y-m-d',
					time_24hr: true,
					locale: "ko"
				};
					
				flatpickr(document.getElementById("reserve_start"), flatpickrOptions);
				flatpickr(document.getElementById("reserve_end"), flatpickrOptions);
			}
			
			/* findSitter_view의 스크립트과 충돌 방지  */
			function initializeReserveForm() {
			    updateFlatpickr();
			    
			    let reserveTypeRadios = document.querySelectorAll('input[name="reserve_type"]');
			    reserveTypeRadios.forEach(radio => {
			        radio.addEventListener('change', updateFlatpickr);
			    });
			}

			window.addEventListener('load', initializeReserveForm);

		</script>
		
	</head>
	<body>
		
		<main>
		<div class="reserve_section">
		<form>
		<input type="hidden" name="reserve_sitter_idx" value="${vo.sitter_idx }"> <!-- 시터idx  -->
		<input type="hidden" name="reserve_sitter_name" value="${vo.user_name }"> <!-- 시터name -->
		<input type="hidden" name="reserve_user_idx" value="${sessionScope.user.user_idx }"> <!-- 세션에 저장된 이용자idx -->
		<input type="hidden" name="reserve_user_name" value="${sessionScope.user.user_name }"> <!-- 세션에 저장된 이용자이름 -->
		
			<p class="reserve_p"><img style="width: 30px; height: 30px;" src="/project/resources/image/예약아이콘.png">댕시터 예약하기</p><br>
			
			<div class="sitter-city">
			
			<div class="select-sitter">지역을 선택하세요</div>
			<select id="city" onchange="sendLocation(this)" name="reserve_city">
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
			
			<select id="district" name="reserve_district">
				<option>구/군 선택</option>
			</select>
			
			<br><br>
			
			<div class="select-sitter">반려견의 크기 선택</div>
			<div class="dog-size">
				<input type="radio" name="reserve_size" value="소형견">소형견
	            <input type="radio" name="reserve_size" value="중형견">중형견
	            <input type="radio" name="reserve_size" value="대형견">대형견
			</div>
			<br>
			
			<div class="select-sitter">돌봄 종류 선택(중복 가능)</div>
			<div class="sitter-type">
				<input type="checkbox" name="reserve_care" value="돌봄">돌봄
	            <input type="checkbox" name="reserve_walk" value="산책(실외배변)">산책+실외배변
	            <input type="checkbox" name="reserve_pickup" value="픽업">픽업
			</div>
			<br>
			
			<div class="select-sitter">서비스 종류 선택</div>
			<div class="select-time">
				<input type="radio" name="reserve_type" value="1시간">1시간
	            <input type="radio" name="reserve_type" value="종일">종일
			</div>
			<br>
			
			<div class="select-sitter">스케줄 선택</div>
			<input type="text" name="reserve_start" id="reserve_start" placeholder="예) 2024-07-02 06:00"> 부터 ~
            <input type="text" name="reserve_end" id="reserve_end" placeholder="예) 2024-07-02 18:00"> 까지
			<br><br>
			
			<div class="select-sitter">요청사항</div>
			<textarea rows="10" cols="50" name="reserve_memo" style="resize:none" wrap="on"></textarea>
			
			<div class="reserve_btn">
			<input type="button" value="예악하기" onclick="sendReserve(this.form)">
			</div>
			
		</div>
		
		
		</form>
		</div>
		
	  <!-- 날짜, 시간 -->      
      <!-- <script>
			flatpickr(document.getElementById("reserve_start"), {
	            enableTime: true,
	            noCalendar: false,
	            dateFormat: "Y-m-d H:i",
	            time_24hr: true,
	            locale: "ko"
	        });
			
			flatpickr(document.getElementById("reserve_end"), {
	            enableTime: true,
	            noCalendar: false,
	            dateFormat: "Y-m-d H:i",
	            time_24hr: true,
	            locale: "ko"
	        });
		</script> -->
		</main>
		
<!-- 7/3 위치변경 -->		
		<script>
		function sendLocation(option){
			let selectedCity = option.value;
			console.log("선택한 도시 jsp : " + selectedCity);
			let url ="getDistrict.do";
			let param = "city=" + selectedCity;
			console.log("param" + param);
			sendRequest(url, param, resultFn, "post");
		}
			
		function resultFn(){
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				//let json = (new Function('return '+data))();
				let json = JSON.parse(data);
				
				let districtSelect = document.getElementById("district");
				districtSelect.innerHTML = '<option value="">구/군 선택</option>';
					
				for(let i = 0; i < json.length; i++){
					let option = document.createElement("option");
					option.value = json[i];
					option.innerHTML = json[i];
					districtSelect.appendChild(option);
				}
			}
		} 
   			
   		function sendReserve(f){
			let city = f.reserve_city.value;
			let district = f.reserve_district.value;
			let size = f.reserve_size.value;	
			let care = f.querySelectorAll('input[name="reserve_care"]:checked').length > 0;
		    let walk = f.querySelectorAll('input[name="reserve_walk"]:checked').length > 0;
		    let pickup = f.querySelectorAll('input[name="reserve_pickup"]:checked').length > 0;
			//let care = f.reserve_care ? f.reserve_care.value : null; //체크 안되어 있으면 빈값이거나 undefined. 이걸 null로 설정한다
			//let walk = f.reserve_walk ? f.reserve_walk.value : null;
			//let pickup = f.reserve_pickup ? f.reserve_pickup.value : null;
			let type = f.reserve_type.value;
			let start = f.reserve_start.value;
			let end = f.reserve_end.value;
			
			if(city == null || city == ''){
				alert('시/도를 선택하세요');
				return;
			}
			
			if(district == null || district == ''){
				alert('구/군을 선택하세요');
				return;
			}
			
			if(size == null || size == ''){
				alert('반려견 크기를 선택하세요');
				return;
			}
			
			if (!care && !walk && !pickup) { //null 또는  빈 문자열인 경우
			    alert('돌봄 종류를 선택하세요');
			    return;
			}
			
			if(type == null || type == ''){
				alert('서비스 종류를 선택하세요');
				return;
			}
			
			if(start == null || start == ''){
				alert('시작 스케줄을 선택하세요');
				return;
			}
			
			if(end == null || end == ''){
				alert('종료 스케줄을 선택하세요');
				return;
			}
			
			//날짜시간 유효성 체크
			let now = new Date();
			let currentDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(),
									   now.getHours(), now.getMinutes(), now.getSeconds());
			let startDate = new Date(start);  
			let endDate = new Date(end);
			
			console.log(currentDate);//Thu Jul 04 2024 12:12:35 GMT+0900 (한국 표준시)
			console.log(startDate);//Tue Jul 02 2024 12:00:00 GMT+0900 (한국 표준시)
			
			if(startDate < currentDate){
				alert("시작 날짜/시간은 현재 날짜/시간 이후여야 합니다");
				return;
			}
			
/* 7/5  */			
			if(type == '1시간'){
				if(end <= start){
					alert("종료 날짜는 시작 날짜 이후여야 합니다");
					return;
				}
			}else{
				if(end < start){
					alert("종료 날짜는 시작 날짜 이후여야 합니다");
					return;
				}
			}

			f.action = "reserve.do";
			f.method = "post";
			f.submit();
			
		}
		
		</script>
	</body>
</html>