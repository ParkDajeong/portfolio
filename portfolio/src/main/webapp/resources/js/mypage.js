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
	    			nickChk = false;
	    		} else{
	    			alert("기숙사 선정에 실패하였습니다.");
	    		}
	    	},
	    	error		: function(request, status, error){
	    		console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
			}
		});
	});
});
