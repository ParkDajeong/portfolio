$(document).ready(function () {
	var nickChk = false;
	var house = $("#user_house").val();
	$("input:radio[name ='house']:input[value='"+ house +"']").prop("checked", true);
	
	/* 닉네임 수정 전, 중복 체크 */
	$("#checkNicknamel").click(function() {
		var objParam = {
				nickname	: $("#user_nickname").val()
		}
		
		$.ajax({
			url			: "/join/check/nickname",
			dataType	: "json",
			data		: objParam,
			type		: "POST",
			success		: function(retVal) {
    			if(retVal.result == "overlap"){
    				$(".nameResult").text("사용 중인 닉네임입니다.");
    				$(".nameResult").css("color", "red");
    				nickChk = false;
    			} else{
    				$(".nameResult").text("사용 가능한 닉네임입니다.");
    				$(".nameResult").css("color", "blue");
    				nickChk = true;
    			}
    		},
    		error		: function(request, status, error){
    			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
	
	/* 닉네임 수정 */
	$("#nickname_change").click(function() {
		if(!nickChk){
			alert("중복 조회를 먼저 해주세요.")
		} else {
			var objParam = {
					email		: $("#user_email").val(),
					nickname	: $("#user_nickname").val()
			}
			
			$.ajax({
				url			: "/update/nickname",
				dataType	: "json",
				data		: objParam,
				type		: "POST",
				success		: function(retVal) {
	    			if(retVal.result == "success"){
	    				$(".nameResult").text("닉네임 변경이 완료되었습니다.");
	    				$(".nameResult").css("color", "blue");
	    				nickChk = false;
	    			} else{
	    				$(".nameResult").text("변경에 실패하였습니다.");
	    				$(".nameResult").css("color", "red");
	    			}
	    		},
	    		error		: function(request, status, error){
	    			console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		}
	});
	
	/* 비밀번호 변경 */
	$("#change_pwd").click(function() {
		var current_pwd = $("#current_pwd").val();
		var new_pwd = $("#new_pwd").val();
		var check_pwd = $("#check_pwd").val();
		var chk_num = new_pwd.search(/[0-9]/g);
		var chk_eng = new_pwd.search(/[a-z]/ig);
		
		var objParam = {
				email		: $("#user_email").val(),
				current_pwd		: current_pwd,
				new_pwd			: new_pwd
		}
		
		if(!current_pwd || !new_pwd || !check_pwd) {
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
		
		if(new_pwd != check_pwd) {
			$(".sameChk").css("display", "block");
			return;
		} else {
			$(".sameChk").css("display", "none");
		}
		
		$.ajax({
			url			: "/update/password",
			dataType	: "json",
			data		: objParam,
			type		: "POST",
			success		: function(retVal) {
	    		if(retVal.result == "success"){
	    			alert("비밀번호 변경이 완료되었습니다.");
	    			$("#current_pwd").val("");
	    			$("#new_pwd").val("");
	    			$("#check_pwd").val("");
	    			
	    		} else{
	    			$(".currentChk").css("display", "block");
	    		}
	    	},
	    	error		: function(request, status, error){
	    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
	
	/* 기숙사 수정 */
	$("#choice_house").click(function() {
		var objParam = {
					email		: $("#user_email").val(),
					house		: $("input[name='house']:checked").val()
		}
		
		$.ajax({
			url			: "/update/house",
			dataType	: "json",
			data		: objParam,
			type		: "POST",
			success		: function(retVal) {
	    		if(retVal.result == "success"){
	    			alert("기숙사 선정이 완료되었습니다.");
	    		} else{
	    			alert("기숙사 선정에 실패하였습니다.");
	    		}
	    	},
	    	error		: function(request, status, error){
	    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
	
	/* 회원 탈퇴 */
	$("#delete_user").click(function() {
		var returnValue = confirm("정말 탈퇴하시겠습니까?");
		var objParam = {
				email		: $("#user_email").val(),
				password	: $("#password").val()
		}
		
		if(returnValue){
			$.ajax({
				url			: "/user/delete",
				dataType	: "json",
				data		: objParam,
				type		: "POST",
				success		: function(retVal) {
		    		if(retVal.result == "success"){
		    			alert("회원 탈퇴가 완료되었습니다.");
		    			location.replace("/logout");
		    			location.replace("/");
		    		} else{
		    			alert("비밀번호가 다릅니다. 다시 입력해주세요.");
		    		}
		    	},
		    	error		: function(request, status, error){
		    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
				}
			});
		} else{
			alert("우리 계속 봐요;)");
		}
	});
});
