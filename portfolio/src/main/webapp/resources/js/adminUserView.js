$(document).ready(function () {
	var house = $("#user_house").val();
	$("input:radio[name ='house']:input[value='"+ house +"']").prop("checked", true);
	
	/* 비밀번호 변경 */
	$("#change_pw").click(function() {
		var new_pwd = $("#new_pwd").val();
		var chk_num = new_pwd.search(/[0-9]/g);
		var chk_eng = new_pwd.search(/[a-z]/ig);
		
		if(!new_pwd) {
			alert("빈 칸을 채워주세요.");
			return;
		}
		
		/* 8자 이상 확인 */
		if (new_pwd.length < 8) {
			$(".newChk").css("color", "red");
			return;
		} else {
			$(".newChk").css("color", "black");
		}

		/* 숫자+영문 확인 */
		if (chk_num < 0 || chk_eng < 0) {
			$(".newChk").css("color", "red");
			return;
		} else {
			$(".newChk").css("color", "black");
		}
		
		var objParam = {
				email		: $("#user_email").val(),
				new_pwd			: new_pwd
		}
		
		$.ajax({
			url			: "/admin/update/password",
			dataType	: "json",
			data		: objParam,
			type		: "POST",
			success		: function(retVal) {
	    		if(retVal.result == "success"){
	    			alert("비밀번호 변경이 완료되었습니다.");
	    		} else{
	    			alert("변경이 정상적으로 이뤄지지 않았습니다. 다시 시도해주세요.");
	    		}
	    		$("#new_pwd").val("");
	    	},
	    	error		: function(request, status, error){
	    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
	
	$("#mail_auth").click(function() {
		$.ajax({
			url			: "/admin/update/auth",
			dataType	: "json",
			data		: {email : $("#user_email").val()},
			type		: "POST",
			success		: function(retVal) {
	    		if(retVal.result == "success"){
	    			alert("메일 인증이 완료되었습니다.");
	    		} else{
	    			alert("인증이 정상적으로 이뤄지지 않았습니다. 다시 시도해주세요.");
	    		}
	    		location.href = "/admin/user/view";
	    	},
	    	error		: function(request, status, error){
	    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
});
