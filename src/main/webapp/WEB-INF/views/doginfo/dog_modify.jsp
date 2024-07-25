<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	
	
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script>
        function send(f) {
            let dog_age = f.dog_age.value;
            let dog_size = f.dog_size.value;


            if (dog_age === "") {
                alert("강아지 나이를 선택하세요.");
                f.dog_age.focus();
                return false;
            }

            if (dog_size === "") {
                alert("강아지 크기를 선택하세요.");
                f.dog_size.focus();
                return false;
            }

            alert("수정이 완료되었습니다.");
            f.submit();
        }
    </script>
		
		
		
	</head>
	
	
	
	<body>
			<h1>:::정보수정:::</h1>
			
			<form name="f" method="post" action="dog_update.do" enctype="multipart/form-data">
			
			<input type="hidden" name="dog_idx" value="${vo.dog_idx}">
			<input name="dog_name" value="${vo.dog_name }">
			<div>
                강아지 나이 : 
                <select name="dog_age" onchange="send(this)" id="dog_age" value="${vo.dog_age }">
                    <c:forEach var="i" begin="0" end="40">
                        <option value="${i}">${i}세</option>
                    </c:forEach>
                </select>
            </div>
            
			<select name="dog_size" onchange="send(this)">
                    <option value="대형">대형</option>
                    <option value="중형">중형</option>
                    <option value="소형">소형</option>
            </select>
            
            <tr>
                <th>반려견 사진 : <input type="file" name="dog_photo" value="${vo.dog_photo_name }"></th> 
            </tr>
            
        <input type="hidden" name="dog_user_idx" value="${user.user_idx}">
        <input type="button" value="등록" onclick="send(this.form);">
         </form>   
            
			
	
	
	
	
	
	</body>
	
</html>