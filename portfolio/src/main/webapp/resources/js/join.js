$(document).ready(function () {
	
	$(".join").attr("disabled", true);
	var nickChk, emailChk, confirmChk, pwChk = false;
	
	/* 닉네임 중복 체크 */
	$("#nickname").change(function () {
		var objParam = {
				nickname	: $("#nickname").val()
		}
		
		$.ajax({
			url			: "/join/check/nickname",
			dataType	: "json",
			data		: objParam,
			type		: "POST",
			success		: function(retVal) {
    			if(retVal.result == "overlap"){
    				$(".nickname").css("display", "inherit");
    				$("#nickname").css("border", "1px solid #ff6e6e");
    				nickChk = false;
    			} else{
    				$(".nickname").css("display", "none");
    				$("#nickname").css("border", "");
    				nickChk = true;
    			}
    		},
    		error		: function(request, status, error){
    			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
	
	/* 이메일 유효성 체크 */
	$("#email").change(function () {
		var str = $("#email").val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if (regExp.test(str)) {
			$(".email").css("display", "none");
			$("#email").css("border", "");
			
			$.ajax({
				url			: "/join/check/email",
				dataType	: "json",
				data		: {
					email	: $("#email").val()
				},
				type		: "POST",
				success		: function(retVal) {
	    			if(retVal.result == "overlap"){
	    				$(".email").text(retVal.message);
	    				$(".email").css("display", "inherit");
	    				$("#email").css("border", "1px solid #ff6e6e");
	    				emailChk = false;
	    			} else{
	    				$(".email").css("display", "none");
	    				$("#email").css("border", "");
	    				emailChk = true;
	    			}
	    		},
	    		error		: function(request, status, error){
	    			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				}
			});
			return true;
		} else {
			$(".email").text("잘못된 이메일 형식입니다.");
			$(".email").css("display", "inherit");
			$("#email").css("border", "1px solid #ff6e6e");
			emailChk = false;
			return false;
		}
	});

	/* 이메일 같은지 체크 */
	$("#confirmEmail").change(function () {
		var email = $("#email").val();
		var check = $("#confirmEmail").val();

		if (email == check) {
			$(".confirm").css("display", "none");
			$("#email").css("border", "");
			confirmChk = true;
			return true;
		} else {
			$(".confirm").css("display", "inherit");
			$("#email").css("border", "1px solid #ff6e6e");
			confirmChk = false;
			return false;
		}
	});

	/* 비밀번호 유효성 체크 */
	$("#password").change(function () {
		var pwd = $("#password").val();
		var chk_num = pwd.search(/[0-9]/g);
		var chk_eng = pwd.search(/[a-z]/ig);
		var chk1, chk2 = false;

		/* 8자 이상 확인 */
		if (pwd.length < 8) {
			$(".overChk").css("display", "none");
			$("#password").css("border", "1px solid #ff6e6e");
			chk1 = false;
		} else {
			$(".overChk").css("display", "inline-block");
			$(".over8Word").css("color", "white");
			$("#password").css("border", "");
			chk1 = true;
		}

		/* 숫자+영문 확인 */
		if (chk_num < 0 || chk_eng < 0) {
			$(".mixChk").css("display", "none");
			$("#password").css("border", "1px solid #ff6e6e");
			chk2 = false;
		} else {
			$(".mixChk").css("display", "inline-block");
			$(".mixNumAlphabet").css("color", "white");
			$("#password").css("border", "");
			chk2 = true;
		}
		
		if(chk1 == true && chk2 == true){
			pwChk = true;
		}
		else{
			pwChk = false;
		}
	});
	
	$("#joinForm input").change(function() {
		if(nickChk == true && emailChk == true && confirmChk == true && pwChk == true) {
			$(".join").attr("disabled", false);
		} else {
			$(".join").attr("disabled", true);
		}
	});
});
