/* 전화번호 유효성 검사 */

/* 전화번호 중복검사 후 다시 변경한 경우 */	
function telCheck_changed(){
	document.getElementById("tel_isChecked").value = 'false';
}

function telCheck() {
	
	 let user_tel = document.getElementById("user_tel").value;

	    // 전화번호 유효성 검사 - 조건: "010"으로 시작하는 11자리 숫자
	    let check_tel = /^010\d{8}$/;
	    
	    if (user_tel === "") {
	        alert("전화번호를 입력해주세요.");
	        return;
	    } else if (!check_tel.test(user_tel)) {
	        alert("전화번호는 '010'으로 시작하는 11자리 숫자여야 합니다.");
	        return;
	    }
	
    let url = "telCheck.do";
    let param = "user_tel=" + user_tel; // 파라미터 이름도 user_tel로 수정
    sendRequest(url, param, telCheckFn, "get");
}
	
	function telCheckFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == "yes") {
				alert("사용 가능한 번호입니다");
				document.getElementById('tel_isChecked').value = 'true';
				return;
			} else {
				alert("중복된 번호입니다. 다시 입력해주세요.");
				document.getElementById('tel_isChecked').value = 'false';
				return;
			}
		}
	}
<!-- 번호 관련 끝 -->