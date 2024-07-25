<%@page import="vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); %>


<!DOCTYPE html>
<html>
   <head>
   <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/project/resources/css/sitter/sitter_form.css?v=<%= timeStamp %>">
<!-- 6/29  -->   
   <!-- time  -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_blue.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
   
   	<style>
		.flatpickr-time input {
    		color: while;
    		background-color: #88a9f2 ;
    		font-weight: bold;
    		font-size: 20px;
		}
	</style>
   
   <!-- 폰트 -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
      <meta charset="UTF-8">
      <title>댕시터 지원하기</title>
      <script src="/project/resources/js/httpRequest.js"></script>
      
      
      <script>
         function send(f){
            console.log("send 함수");
            let title = f.sitter_title.value;
            let halfprice = f.sitter_price_half.value;
            let fullprice = f.sitter_price_full.value;
            
            if(title == ''){
               alert("글 제목을 입력하세요");
               return;
            }
            
            let num_pattern = /^[0-9]*$/;
            if(halfprice == '' || fullprice == '' || !num_pattern.test(halfprice) || !num_pattern.test(fullprice)){
               alert("금액을 정수로 입력하세요");
               return;
            }
            
            f.action =  "sitterInsert.do";
            f.submit();   
         }
      </script>
      
   </head>


   <body>
   <jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
   <!-- 헤더 include  -->
   <jsp:include page="/WEB-INF/views/include/header.jsp"/>
      
      
      <main>
      <form method="post" enctype="multipart/form-data">
         <input type="hidden" name="user_idx" value="${user.user_idx }">
         <input type="hidden" name="user_name" value="${user.user_name }">
         user-idx : ${user.user_idx }
         user-name : ${user.user_name }
         
         <h1>댕시터 지원하기</h1><br><br>
         
         <div class="title">
         <h3>글 제목</h3>
         <input type="text" name="sitter_title" placeholder="글 제목을 입력하세요">
         </div>
<!--------------------------------------------------------------------------->         
         <div class="address">
         <h3>돌봄 장소</h3>
         지역 : <input type="text" name="sitter_city" value="${fn:split( user.user_address, ' ')[0]}" style="background-color:#f0f0f0" readonly> <br>
         시/군/구 : <input type="text" name="sitter_district" value="${fn:split( user.user_address, ' ')[1]}" style="background-color:#f0f0f0" readonly><br>
         </div>
<!--------------------------------------------------------------------------->            
         <div class="service">
         <h3>가능한 서비스</h3>
         <div class="service-container">
            <input type="checkbox" name="sitter_care" value="돌봄">돌봄
            <input type="checkbox" name="sitter_walk" value="산책(실외배변)">산책+실외배변 <!-- 6/29 -->
            <input type="checkbox" name="sitter_pickup" value="픽업">픽업
            <input type="checkbox" name="sitter_bath" value="목욕">목욕
            <input type="checkbox" name="sitter_olddog" value="노령견">노령견
         </div>
         </div>
<!--------------------------------------------------------------------------->            
         <div class="environment">
         <h3>돌봄 환경</h3>
         <div class="house">
         <div>돌봄 공간</div>
         <select name="sitter_house">
            <option value="">선택하세요</option>
            <option value="단독주택">단독주택</option>
            <option value="빌라">빌라</option>
            <option value="아파트">아파트</option>
            <option value="오피스텔">오피스텔</option>
            <option value="원룸">원룸</option>
         </select>
         </div>
         
         <div class="dogcount">
         <div>돌봄가능 반려견수</div>
         <select name="sitter_dogcount">
            <option value="">선택하세요</option>
            <option value="1마리">1마리</option>
            <option value="2마리">2마리</option>
            <option value="3마리">3마리</option>
         </select>
         </div>
         
         <div class="kid">
         <div>12세 이하 아동</div>
         <select name="sitter_kid">
            <option value="">선택하세요</option>
            <option value="없음">없음</option>
            <option value="있음">있음</option>
         </select>
         </div>
         
         <div class="homecam">
         <div>홈 시큐리티 카메라</div>
         <select name="sitter_homecam">
            <option value="">선택하세요</option>
            <option value="없음">없음</option>
            <option value="있음">있음</option>
         </select>
         </div>
         
         <div class="fence">
         <div>반려견 펜스</div>
         <select name="sitter_fence">
            <option value="">선택하세요</option>
            <option value="없음">없음</option>
            <option value="있음">있음</option>
         </select>
         </div>
         
         <div class="pet">
         <div>동거 반려동물</div>
         <select name="sitter_pet">
            <option value="">선택하세요</option>
            <option value="없음">없음</option>
            <option value="강아지">강아지</option>
            <option value="고양이">고양이</option>
         </select>
         </div>
         </div>
