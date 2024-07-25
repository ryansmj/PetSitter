<%@page import="vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <link rel="stylesheet" href="/project/resources/css/sitter/sitter_form.css">
</head>
<body>
<head>
<!-- 폰트 -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link
   href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap"
   rel="stylesheet">
      <meta charset="UTF-8">
      <title>댕시터 지원하기</title>
      <script src="/project/resources/js/httpRequest.js"></script>
<style>
.popup {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
}

.popup-content {
    background-color: white;
    padding: 20px;
    border-radius: 5px;
    text-align: center;
    width: 500px; /* 팝업 창의 너비를 늘림 */
    height: 350px; /* 팝업 창의 높이를 늘림 */
}

#refuseReason {
    width: 100%;
    height: 200px; /* 높이를 조절하여 입력 칸의 크기를 키움 */
    padding: 10px;
    margin: 10px 0;
    box-sizing: border-box;
    resize: none; /* 입력 칸 크기 조절을 못하게 함 */
}

button {
    padding: 10px 20px;
    margin: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

#confirmButton {
    background-color: #4CAF50;
    color: white;
}


.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}


</style>
            
<style>
.service-container {
   display: flex;
   width: 600px;
   border: 1px solid black;
   border-radius: 10px;
   padding: 5px 10px;
   background-color: white;
}

.service-container input {
   flex-direction: row;
   justify-content: center;
   margin: 0 0 0 10px;
}

.schedule {
   display: flex;
   flex-direction: row;
   margin: 0 auto;
   gap: 10px;
}

.hour-cell, .minute-cell {
   width: 50px;
   border: 1px solid black;
   cursor: poniter;
   position: relative;
   display: flex;
   flex-direction: column;
}

.hour-list, .minute-list {
   display: none;
   position: absolute;
   background: #fff;
   border: 1px solid #ccc;
   max-height: 200px;
   overflow-y: auto;
   z-index: 10;
}

.hour-list div, .minute-list div {
   cursor: pointer;
}

.hour-list div, .minute-list div:hover {
   background-color: #f0f0f0;
}
</style>

<script>
   function modify(f) {
      let user_idx = document.getElementById("user_idx").value;
      location.href = "myPage_sitterFormUpdate.do?user_idx=" + user_idx
   }
</script>

<script>
   function confirms() {
      let user_idx = document.getElementById("user_idx").value;
      alert(user_idx);
      location.href="adminSitterFormConfirm.do?user_idx=" + user_idx;
   }
   
   function reason(){
          document.getElementById('popup').style.display = 'flex';
   }
   
   function popupClose(){
       document.getElementById('popup').style.display = 'none';
   }
   
   


</script>

</head>


   <body>
   <jsp:include page="/WEB-INF/views/include/login_session.jsp" />
   <!-- 헤더 include  -->
   <jsp:include page="/WEB-INF/views/include/header.jsp" />
      
      
      <main>
      <form method="post" enctype="multipart/form-data">
         <input type="hidden" name="user_idx" id="user_idx" value="${user.user_idx }">
         <input type="hidden" name="user_name" id="user_name" value="${user.user_name }">
         user-idx : ${user.user_idx }
         user-name : ${user.user_name }
          
         <h1>댕냥시터 지원하기</h1>
         <br><br>
         <div class="title">
         <h3>글 제목</h3>
         <input type="text" name="sitter_title" placeholder="글 제목을 입력하세요" value="${vo.sitter_title}" disabled="disabled">
         </div>
<!--------------------------------------------------------------------------->         
         <div class="address">
         <h3>돌봄 장소</h3>
         지역 : <input type="text" name="sitter_city"
               value="${fn:split( user.user_address, ' ')[0]}"
               style="background-color:#f0f0f0" disabled="disabled"> <br>
         시/군/구 : <input type="text" name="sitter_district"
               value="${fn:split( user.user_address, ' ')[1]}"
               style="background-color:#f0f0f0" disabled="disabled"><br>
         </div>
<!--------------------------------------------------------------------------->            
         <div class="service">
         <h3>가능한 서비스</h3>
         <div class="service-container">
             <label><input disabled="disabled" type="checkbox" name="sitter_care" value="돌봄" 
                   <c:if test="${vo.sitter_care == '돌봄'}">checked</c:if>>돌봄</label>
               <label><input disabled="disabled" type="checkbox" name="sitter_walk" value="산책+실외배변" 
                   <c:if test="${vo.sitter_walk == '산책+실외배변'}">checked</c:if>>산책+실외배변</label>
               <label><input disabled="disabled" type="checkbox" name="sitter_pickup" value="픽업" 
                   <c:if test="${vo.sitter_pickup == '픽업'}">checked</c:if>>픽업</label>
               <label><input disabled="disabled" type="checkbox" name="sitter_bath" value="목욕" 
                   <c:if test="${vo.sitter_bath == '목욕'}">checked</c:if>>목욕</label>
               <label><input disabled="disabled" type="checkbox" name="sitter_olddog" value="노령견" 
                   <c:if test="${vo.sitter_olddog == '노령견'}">checked</c:if>>노령견</label>
         </div>
         </div>
