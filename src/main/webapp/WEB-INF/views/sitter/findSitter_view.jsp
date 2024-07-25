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
    	<link rel="stylesheet" href="/project/resources/css/sitter/findSitter_view.css">
		
		
		<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
   		
		
   		
   		
   		<script>

			let images = [];
			let currentIndex = 0;
			let inerval;
			let isCheck = false;
   		
			function initialize() {
			    let address = "${user_address}"; /* users테이블에서 가져온 주소 */
			    console.log(address);
			    getCoordinates(address);
			    initImage();
			    interval = setInterval(next, 1000);
			}

			window.addEventListener('load', initialize); /* reserve_form의 스크립트와 충돌 방지 */
   			
   			function initImage(){
   				let house1Name = "${vo.house1_name}";
   				let house2Name = "${vo.house2_name}";
   				let house3Name = "${vo.house3_name}";
   				
   				if(house1Name != null && house1Name != '') images.push(house1Name);
   				if(house2Name != null && house2Name != '') images.push(house2Name);
   				if(house3Name != null && house3Name != '') images.push(house3Name);
   				
   				console.log("이미지이름 : " + "${vo.house1_name}");
   				console.log("이미지1이름 : " + house1Name);
   				console.log("이미지2이름 : " + house2Name);
   				console.log("이미지3이름 : " + house3Name);
   				console.log("배열크기 : " + images.length);
   				
   				if(images.length > 0){
   					document.getElementById("gallery").src = "/project/resources/upload/" + images[0];
   				}else{
   					console.log("no image"); 
   					//추후 이미지없음 사진 추가
   					//document.getElementById("gallery").src = "/project/resources/upload/이미지없음.jsp";
   				}
   			}
   			
   			function next(){
   				currentIndex++;
   				if(currentIndex >= images.length){
   					currentIndex = 0;
   				}
   				document.getElementById("gallery").src = "/project/resources/upload/" + images[currentIndex];
   			}
   			
   			function prev(){
   				currentIndex--;
   				if(currentIndex < 0){
   					currentIndex = images.length - 1;
   				}
   				document.getElementById("gallery").src = "/project/resources/upload/" + images[currentIndex];
   			}
   			
   			
   			function slideOnOff(){
   				if(isCheck){
   					interval = setInterval("next()", 1000);
   					isCheck = false;
   				}else{
   					clearInterval(interval);
   					isCheck = true;
   				}
   			}
   			
   	//7/8			
   			//즐겨찾기
   			function fav(sitter_idx){
   				let url = "favoriteInsert.do";
				let param = "sitter_idx=" + sitter_idx;
				
				sendRequest(url, param, favFn, "post");
   			}
   			function favFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('즐겨찾기 추가 완료');
					}else{
						alert('즐겨찾기 목록에 존재하는 댕시터입니다');
					}
				}
			}
   			
   		</script>
	</head>
	
	<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"/> <!-- 헤더 -->
		
		<main>
	 	<div id="main_form">
       <div class="sitter_container">
          <input type="hidden" name="sitter_idx" value="${vo.sitter_idx }"> <!-- 시터테이블의 sitter_idx  -->
          
          <div id="gallerywrap">
         <a href="#" onclick="prev();"> <!--img태그에 href 안먹을까봐 a태그로 분리-->
            <img id="btn" style="width:30px; height: 40px; " src="/project/resources/image/왼쪽화살표아이콘.png" alt="이전">
         </a>
         
         <img src="/project/resources/upload/${vo.house1_name }" id="gallery" onclick="slideOnOff();" width="500">
         
         <a href="#" onclick="next();">
            <img id="btn" style="width:30px; height: 40px; " src="/project/resources/image/오른쪽화살표아이콘.png" alt="다음">
         </a>
      </div>
	 		
	 		<%-- <div class="sitter_photo">
