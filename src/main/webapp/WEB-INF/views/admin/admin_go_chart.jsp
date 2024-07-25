<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f0f2f5;
    margin: 0;
    padding: 0;
}

.chart-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    padding: 20px;
}

.chart-box {
    flex: 0 1 calc(25% - 20px); /* 한 줄에 4개가 배치되도록 설정 */
    height: 350px; /* 높이를 더 늘림 */
    border: 1px solid #ddd;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    background-color: #fff;
    box-sizing: border-box; /* 패딩과 보더를 포함하여 크기를 계산 */
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
    transition: transform 0.2s, box-shadow 0.2s;
}

.chart-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.chart-box canvas {
    width: 100%; /* 크기를 약간 줄여서 여백 확보 */
    height: 100%;
}

/* Large screens */
@media (max-width: 1200px) {
    .chart-box {
        flex: 0 1 calc(33.33% - 20px); /* 한 줄에 3개가 배치되도록 설정 */
        height: 350px; /* 높이를 더 늘림 */
    }
}

/* Medium screens */
@media (max-width: 992px) {
    .chart-box {
        flex: 0 1 calc(50% - 20px); /* 한 줄에 2개가 배치되도록 설정 */
        height: 300px; /* 높이를 더 늘림 */
    }
}

/* Small screens */
@media (max-width: 768px) {
    .chart-box {
        flex: 0 1 calc(100% - 20px); /* 한 줄에 1개가 배치되도록 설정 */
        height: 300px; /* 높이를 더 늘림 */
    }
}

/* Extra small screens */
@media (max-width: 576px) {
    .chart-box {
        flex: 0 1 calc(100% - 10px); /* 한 줄에 1개가 배치되도록 설정 */
        height: 250px; /* 높이를 더 늘림 */
    }
}