<!--------------------------------------------------------------------------->            
         <div class="environment">
         <h3>돌봄 환경</h3>
         <div class="house">
         <div>돌봄 공간</div>
         <select name="sitter_house" disabled="disabled">
                <option value="단독주택" <c:if test="${vo.sitter_house == '단독주택'}">selected</c:if>>단독주택</option>
                <option value="빌라" <c:if test="${vo.sitter_house == '빌라'}">selected</c:if>>빌라</option>
                <option value="아파트" <c:if test="${vo.sitter_house == '아파트'}">selected</c:if>>아파트</option>
                <option value="오피스텔" <c:if test="${vo.sitter_house == '오피스텔'}">selected</c:if>>오피스텔</option>
                <option value="원룸" <c:if test="${vo.sitter_house == '원룸'}">selected</c:if>>원룸</option>
         </select>
         </div>
         
         <div class="dogcount">
         <div>돌봄가능 반려견수</div>
         <select name="sitter_dogcount" disabled="disabled">
            <option value="">선택하세요</option>
            <option value="1마리" <c:if test="${vo.sitter_dogcount == '1마리'}">selected</c:if>>1마리</option>
                <option value="2마리" <c:if test="${vo.sitter_dogcount == '2마리'}">selected</c:if>>2마리</option>
                <option value="3마리" <c:if test="${vo.sitter_dogcount == '3마리'}">selected</c:if>>3마리</option>
         </select>
         </div>
         
         <div class="kid">
         <div>12세 이하 아동</div>
         <select name="sitter_kid" disabled="disabled">
            <option value="">선택하세요</option>
            <option value="없음" <c:if test="${vo.sitter_kid == '없음'}">selected</c:if>>없음</option>
                <option value="있음" <c:if test="${vo.sitter_kid == '있음'}">selected</c:if>>있음</option>
         </select>
         </div>
         
         <div class="homecam">
         <div>홈 시큐리티 카메라</div>
         <select name="sitter_homecam" disabled="disabled">
            <option value="">선택하세요</option>
            <option value="없음" <c:if test="${vo.sitter_homecam == '없음'}">selected</c:if>>없음</option>
                <option value="있음" <c:if test="${vo.sitter_homecam == '있음'}">selected</c:if>>있음</option>
         </select>
         </div>
         
         <div class="fence">
         <div>반려견 펜스</div>
         <select name="sitter_fence" disabled="disabled">
            <option value="">선택하세요</option>
            <option value="없음" <c:if test="${vo.sitter_fence == '없음'}">selected</c:if>>없음</option>
                <option value="있음" <c:if test="${vo.sitter_fence == '있음'}">selected</c:if>>있음</option>
         </select>
         </div>
         
         <div class="pet">
         <div>동거 반려동물</div>
         <select name="sitter_pet" disabled="disabled">
            <option value="">선택하세요</option>
                <option value="없음" <c:if test="${vo.sitter_pet == '없음'}">selected</c:if>>없음</option>
                <option value="강아지" <c:if test="${vo.sitter_pet == '강아지'}">selected</c:if>>강아지</option>
                <option value="고양이" <c:if test="${vo.sitter_pet == '고양이'}">selected</c:if>>고양이</option>
         </select>
         </div>
         </div>
<!--------------------------------------------------------------------------->            
         <div class="pet_size">
         <h3>돌봄 가능한 반려견 크기</h3>
            <div class="dogsize">
            <input disabled="disabled" type="checkbox" name="sitter_small" value="소형견" 
                    <c:if test="${vo.sitter_small == '소형견'}">checked</c:if>>소형견(15kg 미만)
                <input disabled="disabled" type="checkbox" name="sitter_medium" value="중형견" 
                    <c:if test="${vo.sitter_medium == '중형견'}">checked</c:if>>중형견(15kg~30kg 미만)
                <input disabled="disabled" type="checkbox" name="sitter_large" value="대형견" 
                    <c:if test="${vo.sitter_large == '대형견'}">checked</c:if>>대형견(30kg 이상)
            </div>
         </div>
<!--------------------------------------------------------------------------->
         <div class="pet_time">
         <div>돌봄 가능 시간</div>
            <input disabled="disabled" type="time" name="sitter_start_time" value="${vo.sitter_start_time}"> 부터 ~
            <input disabled="disabled" type="time" name="sitter_end_time" value="${vo.sitter_end_time}"> 까지
         </div>
<!--------------------------------------------------------------------------->   
         <div class="introduce">
         <h3>소개글</h3>
            <textarea name="sitter_introduce" rows="10" cols="50"
               style="resize:none" wrap="on" disabled="disabled">${vo.sitter_introduce}</textarea>
         </div>         
