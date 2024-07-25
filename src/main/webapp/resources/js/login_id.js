<!-- 아이디 관련 시작 -->
/* 아이디 유효성 검사 */
 function idCheck(id) {
	    let user_id = id.value; // 입력 필드의 값을 가져옵니다.

	 // 아이디 유효성 검사 - 조건: 앞뒤 공백 없음, 5자에서 12자 길이, 대문자.소문자.숫자만 허용
		let check_id = /^[a-zA-Z0-9]{5,12}$/;

	    if (user_id === "") {
	        document.getElementById("id_check_message").innerHTML = "아이디를 입력해주세요.";
	        document.getElementById("id_check_message").style.color = "red";
	        document.getElementById("id_check_message").style.display = "block";
	        return;
	    } else if (!check_id.test(user_id)) {
	        document.getElementById("id_check_message").innerHTML = "영문자 또는 숫자, 5자에서 12자 사이.";
	        document.getElementById("id_check_message").style.color = "red";
	        document.getElementById("id_check_message").style.display = "block";
	        return;
	    }

	    
	    let url = "idCheck.do"; // 중복 체크를 위한 서버 URL
	    let param = "user_id=" + user_id; // 요청에 필요한 파라미터 구성 
	    
	    sendRequest(url, param, idCheckFn, "get"); // 비동기 요청을 보냅니다.
	}

	function idCheckFn() {
	    if (xhr.readyState == 4 && xhr.status == 200) {
	        let data = xhr.responseText;
	        let json = (new Function('return ' + data))();

	        if (json[0].result == "yes") {
	            document.getElementById("id_check_message").innerHTML = "생성 가능한 아이디입니다.";
	            document.getElementById("id_check_message").style.color = "green";
	            document.getElementById('id_isChecked').value = 'true';
	        } else {
	            document.getElementById("id_check_message").innerHTML = "중복된 아이디입니다. 다시 입력해주세요.";
	            document.getElementById("id_check_message").style.color = "red";
	            document.getElementById('id_isChecked').value = 'false';
	        }
	    }
	}
<!-- 아이디 관련 끝 -->