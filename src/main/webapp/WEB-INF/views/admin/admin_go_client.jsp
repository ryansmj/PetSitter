<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
        body {
            font-family: 'Helvetica Neue', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        div {
            margin: 20px;
            text-align: center;
        }

        select,
        input[type="text"] {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            width: 200px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        select:focus {
            border-color: #a3c9a8;
            box-shadow: 0 0 5px rgba(163, 201, 168, 0.5);
        }

        input[type="button"] {
            padding: 10px 20px;
            background-color: #a3c9a8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        input[type="button"]:hover {
            background-color: #8abf92;
            transform: translateY(-2px);
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        th,
        td {
            padding: 15px;
            text-align: center;
            border: 1px solid #eee;
            transition: background-color 0.3s ease;
        }

        th {
            background-color: #f2f2f2;
            color: #555;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .page-menu {
            margin: 20px;
            text-align: center;
        }

        .page-menu td {
            padding: 10px;
        }

        .back-button {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background-color: #f4bfbf;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .back-button:hover {
            background-color: #eaa1a1;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            select,
            input[type="text"] {
                width: 100%;
                margin-bottom: 10px;
            }

            input[type="button"] {
                width: 100%;
            }

            table {
                width: 100%;
            }
        }
    </style>

<script src="/project/resources/js/httpRequest.js"></script>

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
		location.href="admin_go_client.do?" + param;
	}

</script>
</head>
<body>
	<div>
		<select id="admin_search_select" name="admin_search_select">
			<option value="selectAll">:::전체조회:::</option>
			<option value="user_idx">고객번호</option>
			<option value="user_id">아이디</option>
			<option value="user_name">이름</option>
			<option value="user_address">주소</option>
		</select> <input name="admin_searchWord" id="admin_searchWord"> <input
			type="button" value="검색" onclick="admin_search();">
	</div>
	<table border="1" align="center">
		<tr>
			<th>고객번호</th>
			<th>이용자/제공자</th>
			<th>아이디</th>
			<th>이름</th>
			<th>번호</th>
			<th style="width:6%">생년월일</th>
			<th style="width:4%">성별</th>
			<th style="width:5%">이메일</th>
			<th style="width:6%">우편번호</th>
			<th>주소</th>
			<th>자세한주소</th>
			<th>추가주소</th>
			<th>가입날짜</th>
		</tr>
		<c:forEach var="vo" items="${list}">
			<tr>
				<th>${vo.user_idx}</th>
				<th>${vo.user_type}</th>
				<th>${vo.user_id}</th>
				<th>${vo.user_name}</th>
				<th>${vo.user_tel}</th>
				<th>${vo.user_birth}</th>
				<th>${vo.user_gender}</th>
				<th>${vo.user_email}</th>
				<th>${vo.user_postcode}</th>
				<th>${vo.user_address}</th>
				<th>${vo.user_detailaddress}</th>
				<th>${vo.user_extraaddress}</th>
				<th>${vo.user_regdate}</th>
			</tr>
		</c:forEach>
		<tr>		
			<td colspan="13" align="center">
				${pageMenu}
			</td>
		</tr>
	</table>
	
	<div>
		<input type="button" value="뒤로가기"
			onclick="location.href='login_after_admin.do'">
	</div>
</body>
</html>