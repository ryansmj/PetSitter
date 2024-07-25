<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	function admin_payment_search() {
		let admin_payment_search_select = document.getElementById("admin_payment_search_select").value;
		let admin_payment_searchWord = document.getElementById("admin_payment_searchWord").value;
		
		if (admin_payment_search_select === "selectAll") {
			admin_payment_searchWord = null;
		}
		
		if(admin_payment_search_select != "selectAll" && (admin_payment_searchWord === '' || admin_payment_searchWord === null)){
			alert("검색어를 입력하세요");
			return;
		}

		let param = "admin_payment_searchWord=" + admin_payment_searchWord + "&admin_payment_search_select=" + admin_payment_search_select;
		location.href="admin_go_payment.do?" + param;
	}
</script>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

.search-bar {
    margin: 20px auto;
    text-align: center;
}

.search-bar select,
.search-bar input[type="text"] {
    padding: 10px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.search-bar input[type="button"] {
    padding: 10px 20px;
    border: none;
    background-color: #007bff;
    color: white;
    border-radius: 4px;
    cursor: pointer;
}

.search-bar input[type="button"]:hover {
    background-color: #0056b3;
}

table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

th, td {
    padding: 15px;
    text-align: center; /* 가로 가운데 정렬 */
    vertical-align: middle; /* 세로 가운데 정렬 */
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #007bff;
    color: white;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

tr:hover {
    background-color: #f1f1f1;
}

.back-button {
    text-align: center;
    margin: 20px;
}

.back-button input[type="button"] {
    padding: 10px 20px;
    border: none;
    background-color: #007bff;
    color: white;
    border-radius: 4px;
    cursor: pointer;
}

.back-button input[type="button"]:hover {
    background-color: #0056b3;
}

.centered {
    text-align: center;
}

.emphasized {
	color: red;
    font-weight: bold;
    background-color: #ffeb3b;
}

.chart-container {
    display: flex;
    justify-content: center;
    margin: 20px 0;
}

.chart-box {
    width: 45%;
    margin: 0 20px;
}


</style>


</head>
<body>
	<div class="search-bar">
		<select id="admin_payment_search_select" name="admin_payment_search_select">
			<option value="selectAll">:::전체조회:::</option>
			<option value="payment_user_name">고객이름</option>
			<option value="payment_sitter_name">시터이름</option>
			<option value="payment_uid">고유번호</option>
		</select>
		<input name="admin_payment_searchWord" id="admin_payment_searchWord">
		<input type="button" value="검색" onclick="admin_payment_search();">
	</div>
	<table border="1" align="center">
		<tr>
			<th>결제번호</th>
			<th>예약번호</th>
			<th>고객번호</th>
			<th>시터번호</th>
			<th>고객이름</th>
			<th>시터이름</th>
			<th>고유번호</th>
			<th>가격</th>
			<th class="emphasized">손익</th>
			<th>결제방법</th>
			<th>결제일자</th>
			<th>결제상태</th>
		</tr>
		<c:forEach var="vo" items="${list}">
			<tr>
				<td>${vo.payment_idx}</td>
				<td>${vo.payment_reserve_idx}</td>
				<td>${vo.payment_user_idx}</td>
				<td>${vo.payment_sitter_idx}</td>
				<td>${vo.payment_user_name}</td>
				<td>${vo.payment_sitter_name}</td>
				<td>${vo.payment_uid}</td>
				<td>${vo.payment_amount}</td>
				<td class="emphasized"><fmt:formatNumber value="${vo.payment_amount * 0.1}" type="number" maxFractionDigits="0"/></td>
				<td>${vo.payment_method}</td>
				<td>${vo.payment_date}</td>
				<td>${vo.payment_status}</td>
			</tr>
		</c:forEach>
		<tr>
		    <td colspan="11" class="centered">
		        ${pageMenu}
		    </td>
		</tr>
	</table>
	<div class="chart-container">
		<div class="chart-box">
			<canvas id="amountChart"></canvas>
		</div>
		<div class="chart-box">
			<canvas id="realAmountChart"></canvas>
		</div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<script>
	function getLastfiveDays() {
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

		let fiveDays = getLastfiveDays();
	</script>
	
	<script>

		let amountCtx = document.getElementById('amountChart').getContext('2d');
		let amountChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (amountChartInstance) {
        	amountChartInstance.destroy();
        }
		
        amountChartInstance = new Chart(amountCtx, {
			type : 'line',
			data : {
				labels : fiveDays,
				datasets : [ {
					label : '일별 매출',
					data : [ '${day1}', '${day2}', '${day3}', '${day4}', '${day5}' ],
					borderWidth : 1
				} ]
			},
			options : {
				plugins: {
		            title: {
		                display: true,
		                text: '최근 5일간 일별 매출',
		                color: 'black'
		            }
		        },
				scales : {
					y : {
						beginAtZero : true,
						ticks:{
							stepSize: 100000
						}	
					}
				}
			}
		});
	</script>
	
	<script>
	
	let day1 = '${day1}';
	let day2 = '${day2}';
	let day3 = '${day3}';
	let day4 = '${day4}';
	let day5 = '${day5}';

	// 문자열을 숫자로 변환하고 10% 계산
	let data = [parseFloat(day1), parseFloat(day2), parseFloat(day3), parseFloat(day4), parseFloat(day5)].map(value => value * 0.1);

		let realAmountCtx = document.getElementById('realAmountChart').getContext('2d');
		let realAmountChartInstance;
		
		 // 기존 차트가 있으면 파기
        if (realAmountChartInstance) {
        	realAmountChartInstance.destroy();
        }
		
        realAmountChartInstance = new Chart(realAmountCtx, {
			type : 'line',
			data : {
				labels : fiveDays,
				datasets : [ {
					label : '일별 손익',
					data : data,
					borderWidth : 1
				} ]
			},
			options : {
				plugins: {
		            title: {
		                display: true,
		                text: '최근 5일간 일별 손익',
		                color: 'black'
		            }
		        },
				scales : {
					y : {
						beginAtZero : true,
						ticks:{
							stepSize: 10000
						}	
					}
				}
			}
		});
	</script>
	
	<div class="back-button">
		<input type="button" value="뒤로가기"
			onclick="location.href='login_after_admin.do'">
	</div>
</body>
</html>