<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #e9ecef;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 20px;
        margin: 0;
     
    }
    .search-container {
        margin-bottom: 20px;
        text-align: center;
    }
    .search-container select,
    .search-container input[type="text"],
    .search-container input[type="button"] {
        padding: 10px;
        margin: 5px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        font-size: 16px;
    }
    .search-container input[type="button"] {
        background-color: #28a745;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
    }
    .search-container input[type="button"]:hover {
        background-color: #218838;
        transform: translateY(-2px);
    }
    table {
        width: 80%;
        border-collapse: collapse;
        margin-bottom: 20px;
        background-color: white;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    th, td {
        padding: 15px;
        text-align: center; /* 모든 텍스트를 가운데 정렬 */
        border: 1px solid #dee2e6;
    }
    th {
        background-color: #6c757d;
        color: white;
        font-weight: bold;
    }
    tr:nth-child(even) {
        background-color: #f8f9fa;
    }
    tr:hover {
        background-color: #e9ecef;
        cursor: pointer;
    }
    .pagination {
        text-align: center;
        margin: 20px 0;
        padding: 10px 0;
        border-top: 1px solid #dee2e6;
    }
    .pagination:hover {
        background-color: inherit; /* pagination 행의 hover 효과 제거 */
    }
    .pagination-container {
        display: flex;
        justify-content: center; /* 페이지네이션 버튼을 가운데 정렬 */
        align-items: center;
    }
    .back-button-container {
        text-align: center;
        margin-top: 20px;
    }
    .back-button-container input[type="button"] {
        padding: 10px 20px;
        background-color: #dc3545;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
    }
    .back-button-container input[type="button"]:hover {
        background-color: #c82333;
        transform: translateY(-2px);
    }
</style>


<script>
	document.addEventListener("DOMContentLoaded", function() {
		let rows = document.querySelectorAll("tr[data-href]");
		rows.forEach(function(row) {
			row.addEventListener("click", function() {
				// 행 아무곳이나 클릭하면 data-href 에 있는 url로 가기.
				window.location.href = row.getAttribute("data-href");
			});
		});
	});
</script>

<script>
	function admin_search() {
		let admin_search_select = document.getElementById("admin_search_select").value;
		let admin_searchWord = document.getElementById("admin_searchWord").value;
		
		if (admin_search_select === "selectAll") {
			admin_searchWord = null;
		}
		
		if(admin_search_select != "selectAll" && (admin_searchWord === '' || admin_searchWord === null)){
			alert("검색어를 입력하세요");
			return;
		}

		let param = "admin_searchWord=" + admin_searchWord + "&admin_search_select=" + admin_search_select;
		location.href="admin_go_confirm.do?" + param;
	}
</script>


</head>
<body>
	  <div class="search-container">
        <select id="admin_search_select" name="admin_search_select">
            <option value="selectAll">:::전체조회:::</option>
            <option value="user_idx">고객번호</option>
            <option value="user_name">작성자</option>
            <option value="sitter_title">글 제목</option>
            <option value="sitter_city">지역</option>
        </select> 
        <input name="admin_searchWord" id="admin_searchWord" type="text"> 
        <input type="button" value="검색" onclick="admin_search();">
    </div>

	<table align="center" border="1">
		<tr>
			<th style="width:5%">고객 번호</th>
			<th style="width:7%">작성자</th>
			<th>글 제목</th>
			<th>지역</th>
			<th>소개</th>
			<th style="width:8%">신청 상황</th>
		</tr>
		<c:forEach var="vo" items="${list}">
			<tr data-href="admin_go_sitterConfirm.do?user_idx=${vo.user_idx}">
				<td>${vo.user_idx}</td>
				<td>${vo.user_name}</td>
                <td>${vo.sitter_title}</td>
                <td>${vo.sitter_city}<br>${vo.sitter_district}</td>
                <td>${vo.sitter_introduce}</td>
                <td>${vo.sitterApproval_status}</td>
			</tr>
		</c:forEach>
		<tr  class="pagination">
			<td colspan="6" align="center">
                ${pageMenu}
            </td>
		</tr>
	</table>
	 <div class="back-button-container">
        <input type="button" value="뒤로가기" onclick="location.href='login_after_admin.do'">
    </div>
</body>
</html>