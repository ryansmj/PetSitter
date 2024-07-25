<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<!-- 폰트 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gamja+Flower&display=swap" rel="stylesheet">
		
		<!-- 폰트2 -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
		
		<!-- CSS 파일 링크 -->
    	<link rel="stylesheet" href="/project/resources/css/sitter/findSitter_list.css?v=<%= timeStamp %>">
		<script src="/project/resources/js/httpRequest.js"></script>
		
		<script>
			//시터 자세히 보기
			function send(f){
				
				f.method = "post";
				f.action  = "findSitterView.do";
				f.submit();
			}
			
			//즐겨찾기
			function favorite(f){
				let url = "favoriteInsert.do";
				let param = "sitter_idx=" + f.sitter_idx.value;
				
				sendRequest(url, param, resultFn, "post");
			}
			function resultFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					
					if(json[0].result == 'yes'){
						alert('즐겨찾기 추가 완료');
					}else{
						alert('즐겨찾기 목록에 존재하는 댕시터입니다');
					}
				}
			}

		</script>

<!-- 6/29 -->
	</head>
	
	<body>
		<jsp:include page="/WEB-INF/views/include/login_session.jsp"/>
		<!-- 헤더  -->
		<jsp:include page="/WEB-INF/views/include/header.jsp"/>
		
<main>
        
            <div class="sitter_find">
                <c:forEach var="vo" items="${list}">
                <form>
                    <div class="sitter_container">
                        <input type="hidden" name="user_idx" value="${vo.user_idx }"><!-- 시터의 user_idx  -->
            			<input type="hidden" name="sitter_idx" value="${vo.sitter_idx }"><!-- 시터의 sitter_idx -->
                        
                        
                            <div id="sitter_photo" class="sitter_photo">
                                <img src="/project/resources/upload/${vo.house1_name}" alt="Sitter Photo">
                            </div>
                            
                            <div class="sitter_info">
                                <div class="sitter_name">
                                   <p style="font-size: 15px; color: gray;"> ${vo.user_name} / ${vo.sitter_city }</p>
                                   <p class="dog_size" style="font-size: 20px;">${vo.sitter_small } &nbsp; ${vo.sitter_medium } &nbsp; ${vo.sitter_large } </p>
                                </div>
                                
                      <!-- 7/2  -->          
                                <h3><a href="#" onclick="send(this.closest('form'));">${vo.sitter_title }</a></h3>
                                <br>
                                
                                <div class="sitter_field">
                                <p>[전문분야]</p>
                                <p class="sitter_tag">${vo.sitter_care }</p>
                                <p class="sitter_tag">${vo.sitter_pickup }</p>
                                <p class="sitter_tag">${vo.sitter_bath }</p>
                                <p class="sitter_tag">${vo.sitter_olddog }</p>                            
                                <p class="sitter_tag">${vo.sitter_walk }</p>
                                </div>
                                
                                <div class="sitter_menu">
                                    <p>${vo.sitter_price_half } (1시간)</p>
                                    <p>${vo.sitter_price_full }(24시간) </p>
                                    <input type="button" value="즐겨찾기" onclick="favorite(this.form);">
                                </div>
                            </div>
                        
                    </div>
                </form>
                </c:forEach>
                
                <div id="page_menu">${pageMenu }
                <input type="button" value="조건 변경하기" onclick="location.href='findSitter.do'">
            	</div>
            </div>
        
    </main>
      
	</body>
</html>