<!-- 7/1 width -->	
			
	 			<img src="/project/resources/upload/${vo.house1_name }" width="500">
	 		</div> --%>
	 		<div class="sitter_info">
          <h2 class="siter_title" >${vo.sitter_title }</h2>
          
          <div class="user_name">${vo.user_name } &nbsp; ${vo.sitter_city },${vo.sitter_district }</div>
          <div class="service">
            <p class="tag">${vo.sitter_care }</p>  
	 		<p class="tag">${vo.sitter_pickup }</p> 
	 		<p class="tag">${vo.sitter_bath }</p>  
	 		<p class="tag">${vo.sitter_olddog }</p>
	 		<p class="tag">${vo.sitter_walk }</p>  
	      </div>
          <div><input type="button" value="즐겨찾기" onclick="fav('${vo.sitter_idx }')"></div>
       
       </div>
       
       </div>
       
          <hr class="sitter_hr">
          <br>
          
          
          <div class="sitter_field_container">
          <div class="sitter_field">
          
          <!-- 돌봄 가능 반려견 크기 -->
          <div class="dog">
          <h3><img style="width: 30px; height: 30px;" src="/project/resources/image/강아지아이콘.png"> 돌봄 가능 반려견 크기</h3>
          <p style="font-family: Nanum Gothic;">&#8226; ${vo.sitter_small } &nbsp; ${vo.sitter_medium } &nbsp; ${vo.sitter_large }</p>
          </div>
          <!-- &#8226; : 특수문자 기호(검정 동그라미) https://copypastecharacter.com/-->
          
          <!-- 돌봄 환경 -->
          <div class="care">
          <h3><img style="width: 30px; height: 30px;" src="/project/resources/image/집아이콘.png"> 돌봄 환경</h3>
          <div class="care_box">
          <div >&#8226; 돌봄공간</div>  <div>${vo.sitter_house }</div>
          </div>
          
          <div class="care_box2">
          <div>&#8226; 돌봄가능 반려견 수</div>  <div>${vo.sitter_dogcount }</div>
          </div>
          
          <div class="care_box">
          <div>&#8226; 12세 이하 아동</div>  <div>${vo.sitter_kid }</div>
          </div>
          
          <div class="care_box2">
          <div>&#8226; 동거 반려동물</div>  <div>${vo.sitter_pet }</div>
          </div>
          
          <div class="care_box">
          <div>&#8226; 홈 시큐리티 카메라</div>  <div>${vo.sitter_homecam }</div>
          </div>
          
          <div class="care_box2">
          <div>&#8226; 반려견 펜스</div> <div>${vo.sitter_fence }</div>
          </div>
          
          
          <!-- 돌봄시간 -->
          <div class="care_time">
          	<h3><img style="width: 30px; height: 30px;" src="/project/resources/image/시계아이콘.png"> 돌봄 시간</h3>
          
          <div class="start_end">
          	<div>&#8226; 돌봄 시작</div>  <div>${vo.sitter_start_time }</div>
          </div>
          
          <div class="start_end2">
          	<div>&#8226; 돌봄 마무리</div>  <div>${vo.sitter_end_time }</div>
          </div>
          
          </div>
          
          
          <!-- 이용 금액 -->
          <div class="care_pay">
          <h3><img style="width: 30px; height: 30px;" src="/project/resources/image/돈아이콘.png"> 돌봄 금액</h3>
          
          <div  class="care_tm">
          <div>&#8226; 1시간</div> <div>${vo.sitter_price_half }</div>
          </div>
		  <div  class="care_tm2">          
          <div>&#8226; 종일</div> <div>${vo.sitter_price_full }</div>
          </div>
          
          </div>
          
          
          <!-- 돌봄 특이사항 -->
          <div class="care_note">
          <h3><img style="width: 30px; height: 30px;" src="/project/resources/image/노트아이콘.png"> 돌봄 특이사항</h3>
          
          <div class="note">
          <div>&#8226; 가능합니다</div> <div>${vo.sitter_can }</div>
          </div>
          
          <div class="note2">
          <div>&#8226; 어렵습니다</div> <div>${vo.sitter_cant }</div>
          </div>
          </div>
          
          </div>
          </div>
          
          <hr class="sitter_hr"><br>
          
          <h3><img style="width: 32px; height: 32px; margin-top: 5px;" src="/project/resources/image/자기소개아이콘.png"> 소개글</h3>
          
          <!-- 소개 글 -->
          
          <div class="content">
          <div class="content_div">${vo.sitter_introduce }</div>
          </div>


		  <br><hr class="sitter_hr"><br>

		  
		  <!-- 보유 자격증 -->
		  <div class="license_container">         
          <h3><img style="width: 30px; height: 30px;" src="/project/resources/image/자격증아이콘.png"> 보유 자격증</h3>
          <c:if test="${vo.sitter_license_name1 != null && vo.sitter_license_name1 != ''}">
             <div><img src="/project/resources/upload/${vo.license_photo1_name }" width="300"></div>
             
             <div class="license">
             <div>&#8226; 자격증 이름</div> <div>${vo.sitter_license_name1 }</div>
             </div>
             
             <div class="license2">
             <div>&#8226; 발급기관</div> <div>${vo.sitter_license_auth1 }</div>
             </div>
             
             <div class="license">
             <div>&#8226; 취득일자</div> <div>${vo.sitter_license_date1 }</div>
          	 </div>
          </c:if>
          
          <c:if test="${vo.sitter_license_name2 != null && vo.sitter_license_name2 != ''}">
             <div><img src="/project/resources/upload/${vo.license_photo2_name }" width="300"></div>
             <div class="license">
             <div>&#8226; 자격증 이름</div> <div>${vo.sitter_license_name1 }</div>
             </div>
             
             <div class="license2">
             <div>&#8226; 발급기관</div> <div>${vo.sitter_license_auth1 }</div>
             </div>
             
             <div class="license">
             <div>&#8226; 취득일자</div> <div>${vo.sitter_license_date1 }</div>
          	 </div>
          </c:if>
          
          
          <c:if test="${vo.sitter_license_name3 != null && vo.sitter_license_name3 != ''}">
             <div><img src="/project/resources/upload/${vo.license_photo3_name }" width="300"></div>
             <div class="license">
             <div>&#8226; 자격증 이름</div> <div>${vo.sitter_license_name1 }</div>
             </div>
             
             <div class="license2">
             <div>&#8226; 발급기관</div> <div>${vo.sitter_license_auth1 }</div>
             </div>
             
             <div class="license">
             <div>&#8226; 취득일자</div> <div>${vo.sitter_license_date1 }</div>
          	 </div>
          </c:if>
          </div>
          
          <hr class="sitter_hr"> <br>
		  
		  
		  <!-- 지도 -->          
          <h3><img style="width: 30px; height: 30px;" src="/project/resources/image/지도아이콘.png"> 댕시터 위치</h3>
          <div><jsp:include page="/WEB-INF/views/include/map.jsp"/></div>
          
          
       </div>
       </div>
	 		
<!-- 예약창 -->	 		
	 		<div class="reserve"><jsp:include page="/WEB-INF/views/include/reserve_form.jsp"/></div>
	 		
	 	</div>
	 	</main>
	</body>
</html>