<!--------------------------------------------------------------------------->      
         <div class="photo">
         <h3>돌봄 공간 사진</h3>
               <c:if test="${not empty vo.house1_name}">
                  <div>
                     <span>현재 파일: ${vo.house1_name}</span><br>
                     <input type="file" name="sitter_house1" disabled="disabled"><br>
                  </div>
               </c:if>
               <c:if test="${empty vo.house1_name}">
                  <input type="file" name="sitter_house1" disabled="disabled">
                  <br>
               </c:if>

               <c:if test="${not empty vo.house2_name}">
                  <div>
                     <span>현재 파일: ${vo.house2_name}</span><br>
                     <input type="file" name="sitter_house2" disabled="disabled"><br>
                  </div>
               </c:if>
               <c:if test="${empty vo.house2_name}">
                  <input type="file" name="sitter_house2" disabled="disabled">
                  <br>
               </c:if>

               <c:if test="${not empty vo.house3_name}">
                  <div>
                     <span>현재 파일: ${vo.house3_name}</span><br>
                     <input type="file" name="sitter_house3" disabled="disabled"><br>
                  </div>
               </c:if>
               <c:if test="${empty vo.house3_name}">
                  <input type="file" name="sitter_house3" disabled="disabled">
                  <br>
               </c:if>
            </div>   
<!--------------------------------------------------------------------------->      
         <div class="license">
         <h3>보유 자격증</h3>
         자격증1 : <input name="sitter_license_name1" value="${vo.sitter_license_name1}" disabled="disabled">
         발급기관 : <input name="sitter_license_auth1" value="${vo.sitter_license_auth1}" disabled="disabled">
         취득일자 : <input type="date" name="sitter_license_date1" value="${vo.sitter_license_date1}" disabled="disabled">
               <c:if test="${not empty vo.license_photo1_name}">
                   <div>
                       <span>현재 파일: ${vo.license_photo1_name}</span><br>
               파일추가 : <input type="file" name="sitter_license_photo1" disabled="disabled"><br>
                   </div>
               </c:if>
               <c:if test="${empty vo.license_photo1_name}">
           파일추가 :<input type="file" name="sitter_license_photo1" disabled="disabled"><br>
               </c:if>
         
         자격증2 : <input name="sitter_license_name2" value="${vo.sitter_license_name2}" disabled="disabled">
         발급기관 : <input name="sitter_license_auth2" value="${vo.sitter_license_auth2}" disabled="disabled">
         취득일자 : <input type="date" name="sitter_license_date2" value="${vo.sitter_license_date2}" disabled="disabled">
             <c:if test="${not empty vo.license_photo2_name}">
                   <div>
                       <span>현재 파일: ${vo.license_photo2_name}</span><br>
                      파일추가 : <input type="file" name="sitter_license_photo2" disabled="disabled"><br>
                   </div>
               </c:if>
               <c:if test="${empty vo.license_photo2_name}">
               파일추가 : <input type="file" name="sitter_license_photo2" disabled="disabled"><br>
               </c:if>
         
         자격증3 : <input name="sitter_license_name3" value="${vo.sitter_license_name3}" disabled="disabled">
         발급기관 : <input name="sitter_license_auth3" value="${vo.sitter_license_auth3}" disabled="disabled">
         취득일자 : <input type="date" name="sitter_license_date3" value="${vo.sitter_license_date3}" disabled="disabled">
            <c:if test="${not empty vo.license_photo3_name}">
                   <div>
                       <span>현재 파일: ${vo.license_photo3_name}</span><br>
                   파일추가 : <input type="file" name="sitter_license_photo3" disabled="disabled"><br>
                   </div>
               </c:if>
               <c:if test="${empty vo.license_photo3_name}">
               파일추가 : <input type="file" name="sitter_license_photo3" disabled="disabled"><br>
               </c:if>
         </div>
<!--------------------------------------------------------------------------->
         <div class="pay">
         <h3>돌봄 금액</h3>
         30분 : <input name="sitter_price_half" value="${vo.sitter_price_half}" disabled="disabled">원<br>
         1일 (24시간) : <input name="sitter_price_full" value="${vo.sitter_price_full}" disabled="disabled">원
         </div>      
<!--------------------------------------------------------------------------->      
         <div class="note">
         <h3>돌봄 특이사항</h3>
         가능합니다 : <input name="sitter_can" placeholder="내용을 입력해주세요" value="${vo.sitter_can}" disabled="disabled"><br>
         어렵습니다 : <input name="sitter_cant" placeholder="내용을 입력해주세요" value="${vo.sitter_cant}" disabled="disabled"><br>
         </div>
         <br>
<!--------------------------------------------------------------------------->         
         <!-- 7/8추가 -->
         <input id="modifyBtn" type="button" value="수정하기" onclick="modify(this.form);">
         <c:if test="${vo.sitterApproval_status != '승인완료'}">
            <c:if test="${appvo.sitterApproval_reason != null}">
               <input id="refuseBtn" type="button" value="반려 사유" onclick="reason();">
               
               <div id="popup" class="popup">
                   <div class="popup-content">
                       <span class="close-btn" id="closePopup">&times;</span>
                       <h2>신청서 반려 사유</h2>
                       <textarea id="refuseReason" name="refuseReason" placeholder="${appvo.sitterApproval_reason}" readonly></textarea>
                       <input type="button" id="confirmButton" value="확인" onclick="popupClose();">
                   </div>
               </div>
            </c:if>
         </c:if>
      </form>
      </main>
   <!-- footer jsp -->
   <jsp:include page="/WEB-INF/views/include/footer.jsp" />
      
</body>


</html>