<!--------------------------------------------------------------------------->            
         <div class="pet_size">
         <h3>돌봄 가능한 반려견 크기</h3>
            <div class="dogsize">
            <input type="checkbox" name="sitter_small" value="소형견">소형견(15kg 미만)
            <input type="checkbox" name="sitter_medium" value="중형견">중형견(15kg~30kg 미만)
            <input type="checkbox" name="sitter_large" value="대형견">대형견(30kg 이상)
            </div>
         </div>
<!--------------------------------------------------------------------------->
         <div class="pet_time">
         <div>종일 돌봄 시간</div>
<!-- 6/29  -->
            <input type="time" name="sitter_start_time" id="sitter_start_time" placeholder="예)07:00"> 부터 ~
            <input type="time" name="sitter_end_time" id="sitter_end_time" placeholder="예)18:00"> 까지
               
         </div>
<!--------------------------------------------------------------------------->   
         <div class="introduce">
         <h3>소개글</h3>
            <textarea name="sitter_introduce" rows="10" cols="50" style="resize:none" wrap="on"></textarea>
         </div>         
<!--------------------------------------------------------------------------->      
         <div class="photo">
         <h3>돌봄 공간 사진</h3>
            <input type="file" name="sitter_house1"><br>
            <input type="file" name="sitter_house2"><br>
            <input type="file" name="sitter_house3"><br>
         </div>   
<!--------------------------------------------------------------------------->      
         <div class="license">
         <h3>보유 자격증</h3>
         자격증1 : <input type="text" name="sitter_license_name1">
         발급기관 : <input type="text" name="sitter_license_auth1">
         취득일자 : <input type="date" name="sitter_license_date1">
         파일추가 : <input type="file" name="sitter_license_photo1"><br>
         
         자격증2 : <input type="text" name="sitter_license_name2">
         발급기관 : <input type="text" name="sitter_license_auth2">
         취득일자 : <input type="date" name="sitter_license_date2">
         파일추가 : <input type="file" name="sitter_license_photo2"><br>
         
         자격증3 : <input type="text" name="sitter_license_name3">
         발급기관 : <input type="text" name="sitter_license_auth3">
         취득일자 : <input type="date" name="sitter_license_date3">
         파일추가 : <input type="file" name="sitter_license_photo3"><br>
         </div>
<!--------------------------------------------------------------------------->
         <div class="pay">
         <h3>돌봄 금액</h3>
         1시간 : <input type="text" name="sitter_price_half">원<br>
         종일 : <input type="text" name="sitter_price_full">원 <!-- 6/29 -->
         </div>      
<!--------------------------------------------------------------------------->      
         <div class="note">
         <h3>돌봄 특이사항</h3>
         가능합니다 : <input type="text" name="sitter_can" placeholder="내용을 입력해주세요"><br>
         어렵습니다 : <input type="text" name="sitter_cant" placeholder="내용을 입력해주세요"><br>
         </div><br>
<!--------------------------------------------------------------------------->         
         <input type="button" value="제출하기" onclick="send(this.form);">
      </form>
<!-- 6/29  -->      
<!-- 시간 -->      
      <script>
			flatpickr(document.getElementById("sitter_start_time"), {
	            enableTime: true,
	            noCalendar: true,
	            dateFormat: "H:i",
	            time_24hr: true,
	            locale: "ko"
	        });
			
			flatpickr(document.getElementById("sitter_end_time"), {
	            enableTime: true,
	            noCalendar: true,
	            dateFormat: "H:i",
	            time_24hr: true,
	            locale: "ko"
	        });
		</script>
      
      </main>
      
   <!-- footer jsp -->
   <%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
      
      
   </body>

</html>