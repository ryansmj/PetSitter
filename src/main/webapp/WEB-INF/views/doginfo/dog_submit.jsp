<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강아지 정보 입력</title>
    
    <!-- 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
    
    <!-- 폰트2 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/project/resources/css/doginfo/dog_submit.css">
    
    <script>
        function send(f, user_idx) {
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

            if (checkDogCount(user_idx)) {
                alert("이미 등록된 강아지가 있습니다. 한 마리만 등록 가능합니다.");
                return false;
            }

            alert("수정이 완료되었습니다.");
            f.submit();
        }
        
        function checkDogCount(user_idx){
            let result = false;
            let xhr = new XMLHttpRequest();
            xhr.open("GET","checkDogCount.do?user_idx=" + user_idx,false);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    result = (parseInt(xhr.responseText) > 0);
                }
            };
            xhr.send();
            return result;
        }
    </script>
</head>

<body>
   
   <!-- 헤더  -->
   <header>
   <jsp:include page="/WEB-INF/views/include/header.jsp"/>
   </header>

    <form name="f" method="post" action="dog_insert.do" enctype="multipart/form-data">
      
      <h2><img style="width: 50px; height: 50px;" src="/project/resources/image/글쓰기아이콘.png"> 강아지의 정보를 입력해주세요</h2>
      
      <div class="dog_info">   
      
            <div id="dogname_containa">
               <p>강아지 이름</p>
                <input type="text" name="dog_name">
            </div>
            
            <div id="dogage_comtaina">
                <p>강아지 나이</p> 
                <select name="dog_age" id="dog_age">
                    <c:forEach var="i" begin="0" end="20">
                        <option value="${i}">${i}세</option>
                    </c:forEach>
                </select>
            </div>
            
            
            <div id="dogsize_containa">
                <p>강아지 크기</p>
                <select id="dog_size" name="dog_size">
                    <option value="대형">대형</option>
                    <option value="중형">중형</option>
                    <option value="소형">소형</option>
                </select>
            </div>
            
            <div id="dogcare_containa">
                <p>주의해야 할 점</p>
                <textarea id="dog_care" name="dog_care" cols="100" rows="5"></textarea>
            </div>
            
            <div id="dogphoto_containa">
                <p>반려견 사진</p> 
                <p>파일 선택</p>
                <input type="file" name="dog_photo">
            </div>
        <input type="hidden" name="dog_user_idx" value="${user.user_idx}">
        
        </div>
        <div class="doginfo_btn">
        <input type="button" value="등록" onclick="send(this.form, ${user.user_idx});">
       </div>
    </form>
</body>
</html>
