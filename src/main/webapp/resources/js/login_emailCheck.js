<!-- 이메일 관련 시작 -->
	// select를 수정하면 실행됨 목적은 -> 직접 입력하려고 write를 고른 경우를 검사하기 위함
function emailWriteCheck() {
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

function email_backCheck() {
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


	
function user_email_front_changed(){
	document.getElementById("user_email_front_isChecked").value = 'false';
}
function user_email_select_changed(){
	document.getElementById("user_email_select_isChecked").value = 'false';
}
function user_email_write_changed(){
	document.getElementById("user_email_write_isChecked").value = 'false';
}

function emailCheck(){
    let user_email_front = document.getElementById('user_email_front').value;
    let user_email_select = document.getElementById('user_email_select').value;
    let user_email_write = document.getElementById('user_email_write').value;
   let user_email = document.getElementById('user_email').value;
   let user_email_write_isChecked = document.getElementById("user_email_write_isChecked");
   let emailPattern = /^@.*\.com$/;
   let pattern = /^[a-zA-Z0-9]{1,15}$/;
   
   if(user_email_select != 'write'){
      user_email_write = '';
   }
   
   if(user_email_front === '' || user_email_front=== null){
      alert("메일을 먼저 입력해주세요");
      return;
   }
   
   if (!pattern.test(user_email_front)) {
          alert('15 글자 내의 영어와 숫자만 허용되며 공백이 있어서는 안됩니다.');
          return;
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
    let url = "emailCheck.do";
    let param = "user_email=" + document.getElementById('user_email').value;
    sendRequest(url, param, emailCheckFn, "post");
}

function emailCheckFn(){
    if (xhr.readyState == 4 && xhr.status == 200) {
        let data = xhr.responseText;
        let json = (new Function('return ' + data))();

        if (json[0].result == "yes") {
        	mailCheck();
        } else {
            alert("중복 된 메일입니다. 다시 한번 입력해주세요.");
            return;
        }
    }
}

function mailCheck() {
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
    let url = "mailCheck.do";
    let param = "user_email=" + user_email;
    sendRequest(url, param, resultEmail, "post");
}

function resultEmail(){
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


