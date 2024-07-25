function user_email_front_changed_id(){
	document.getElementById("user_email_front_isChecked").value = 'false';
}
function user_email_select_changed_id(){
	document.getElementById("user_email_select_isChecked").value = 'false';
}
function user_email_write_changed_id(){
	document.getElementById("user_email_write_isChecked").value = 'false';
}

function emailWriteCheck_id() {
    let user_email_select = document.getElementById('user_email_select').value;
    let user_email_write = document.getElementById('user_email_write'); 
    /* write로 직접 적았 후에 기본 옵션으로 변경시 write.value->''  */
    if (user_email_select === 'write') {
    	user_email_write.style.display = 'block';
    	document.getElementById('user_email_write_warn').style.display = 'block';
    } else {
    	user_email_write.style.display = 'none';
    	document.getElementById('user_email_write_warn').style.display = 'none';
    	
    }
}

// write에 이메일 형식이 맞는지 체크
function email_backCheck_id() {
    let user_email_write = document.getElementById('user_email_write').value;
    let emailPattern = /^@.*\.com$/;

    if (!emailPattern.test(user_email_write)) {
    	user_email_write_warn.innerHTML = '@로 시작하고 .com으로 끝나야 합니다.';
    	user_email_write_warn.style.color = 'red';
    	document.getElementById("user_email_write_isChecked").value = 'false';
    } else {
    	user_email_write_warn.innerHTML = '올바른 이메일 형식입니다.';
    	user_email_write_warn.style.color = 'green';
    	document.getElementById("user_email_write_isChecked").value = 'true';
    }
}

// 아이디 찾기에서 본인인증 클릭
function find_emailCheck(){
    let user_email_front = document.getElementById('user_email_front').value;
    let user_email_select = document.getElementById('user_email_select').value;
    let user_email_write = document.getElementById('user_email_write').value;
	let user_email = document.getElementById('user_email').value;
	let user_email_write_isChecked = document.getElementById("user_email_write_isChecked");
	let emailPattern = /^@.*\.com$/;
	
	if(user_email_front === ''){
		alert("메일을 먼저 입력해주세요.");
		return;
	}
	
	if(user_email_select != 'write'){
		user_email_write = '';
	}

	if(user_email_write_isChecked == 'false' && user_email_select == 'write'){
		alert("@로 시작하고 .com으로 끝나야 합니다.");
		return;
	}
	
	if(user_email_select == 'write' && user_email_write == ''){
		alert("@로 시작하고 .com으로 끝나야 합니다.");
		return;
	}
	 
	if(user_email_select == 'write'){
		user_email_select = '';
		if (!emailPattern.test(user_email_write)) {
	    	alert('@로 시작하고 .com으로 끝나야 합니다.');
	    	return;
	    }
	}
	
    if (user_email_front && (user_email_select !== 'write' || user_email_write)) {
        if (user_email_select === '') {
        	user_email = user_email_front + user_email_write;
        	document.getElementById('user_email').value = user_email
        } else {
        	user_email = user_email_front + user_email_select;
        	document.getElementById('user_email').value = user_email
        }
    }
    //db에 있는 메일인지 보고오기
	 let url = "emailCheck.do";
	 let param = "user_email=" + document.getElementById('user_email').value;
	 sendRequest(url, param, find_emailCheckFn, "post");
}

function find_emailCheckFn(){
    if (xhr.readyState == 4 && xhr.status == 200) {
        let data = xhr.responseText;
        let json = (new Function('return ' + data))();

        if (json[0].result == "yes") {
            alert("가입되지 않은 메일입니다. 다시 한번 확인해주세요.");
            return;
        } else {
		    let emailFront = document.getElementById('user_email_front');
		    let emailSelect = document.getElementById('user_email_select');
		    let emailWrite = document.getElementById('user_email_write');

		// 인증 완료하기 전까지 입력 모두 비활성화
		    if (emailFront) {
		        emailFront.readOnly = true;
		    }
		    if (emailSelect) {
		        emailSelect.disabled = true;
		    }
		    if (emailWrite) {
		        emailWrite.readOnly = true;
		    }
        	mailCheck_id();
        }
    }
}

