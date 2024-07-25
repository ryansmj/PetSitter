<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty user }">
	<script>
		alert("로그인 후 이용 가능합니다");
		location.href="loginBeforeMain.do";
	</script>
</c:if>