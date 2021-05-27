	$(function(){
	$("#clientId").on("input",function(){
		var id = $(this).val();
		var regex = /^[a-zA-Z0-9]{8,20}$/;
		if(regex.test(id)){
			$(this).nextAll(".fail").hide();
			$(this).nextAll(".success").show();
		}
		else{
		$(this).nextAll(".success").hide();
		$(this).nextAll(".fail").show();
		}
	});	
		
		$("#clientPw").on("input",function(){
			var pw = $(this).val();
			var regex = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
			if(regex.test(pw)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw").show();
				$(this).off();
			}
			else{
			$(this).nextAll(".failPw").show();
			$(this).nextAll(".success").hide();
			}
		});	
	
		$("#clientPw2").on("input",function(){
			var pw = $(this).val();
			var pw2 = $("#clientPw").val();
			if(pw==pw2){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw2").show();
			}
			else{
			$(this).nextAll(".failPw2").show();
			$(this).nextAll(".success").hide();
			}
		});	
		//비밀번호를 입력하지 않고, 비밀번호재입력칸을 입력했을때
		$("#clientPw2").blur("input",function(){
			var pw = $("#clientPw").val();
			var pw2 = $(this).val();
			if(pw==""){
				pw2 =$(this).val("");
				$("#clientPw").focus();
				$(this).nextAll(".firstPw").show();				
			}
		});	
		
		$("#clientNick").on("input",function(){
			var pw = $(this).val();
			var regex = /^[가-힣a-zA-Z0-9!@#$%^&*]{1,30}$/;
			if(regex.test(pw)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".success").show();
			}
			else{
			$(this).nextAll(".fail").show();
			$(this).nextAll(".success").hide();
			}
		});	
		
	});
	
    $(document).ready(function(){
        setDateBox();
    // select box 연도 표시
    function setDateBox(){
        var dt = new Date();
        var com_year = dt.getFullYear();

        $("#clientBirthYear").append("");
        for(var y = 1950; y <= com_year; y++){
            $("#clientBirthYear").append("<option value='"+ y +"'>"+ y +"</option>");
        }
    }
    });   