/* Very small screens */
@media (max-width: 400px) {
    .chart-box {
        flex: 0 1 calc(100% - 10px); /* 한 줄에 1개가 배치되도록 설정 */
        height: 200px; /* 높이를 더 늘림 */
    }
}
</style>
</head>
<body>

	<div class="chart-container">
		<div class="chart-box">
			<canvas id="genderChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="dayChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="typeChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="ageChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="locationChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="dogSizeChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="houseChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="licenseChart"></canvas>
		</div>
	</div>



	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<!-- 성별 시작 -->
	<script>

		let genderCtx = document.getElementById('genderChart').getContext('2d');
		let genderChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (genderChartInstance) {
        	genderChartInstance.destroy();
        }
		
        genderChartInstance = new Chart(genderCtx, {
			type : 'pie',
			data : {
				labels : [ '남자', '여자' ],
				datasets : [ {
					label : '가입자 성별 수',
					data : [ '${findMan}', '${findWomen}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '남자 여자 비율',
			                color: 'black'
		                }
		            }
		        }
		    });
	</script>
	<!-- 성별 시작 -->

	<!-- 일 별 가입자 수 그래프 시작 -->
	<script>
	function getLastFiveDays() {
		const dates = [];
		const today = new Date();
		for (let i = 0; i < 5; i++) {
			const date = new Date(today);
			date.setDate(today.getDate() - i);
			const year = date.getFullYear().toString().slice(2);
			const month = ('0' + (date.getMonth() + 1)).slice(-2); // 두 자리로 맞추기
			const day = ('0' + date.getDate()).slice(-2); // 두 자리로 맞추기
			const formattedDate = year + month + day;
			dates.push(formattedDate);
		}
		return dates.reverse(); // 배열을 뒤집어서 과거에서 현재로 정렬
	}

		let fiveDays = getLastFiveDays();
	</script>
	
	<script>

		let daysCtx = document.getElementById('dayChart').getContext('2d');
		let daysChartInstance;
	
		 // 기존 차트가 있으면 파기
        if (daysChartInstance) {
        	daysChartInstance.destroy();
        }
		
        daysChartInstance = new Chart(daysCtx, {
			type : 'line',
			data : {
				labels : fiveDays,
				datasets : [ {
					label : '일별 가입자 수',
					data : [ '${day5}', '${day3}', '${day3}',
							'${day2}', '${day1}' ],
					borderWidth : 1
				} ]
			},
			options : {
				plugins: {
		            title: {
		                display: true,
		                text: '최근 5일간 일별 가입자 수',
		                color: 'black'
		            }
		        },
				scales : {
					y : {
						beginAtZero : true,
						ticks:{
							stepSize: 1
						}	
					}
				}
			}
		});
	</script>
	<!-- 일 별 가입자 수 그래프 끝 -->

	<!-- 이용자/제공자 비교 시작 -->
	<script>

		let typeCtx = document.getElementById('typeChart').getContext('2d');
		let typeChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (typeChartInstance) {
        	typeChartInstance.destroy();
        }
		
        typeChartInstance = new Chart(typeCtx, {
			type : 'pie',
			data : {
				labels : [ '이용자', '제공자' ],
				datasets : [ {
					label : '이용자, 제공자 수 비교',
					data : [ '${user}', '${provider}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '이용자 제공자 비율',
			                color: 'black'
		                }
		            }
		        }
		    });
	</script>
	<!-- 이용자/제공자 비교 끝 -->
	
	<!-- 나이 비교 시작 -->
		<script>

		let ageCtx = document.getElementById('ageChart').getContext('2d');
		let ageChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (ageChartInstance) {
        	ageChartInstance.destroy();
        }
		
        ageChartInstance = new Chart(ageCtx, {
			type : 'bar',
			data : {
				labels : [ '10대', '20대', '30대', '40대', '50대'],
				datasets : [ {
					label : '가입자 나이 비교',
					data : [ '${age1}', '${age2}', '${age3}', '${age4}', '${age5}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '가입자 나이대',
			                color: 'black'
		                }
		                
		            }
		        }
		    });
	</script>
	<!-- 나이 비교 끝 -->
 
 	<!-- 지역 비교 시작 -->
 	<script>

		let locaitonCtx = document.getElementById('locationChart').getContext('2d');
		let locaitonChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (locaitonChartInstance) {
        	locaitonChartInstance.destroy();
        }
		
        locaitonChartInstance = new Chart(locaitonCtx, {
			type : 'doughnut',
			data : {
				labels : [ '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', 
			        '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주'],
				datasets : [ {
					label : '가입자 지역 비교',
					data : [ '${location1}', '${location2}', '${location3}', '${location4}', '${location5}', '${location6}', '${location7}'
						, '${location8}' , '${location9}' , '${location10}' , '${location11}' , '${location12}' , '${location13}'
						, '${location14}' , '${location15}' , '${location16}' , '${location17}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '가입자 지역',
			                color: 'black'
		                }
		            }
		        }
		    });
	</script>
 	<!-- 지역 끝 -->
 	
 		<!-- 케어 가능 연령 시작 -->
		<script>

		let dogSizeCtx = document.getElementById('dogSizeChart').getContext('2d');
		let dogSizeChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (dogSizeChartInstance) {
        	dogSizeChartInstance.destroy();
        }
		
        dogSizeChartInstance = new Chart(dogSizeCtx, {
			type : 'pie',
			data : {
				labels : [ '소형견', '중형견', '대형견' ],
				datasets : [ {
					label : '케어 가능 사이즈',
					data : [ '${small}', '${medium}', '${large}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '케어 가능 사이즈',
			                color: 'black'
		                }
		                
		            }
		        }
		    });
	</script>
	<!-- 케어 가능 연령 끝 -->
	
 		<!-- 시터 거주 환경 시작 -->
		<script>

		let houseCtx = document.getElementById('houseChart').getContext('2d');
		let houseChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (houseChartInstance) {
        	houseChartInstance.destroy();
        }
		
        houseChartInstance = new Chart(houseCtx, {
			type : 'bar',
			data : {
				labels : [ '단독주택', '빌라', '아파트', '오피스텔', '원룸' ],
				datasets : [ {
					label : '케어 환경',
					data : [ '${place1}', '${place2}', '${place3}', '${place4}', '${place5}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '케어 환경',
			                color: 'black'
		                }
		                
		            },
		            scales : {
						y : {
							beginAtZero : true,
							ticks:{
								stepSize: 1
							}	
						}
					}
		        }
		    });
	</script>
	<!-- 시터 거주 환경 끝 -->
	
	<!-- 자격증 개수 시작 -->
		<script>

		let licenseCtx = document.getElementById('licenseChart').getContext('2d');
		let licenseChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (licenseChartInstance) {
        	licenseChartInstance.destroy();
        }
		
        licenseChartInstance = new Chart(licenseCtx, {
			type : 'bar',
			data : {
				labels : [ '0개', '1개', '2개', '3개' ],
				datasets : [ {
					label : '시터별 자격증 소유 개수',
					data : [ '${license0}', '${license1}', '${license2}', '${license3}' ],
					borderWidth : 1
				} ]
			},
			   options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    display: true,
		                    position: 'top'
		                },
		                tooltip: {
		                    enabled: true
		                },
		                title: {
		                	display: true,
		                	text: '시터별 자격증 소유 개수',
			                color: 'black'
		                }
		                
		            },
		            scales : {
						y : {
							beginAtZero : true,
							ticks:{
								stepSize: 1
							}	
						}
					}
		        }
		    });
       
	</script>
	<!-- 자격증 개수 끝 -->
	
	
	
</body>
</html>