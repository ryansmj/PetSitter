<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	window.onload=function(){
		alert("결제가 완료되었습니다");
		location.href="myReserveList.do?user_idx=" + ${user_idx};
	}
	</script>
</head>
<body>

</body>
</html>