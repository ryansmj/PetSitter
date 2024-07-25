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
		
		<!-- CSS 파일 링크 -->
    	<link rel="stylesheet" href="/project/resources/css/sitter/findSitter.css?v=<%= timeStamp %>">
    	
    	
    	
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
		/* 지역 선택 */
			function send(option){
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
					districtSelect.innerHTML = '<option value="">구/군 선택</option>'; /* 기존에 들어있는 값들 지우기 */
						
					for(let i = 0; i < json.length; i++){
						let option = document.createElement("option");
						option.value = json[i];
						option.innerHTML = json[i];
						districtSelect.appendChild(option);
					}
				}
			}
		/* 검색 */
			function search(f){
				let city = f.sitter_city.value;
				let small = f.sitter_small.checked ? f.sitter_small.value : null;
			    let medium = f.sitter_medium.checked ? f.sitter_medium.value : null;
			    let large = f.sitter_large.checked ? f.sitter_large.value : null;
			    let care = f.sitter_care.checked ? f.sitter_care.value : null;
			    let walk = f.sitter_walk.checked ? f.sitter_walk.value : null;
			    let pickup = f.sitter_pickup.checked ? f.sitter_pickup.value : null;
			    //let orderby = f.orderby.value;
				
				if(city == '' || city == null) {
					alert("시/도를 선택하세요");
					return;
				}
				
				if(small == null && medium == null && large == null){
					alert("반려견 크기를 선택하세요");
					return;
				}
				
				if(care == null && walk == null && pickup == null){
					alert("서비스를 선택하세요");
					return;
				}
				

				let url = "findSitterList.do?"
				let param = new URLSearchParams(new FormData(f)).toString();
				let page = "page=1&";
				url += (page + param);
				location.href = url;
			}
				
		</script>
		
	</head>
	<body>
			<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
			<!-- 헤더  -->
			<jsp:include page="/WEB-INF/views/include/header.jsp"/>
			
			<main>
			<P class="title">조건에 맞는 댕시터님을 검색해보세요</P>
			<br>
			
			<form>
			<p>＊ 지역</p>
			<div class="sitter-city">
			<select id="city" onchange="send(this)" name="sitter_city">
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
			
			<select id="district" name="sitter_district">
				<option>구/군 선택</option>
			</select>
			</div>
			
			<br>
			
			<p>＊ 반려견 크기 (중복가능)</p>
			<div class="dog-size">
				<input type="checkbox" name="sitter_small" value="소형견">소형견(15kg 미만)
	            <input type="checkbox" name="sitter_medium" value="중형견">중형견(15kg~30kg 미만)
	            <input type="checkbox" name="sitter_large" value="대형견">대형견(30kg 이상)
			</div>
			
			<br>
			<p>＊ 돌봄 서비스 타입 (중복가능)</p>
			<div class="sitter-type">
				<input type="checkbox" name="sitter_care" value="돌봄">돌봄
	            <input type="checkbox" name="sitter_walk" value="산책(실외배변)">산책+실외배변 <!-- 6/29  -->
	            <input type="checkbox" name="sitter_pickup" value="픽업">픽업
			</div>
			
			<br>
			
			<p>검색타입</p>
			<div class="sitter-find">
				<select name="orderby">
					<option value="recent">최신등록순</option>
					<option value="lowhalf">낮은 가격순(1시간)</option>
					<option value="lowfull">낮은 가격순(종일)</option>
				</select>
				
			</div>
			
			<br>
			<div id="send-btn">
			<input type="button" value="검색하기" onclick="search(this.form);">
			</div>
		</form>
		
		</main>
	</body>
</html>