function mailCheck_id() {
	// 재인증 할 수도 있으니 누르는 순간 값 비워줌
	document.getElementById("check_mail_input").value = '';
	
    let user_email_front = document.getElementById('user_email_front').value;
    let user_email_select = document.getElementById('user_email_select').value;
    let user_email_write = document.getElementById('user_email_write').value;
	let user_email = document.getElementById('user_email').value;
	
	if(user_email_select == 'write'){
		user_email_select = '';
	}
	
    if (user_email_front && (user_email_select !== 'write' || user_email_write)) {
        if (user_email_select === '') {
        	user_email = user_email_front + user_email_write;
        	document.getElementById('user_email').value = user_email
        } else {
        	user_email = user_email_front + user_email_select;
        	document.getElementById('user_email').value = user_email
        }
    }

    // 회원가입에서 하는 메일 인증 재활용
    let url = "mailCheck.do";
    let param = "user_email=" + user_email;
    sendRequest(url, param, resultEmail_id, "post");
}

function resultEmail_id(){
	 if(xhr.readyState == 4 && xhr.status == 200){
	 let data = xhr.responseText;
	 alert("인증코드가 입력하신 이메일로 전송 되었습니다");
	 //인증번호 입력창 활성화
	let check_mail_input = document.getElementById("check_mail_input");
	check_mail_input.disabled = false;
	 //전역변수 res에 넘겨받은 인증번호를 담는다
	res = data;
	 }
}

// 인증번호 입력 후 확인 버튼 클릭
function check_mail_input_numberCheck(){
	 let check_mail_input = document.getElementById("check_mail_input");
	 if( check_mail_input.value == res ){
		 alert("메일인증성공");
		 // 인증번호 입력하는 곳 비활성화 시킴
		 check_mail_input.disabled = true;
		 
		 document.getElementById("user_email_front_isChecked").value = 'true';
		 document.getElementById("user_email_select_isChecked").value = 'true';
		 document.getElementById("user_email_write_isChecked").value = 'true';
		 let emailFront = document.getElementById('user_email_front');
		 let emailSelect = document.getElementById('user_email_select');
		 let emailWrite = document.getElementById('user_email_write');
		
		// 메일 인증 완료했지만.. 굳이 뭐.. 바꿀 필요는 없을 거 같지만 그래도 다시 수정은 가능하게..
		// 추후에 다시 고려해보기
		 if (emailFront) {
		 		emailFront.readOnly = false;
		    }
		 if (emailSelect) {
		        emailSelect.disabled = false;
		    }
		 if (emailWrite) {
		        emailWrite.readOnly = false;
		    }
	 }else{
		 alert("인증번호 불일치");
	 }
}

// 아이디 찾기 부분 다 입력하고 확인 버튼 눌렀을 때
function id_send(){
	let user_email_front_isChecked = 
		document.getElementById("user_email_front_isChecked").value;
	
	let user_email_select_isChecked = 
		document.getElementById("user_email_select_isChecked").value;
	
	let user_email_write_isChecked = 
		document.getElementById("user_email_write_isChecked").value;
	
	if(user_email_front_isChecked === "false" || user_email_select_isChecked ==="false"
			|| user_email_write_isChecked ==="false"){
		alert("메일 인증을 해주세요.");
		return;
	}
	
	let user_name = document.getElementById("user_name").value;
	let user_email = document.getElementById("user_email").value;
	
	// db가서 있는 정보인지 보고 나오기
	let url = "find_id_check.do";
	let param = "user_name=" + user_name + "&user_email=" + user_email;
	sendRequest(url, param, resultIdCheck, "post");
}

function resultIdCheck(){
	  if (xhr.readyState == 4 && xhr.status == 200) {
	        let data = xhr.responseText;
	        let json = (new Function('return ' + data))();

	        if (json[0].result == "no") {
	        	// db에 있음 (아이디 알려주기)
	        	// 아래에 함수 있음
	        	email_sendId();
	        } else {
	        	alert("회원정보가 없습니다.");
	        	return;
	        	// db에 없는 정보(아이디 못알려줌)
	        }
	    }
}



// 찾는 아이디 메일로 쏴주기
function email_sendId(){
	 let url = "emailCheck_sendId.do";
	 let param = "user_email=" + document.getElementById('user_email').value
	 + "&user_name=" + document.getElementById('user_name').value;
	 sendRequest(url, param, emailCheck_sendIdFn, "post");
}
function emailCheck_sendIdFn(){
	 if(xhr.readyState == 4 && xhr.status == 200){
		 let data = xhr.responseText;
		 alert("아이디가 입력하신 이메일로 전송 되었습니다");
		 //인증번호 입력창 활성화
		let check_mail_input = document.getElementById("check_mail_input");
		check_mail_input.disabled = false;
		 //전역변수 res에 넘겨받은 인증번호를 담는다
		res = data;
		 }	
}


