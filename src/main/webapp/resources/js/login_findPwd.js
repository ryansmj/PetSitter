function user_email_front_changed_pwd(){
	document.getElementById("user_email_front_isChecked_pwd").value = 'false';
}
function user_email_select_changed_pwd(){
	document.getElementById("user_email_select_isChecked_pwd").value = 'false';
}
function user_email_write_changed_pwd(){
	document.getElementById("user_email_write_isChecked_pwd").value = 'false';
}

function emailWriteCheck_pwd() {
    let user_email_select = document.getElementById('user_email_select_pwd').value;
    let user_email_write = document.getElementById('user_email_write_pwd'); 
    
    // select가 write를 고른 상황인지 자동 메일 선택을 고른 상황인지에 따라서
    // write 부분 display가 보여질지 말지 결정
    if (user_email_select === 'write') {
    	user_email_write_pwd.style.display = 'block';
    	document.getElementById('user_email_write_warn_pwd').style.display = 'block';
    } else {
    	user_email_write_pwd.style.display = 'none';
    	document.getElementById('user_email_write_warn_pwd').style.display = 'none';
   } 	  
}

// write에 이메일 형식이 맞는지 체크
function email_backCheck_pwd() {
    let user_email_write = document.getElementById('user_email_write_pwd').value;
    let emailPattern = /^@.*\.com$/;

    if (!emailPattern.test(user_email_write)) {
    	user_email_write_warn_pwd.innerHTML = '@로 시작하고 .com으로 끝나야 합니다.';
    	user_email_write_warn_pwd.style.color = 'red';
    	document.getElementById("user_email_write_isChecked").value = 'false';
    } else {
    	user_email_write_warn_pwd.innerHTML = '올바른 이메일 형식입니다.';
    	user_email_write_warn_pwd.style.color = 'green';
    	document.getElementById("user_email_write_isChecked").value = 'true';
    }
}

// 비밀번호 찾기에서 본인인증 클릭
function find_emailCheck_pwd(){
    let user_email_front = document.getElementById('user_email_front_pwd').value;
    let user_email_select = document.getElementById('user_email_select_pwd').value;
    let user_email_write = document.getElementById('user_email_write_pwd').value;
	let user_email = document.getElementById('user_email_pwd').value;
	let user_email_write_isChecked = document.getElementById("user_email_write_isChecked_pwd");
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
        	document.getElementById('user_email_pwd').value = user_email
        } else {
        	user_email = user_email_front + user_email_select;
        	document.getElementById('user_email_pwd').value = user_email
        }
    }
    
    //db에 있는 메일인지 보고오기
	 let url = "emailCheck.do";
	 let param = "user_email=" + document.getElementById('user_email_pwd').value;
	 sendRequest(url, param, find_emailCheckFn_pwd, "post");
}

function find_emailCheckFn_pwd(){
    if (xhr.readyState == 4 && xhr.status == 200) {
        let data = xhr.responseText;
        let json = (new Function('return ' + data))();

        if (json[0].result == "yes") {
            alert("가입되지 않은 메일입니다. 다시 한번 확인해주세요.");
            return;
        } else {
		    let emailFront = document.getElementById('user_email_front_pwd');
		    let emailSelect = document.getElementById('user_email_select_pwd');
		    let emailWrite = document.getElementById('user_email_write_pwd');
		
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
        	mailCheck_pwd();
        }
    }
}

// 인증번호 쏘기
function mailCheck_pwd() {
	// 재인증 할 수도 있으니 누르는 순간 값 비워줌
	document.getElementById("check_mail_input_pwd").value = '';
	
    let user_email_front = document.getElementById('user_email_front_pwd').value;
    let user_email_select = document.getElementById('user_email_select_pwd').value;
    let user_email_write = document.getElementById('user_email_write_pwd').value;
	let user_email = document.getElementById('user_email_pwd').value;
	
	if(user_email_select == 'write'){
		user_email_select = '';
	}
	
    if (user_email_front && (user_email_select !== 'write' || user_email_write)) {
        if (user_email_select === '') {
        	user_email = user_email_front + user_email_write;
        	document.getElementById('user_email_pwd').value = user_email
        } else {
        	user_email = user_email_front + user_email_select;
        	document.getElementById('user_email_pwd').value = user_email
        }
    }
    
    // 회원가입에서 하는 메일 인증 재활용
    let url = "mailCheck.do";
    let param = "user_email=" + user_email;
    sendRequest(url, param, resultEmail_pwd, "post");
}

function resultEmail_pwd(){
	 if(xhr.readyState == 4 && xhr.status == 200){
	 let data = xhr.responseText;
	 alert("인증코드가 입력하신 이메일로 전송 되었습니다");
	 //인증번호 입력창 활성화
	let check_mail_input = 
	document.getElementById("check_mail_input_pwd");
	check_mail_input.disabled = false;
	 //전역변수 res에 넘겨받은 인증번호를 담는다
	res = data;
	 }
}

// 인증번호 입력 후 확인 버튼 클릭
function check_mail_input_numberCheck_pwd(){
	 let check_mail_input = document.getElementById("check_mail_input_pwd");
	 if( check_mail_input_pwd.value == res ){
		 alert("메일인증성공");
		 // 인증번호 입력하는 곳 비활성화 시킴
		 check_mail_input_pwd.disabled = true;
		 
		 document.getElementById("user_email_front_isChecked").value = 'true';
		 document.getElementById("user_email_select_isChecked").value = 'true';
		 document.getElementById("user_email_write_isChecked").value = 'true';
		 let emailFront = document.getElementById('user_email_front_pwd');
		 let emailSelect = document.getElementById('user_email_select_pwd');
		 let emailWrite = document.getElementById('user_email_write_pwd');
		
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

// 비밀번호 찾기 부분 다 입력하고 확인 버튼 눌렀을 때
function pwd_send(){
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
	
	let user_id = document.getElementById("user_id_pwd").value;
	let user_name = document.getElementById("user_name_pwd").value;
	let user_email = document.getElementById("user_email_pwd").value;
	
	// db에서 있는 이름인지 보고 나오기
	let url = "find_pwd_check.do";
	let param = "user_id=" + user_id + "&user_name=" + user_name + "&user_email=" + user_email;
	sendRequest(url, param, resultPwdCheck, "post");
}

function resultPwdCheck(){
	  if (xhr.readyState == 4 && xhr.status == 200) {
	        let data = xhr.responseText;
	        let json = (new Function('return ' + data))();

	        if (json[0].result == "no") {
	        	// db에 있음 (비번 바꿔주기)
	        	email_sendPwd();
	        } else {
	        	alert("회원정보가 없습니다.");
	        	return;
	           // db에 없는 정보(비번 못바꿔줌)
	        }
	    }
}

// 바뀐 비밀번호 메일로 쏴주기
function email_sendPwd(){
	 let url = "emailCheck_sendPwd.do";
	 let param = "user_email=" + document.getElementById('user_email_pwd').value;
	 sendRequest(url, param, emailCheck_sendPwdFn, "post");
}

function emailCheck_sendPwdFn(){
	 if(xhr.readyState == 4 && xhr.status == 200){
		 let data = xhr.responseText;
		 alert("새로운 비밀번호가 이메일로 전송 되었습니다");
		 //인증번호 입력창 활성화
		let check_mail_input = document.getElementById("check_mail_input_pwd");
		check_mail_input.disabled = false;
		 //전역변수 res에 넘겨받은 인증번호를 담는다
		res = data;
		 }	
}


