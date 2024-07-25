<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

	<head>
	<meta charset="utf-8" />
	<title>Service</title>
	
	<!-- 폰트 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
		
		<!-- 폰트2 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
	
	<meta name="viewport"
		content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
	<link rel="stylesheet" href="/project/resources/css/service.css">
	
	</head>

<body>

	<jsp:include page="/WEB-INF/views/include/login_session.jsp" />
	<!-- 헤더 include  -->
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<main>
	
	<div id="swiper_box">
	<swiper-container class="mySwiper" slides-per-view="1"
		space-between="10" pagination="true" pagination-type="bullets"
		navigation="true"> 
		
	
	<swiper-slide>
	<p> <img style="width: 50px; height: 50px;" src="/project/resources/image/산책아이콘.png"> 
	강아지 산책 <span class="service_type">서비스</span>
	</p>
	
			<div class="main_image">
				<img src="/project/resources/image/산책서비스.png">
			</div>
			
	<div class="content">
		<div class="content-start">
		여러분들은 강아지 산책의 중요성에 대해서 알고 계신가요?
		</div>
		
		<br>
		
		<div class="content-main">
		산책은 아이들의 정서적인 문제에 굉장히 큰 영향을 끼칩니다.<br>
		산책을 하지 못하는 아이들은 집 내부에서만 활동을 하여 에너지를 소모하지 못하기때문에<br>
		말썽을 부린다거나, 공격적인 성향이 생길수도 있는데요.<br>
		그렇기 때문에 최소 하루에 한번 30분 ~ 1시간 산책을 해주는게 가장 좋습니다.<br>
		대형견은 견종에 따라 다르지만 보통 2시간가량 해야 한다고 해요.<br>
		강아지 산책! 활동량을 100% 채워준다면 정말 좋겠지만 현실적으로 그럴 수 없으니
		하루에 30분에서 한시간이라도 걷고,<br> 
		흙을 밟고 냄새를 맡는다면 아이들은 너무 좋아할거에요.<br>
		하지만 여러가지의 이유로 너무나 사랑하는 내 아이를 위해 함께 나가줄 수 없는 여러분들을 위해 
		돌봐줄개 가 함께 하겠습니다.
		</div>

	</div>
	</swiper-slide> 
	
	
	<swiper-slide>
	<p><img style="width: 50px; height: 50px;" src="/project/resources/image/돌봄아이콘.png"> 
	강아지 돌봄 <span class="service_type">서비스</span> 
	</p>
			<div class="main_image">
				<img src="/project/resources/image/돌봄.png">
			</div>
			
	<div class="content">
	
		<div class="content-start">
		혹시 강아지가 산책을 갈 수 없는 상황인가요?
		</div>
		
		<br>
		
		<div class="content-main">
		돌봐줄개 에서 제공하는 맞춤 돌봄 서비스를 소개합니다. <br>
		비가 오거나 강아지가 외출할 수 없는 상황이라면 저희 서비스를 이용해보세요!<br>
		비 오는 날에는 산책 대신 다양한 실내 놀이 활동을 통해 강아지의 정신적 자극을 주고,<br> 
		즐거운 시간을 보낼 수 있도록 합니다. <br>
		노령견이나 격한 활동이 어려운 강아지들도 걱정하지 마세요.<br> 
		전문 펫시터가 아이들의 컨디션에 맞게 활동을 조절하여 안전하고 즐겁게 돌봐드립니다.<br>
		돌봐줄개와 함께라면 어떤 상황에서도 강아지의 건강과 행복을 챙길 수 있습니다.
		</div>
		
	</div>	
	
	</swiper-slide> 
	
	
	<swiper-slide>
		<p><img style="width: 50px; height: 50px;" src="/project/resources/image/케어아이콘.png"> 
		강아지 케어 <span class="service_type">서비스</span> 
		</p>
			<div class="main_image">
				<img src="/project/resources/image/훈련.png">
			</div>
			
	<div class="content">
		<div class="content-start">
		여러 전문 펫시터님들의 강아지 케어!
		</div>
		
		<br>
		
		<div class="content-main">
		저희 펫시터님들은 다양한 자격증을 보유하고 있습니다.<br>
		여러분들의 소중한 강아지의 미용과 훈련을 믿고 맡기실 수 있습니다. <br>
		전문 미용사는 강아지의 털을 건강하게 유지하고, 귀와 발톱 관리도 철저히 합니다. <br>
		또한 훈련사는 강아지의 사회성 발달을 돕고, 기본 명령어 훈련을 통해 올바른 행동 습관을 길러줍니다.<br>
		픽업 서비스부터 돌봄, 케어까지 원하시는 서비스를 선택해보세요. <br>
		소중한 우리 아이, '돌봐줄개'와 함께 더욱 소중하게 돌봐드리겠습니다.
		</div>
	</div>
	</swiper-slide> 
	
	</swiper-container>


	<div class="bot-service">
		<div class="banner" id="serviceButtons"></div>
	</div>


	</div>
	<div class="reservation_btn">
		<input class="send_btn" type="button" value="예약하기" onclick="location.href='findSitter.do'">
	</div>
	

	<script
		src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-element-bundle.min.js"></script>
	<!-- <script>
    const swiperEl = document.querySelector('swiper-container');
    const swiper = swiperEl.swiper;
    
    
    const serviceButtons = document.getElementById('serviceButtons');
    
    swiper.on('slideChange', function () {
        updateButtons(swiper.activeIndex);
      });

      function updateButtons(index) {
        serviceButtons.innerHTML = '';

        if (index === 0) {
          serviceButtons.innerHTML = `
            <input class="send_btn" type="button" value="산책 예약">
            
          `;
        } else if (index === 1) {
          serviceButtons.innerHTML = `
            <input class="send_btn" type="button" value="돌봄 예약">
            
          `;
        } else if (index === 2) {
          serviceButtons.innerHTML = `
            <input class="send_btn" type="button" value="케어 예약">
            
          `;
        }
      }

      // 초기 버튼 설정
      updateButtons(swiper.activeIndex);
    
  </script> -->


</main>

</body>

</html>