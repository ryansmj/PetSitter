	var IMP = window.IMP;
	IMP.init("imp54887878");
	
	function generateMerchantUID() {
	    var timestamp = new Date().getTime();
	    return "merchant_" + timestamp;
	}
	
	// 결제 성공하면 이동~
	function ifPaySuccess(merchantUID){
	    let payment_amount = document.getElementById("amount").value;
	    let payment_reserve_idx = document.getElementById("reserve_idx").value;
	    let payment_user_idx = document.getElementById("reserve_user_idx").value;
	    let payment_sitter_idx = document.getElementById("reserve_sitter_idx").value;
	    let payment_user_name = document.getElementById("reserve_user_name").value;
	    let payment_sitter_name = document.getElementById("reserve_sitter_name").value;
	    
	    let param = new URLSearchParams({
	        payment_amount: payment_amount,
	        payment_reserve_idx: payment_reserve_idx,
	        payment_user_idx: payment_user_idx,
	        payment_sitter_idx: payment_sitter_idx,
	        payment_user_name: payment_user_name,
	        payment_sitter_name: payment_sitter_name,
	        payment_merchant_uid: merchantUID
	    }).toString();
	   // 부모 창에서 페이지 이동
	    window.opener.location.href = 'ifPaySuccess.do?' + param;
	    // 현재 창 닫기
	    window.close();
	}
	
	// 결제 실패해도 이동~ 아임퐈인~ 괜찮아~ 갠차나.. 띠로리로리~
		function ifPayFail(){
		alert("결제에 실패했습니다.");
	    // 부모 창 새로고침
	    window.opener.location.reload();
	    // 현재 창 닫기
	    window.close();
	}



	
	function resultPayment(){
		if (xhr.readyState == 4 && xhr.status == 200) {
	        let data = xhr.responseText;
	        let json = (new Function('return ' + data))();
	
	        if (json[0].result == "no") {
	            alert("결제 실패, 죄송합니다");
	            return;
	        } else {
			    alert("결제 성공, 감사합니다");
			    location.href = "good.do" //수정해야함
	        }
    	}
	}
	
    function KakaoPay() {
	    var merchantUID = generateMerchantUID();
	    
        IMP.request_pay(
            {
                pg: "kakaopay.TC0ONETIME",
                pay_method: "card",
                merchant_uid: merchantUID,
                name: "돌봐줄개 결제",
                amount: document.getElementById("amount").value,
            },
            function (rsp) {
                if (rsp.success) {
                    console.log("결제가 완료되었습니다. imp_uid: " + rsp.imp_uid);
                     ifPaySuccess(merchantUID);
                } else {
                    // 결제 실패
                    console.log("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    ifPayFail();
                }
            }
        );
    }
    
    function TossPay() {
	    var merchantUID = generateMerchantUID();
	    
        IMP.request_pay(
            {
                pg: "tosspay",
                pay_method: "card",
                merchant_uid: merchantUID,
                name: "돌봐줄개 결제",
                amount: document.getElementById("amount").value,
            },
            function (rsp) {
                if (rsp.success) {
                    console.log("결제가 완료되었습니다. imp_uid: " + rsp.imp_uid);
                     ifPaySuccess(merchantUID);
                } else {
                    // 결제 실패
                    console.log("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    ifPayFail();
                }
            }
        );
    }
    
    function InicisPay() {
	    var merchantUID = generateMerchantUID();
	    var amount = parseInt(document.getElementById("amount").value.replace(/[^0-9]/g, ''), 10);
	    
        IMP.request_pay(
            {
				pg : 'html5_inicis',
			    pay_method : 'card',
			    merchant_uid: merchantUID, // 상점에서 관리하는 주문 번호를 전달
			    name : '주문명:결제테스트',
			    amount : amount,
			    buyer_email : 'iamport@siot.do',
			    buyer_name : '구매자이름',
			    buyer_tel : '010-1234-5678',
			    buyer_addr : '서울특별시 강남구 삼성동',
			    buyer_postcode : '123-456',
			    m_redirect_url : '{모바일에서 결제 완료 후 리디렉션 될 URL}'
			    },
            function (rsp) {
                if (rsp.success) {
                    console.log("결제가 완료되었습니다. imp_uid: " + rsp.imp_uid);
                     ifPaySuccess(merchantUID);
                } else {
                    // 결제 실패
                    console.log("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    ifPayFail();
                }
            }
        );
    }
    