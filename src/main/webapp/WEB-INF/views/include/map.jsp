<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<!-- 본인 appkey javascript  -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0764536504d016798367cf2283191f94"></script> 
		
		<script type="text/javascript">
        	document.cookie = 'cookie2=value2; SameSite=None; Secure';
			function getCoordinates(address){
				//var address = document.getElementById('address').value;
				var apiUrl = 'https://dapi.kakao.com/v2/local/search/address.json?query=' + encodeURIComponent(address);
				
				fetch(apiUrl, {
					method: 'get',
					headers: {'Authorization': 'KakaoAK 8a6e6d0b2f7c2506edab2bca562cb69a'} /*본인 REST API 키 */
				})
				.then(response => response.json())
				.then(data => {
					if(data.documents.length > 0){
						console.log(data);
						var location = data.documents[0];
						//var coordinates = '위도: ' + location.y + ',경도: ' + location.x;
						//document.getElementById("result").innerHTML = coordinates;
						
						//지도 중심을 검색된 위치로 이동
						var mapContainer = document.getElementById('map');
						var mapOption = {
								center: new kakao.maps.LatLng(location.y, location.x),
								level: 3
						};
						var map = new kakao.maps.Map(mapContainer, mapOption);
						
						//마커 생성
						var markerPosition = new kakao.maps.LatLng(location.y, location.x);
						var marker = new kakao.maps.Marker({
							position: markerPosition
						});
						marker.setMap(map);
					}else {
						console.log('주소를 찾을 수 없습니다');
					}
				})
				.catch(error => console.error('Error: ', error));
			}
		</script>
	</head>
	
	<body>
		<!-- <div id="result"></div> -->
		<div id="map" style="width:350px; height:350px;"></div>
	</body>
</html>