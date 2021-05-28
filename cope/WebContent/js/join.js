	$(function(){
	$("#clientId").blur("input",function(){
		var id = $(this).val();
		var regexId = /^[a-zA-Z0-9]{8,20}$/;
		if(regexId.test(id)){
			$(this).nextAll(".fail").hide();
			$(this).nextAll(".success").show();

		}
		else{
		$(this).nextAll(".success").hide();
		$(this).nextAll(".fail").show();
				    $(this).focus();
		}
	});	
		
		$("#clientPw").blur("input",function(){
			var pw = $(this).val();
			var regexPw = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
			if(regexPw.test(pw)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw").show();
				$(this).off();
			}
			else{
			$(this).nextAll(".failPw").show();
			$(this).nextAll(".success").hide();
			}
		});	
	
		$("#clientPw2").blur("input",function(){
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
		
		$("#clientNick").blur("input",function(){
			var nick = $(this).val();
			var regexNick = /^[가-힣a-zA-Z0-9!@#$%^&*]{1,30}$/;
			if(regexNick.test(nick)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".success").show();
			}
			else{
			$(this).nextAll(".fail").show();
			$(this).nextAll(".success").hide();
			}
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
    
      $(".join-form").on("submit", function(e){
		var id = $("#clientId").val();
		var regexId = /^[a-zA-Z0-9]{8,20}$/;
		var pw = $("#clientPw").val();
		var regexPw = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
		var nick = $("#clientNick").val();
		var regexNick = /^[가-힣a-zA-Z0-9!@#$%^&*]{1,30}$/;
        if(!regexId.test(id)||!regexPw.test(pw)||!regexNick.test(nick)){
        e.preventDefault();
        window.alert("형식이 잘못되었습니다.");
        }
    });   
    	});