<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
		<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
		    <script src="https://code.jquery.com/jquery-latest.js"></script> 
		    <script>
      //마스크 자바스크립트
    function wrapWindowByMask(){
        //화면의 높이와 너비를 구한다.
        var maskHeight = $(document).height();  
        var maskWidth = $(window).width();  

        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({'width':maskWidth,'height':maskHeight});  

        //애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
        $('#mask').fadeIn(1000);      
        $('#mask').fadeTo("slow",1);    

        //윈도우 같은 거 띄운다.
        $('.window').show();
    }

    $(document).ready(function(){
        //검은 막 띄우기
        $('.openMask').click(function(e){
            e.preventDefault();
            wrapWindowByMask();
        });

        //닫기 버튼을 눌렀을 때
        $('.window .close').click(function (e) {  
            //링크 기본동작은 작동하지 않도록 한다.
            e.preventDefault();  
            $('#mask, .window').hide();  
        });       

        //검은 막을 눌렀을 때
        $('#mask').click(function () {  
            $(this).hide();  
            $('.window').hide();  
        });      
    });
    // 마스크 자바스크립트 끝
    </script>
    <style>
    /* 마스크 스타일*/
    #mask {  
      position:absolute;  
      z-index:9000;  
      background-color:#929292;  
      display:none;  
      width : 100%;
      height : 100%;
    }
    .window{
          background-color:white;  
    border: solid black;
      display: none;
      z-index:10000;
          position: fixed;
    width: 40%;
    left: 50%;
    margin-left: -20%; /* half of width */
    height: 50%;
    top: 50%;
    margin-top: -150px; /* half of height */
    overflow: auto;
      
    }
    /* 마스크 스타일 끝*/
    
    .width-auto{
    width:auto;
    }
    
   .mini-font{
   font-size: 14px;
   }
   
    .hr{
    border: 0px;
    width: 100%;
    height:2px;
    background:#9A9EC2;
    }

.box1{
padding : 30px;
}

  	</style>

  		  			<span>&nbsp;</span>
  		  			<span>&nbsp;</span>
  	<div class = " inline-block">
	  <div class = " text-center mini-font text-left">
	  		<div class = "width-auto box1">
	  		<a href = "<%=request.getContextPath()%>/info.jsp" class = "text-decoration-none" >
	  			<label style ="cursor: pointer;">Info</label></a>
	  				  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  			<span>&nbsp;</span>
	  			<span>Privacy Policy</span>	
	  			<span>&nbsp;</span>
	  			<span>·</span>
	  			<span>&nbsp;</span>
	  			    <div id="mask"></div>
    <div class="window">
        <pre>KH정보교육원 회원 약관

제 1 장 총칙

제 1 조 목적

이 약관은 KH정보교육원이 제공하는 서비스인 http://www.iei.or.kr의 이용조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조 약관의 효력과 변경

1) 약관은 이용자에게 공시함으로써 효력을 발생합니다.

2) KH정보교육원은 교육원 사정상 변경의 경우와 영업상 중요사유가 있을 때 약관을 변경할 수 있으며, 변경된 약관은 전항과 같은 방법으로 효력을 발생합니다.

제 3 조 약관 외 준칙

이 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.


제 2 장 회원 가입과 서비스 이용

제 1 조 이용 계약의 성립

1)KH정보교육원에서 운영하는 모든 회원서비스는 이 약관에 동의한 이용자들에게 무료로 제공 되는 서비스입니다.
이용자가 "동의합니다" 버튼을 누르면 이 약관에 동의하는 것으로 간주됩니다.

2) 회원에 가입하여 서비스를 이용하고자 하는 희망자는 회사에서 요청하는 개인 신상정보를 제공해야 합니다.

3) 등록정보
KH정보교육원은 이용자 등록정보를 집단적인 형태로 사용할 수는 있지만 각 이용자 개인 정보는, 불법적이거나 기타 다른 불온한 문제를 일으킬 경우를 제외하고, 이용자의 동의 없이는 절대 공개하지 않습니다.
KH정보교육원을 이용하여 타인에게 피해를 주거나 미풍양속을 해치는 행위를(즉 욕설, 비방성글, 인신공격성 발언, 사회적질서를 혼란시키는 유언비어등)한 이용자는 회원자격이 박탈되며, 이로 인해 발생되는 모든 사회적문제는 KH정보교육원에서 책임지지 않습니다.

4) 약관의 수정
KH정보교육원은 이 약관을 변경할 수 있으며 변경된 약관은 서비스 화면에 게재하거나 기타 다른 방법으로 이용자에게 공지함으로써 효력을 발생합니다.

5) ID와 패스워드
이용자번호(ID)와 비밀번호(password)에 관한 모든 관리책임은 이용자에게 있습니다.
이용자에게 부여된 이용자번호(ID) 및 비밀번호(password)의 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 책임은 이용자에게 있습니다.
자신의 ID가 부정하게 사용된 경우 이용자는 반드시 KH정보교육원에 그 사실을 통보해야 합니다.

6) 사용자 정보
KH정보교육원에 기재하는 모든 이용자 정보는 이름을 포함하여 모두 실제 데이타인 것으로 간주됩니다.
실명이나 실제 정보를 입력하지 않은 사용자는 법적인 보호를 받을 수 없으며, KH정보교육원의 서비스 제한 조치를 받을 수 있습니다.

7) 광고 게재 및 컨텐츠 제휴
KH정보교육원은 광고수익과 컨텐츠 제휴를 기반으로 컨텐츠 서비스를 제공하고 있습니다.
KH정보교육원의 서비스를 이용하고자 하는 이용자는 광고게재및 컨텐츠제휴에 대해 동의하는 것으로 간주됩니다.


제 3 장 계약 해지 및 서비스 이용제한

제 1 조 계약 해지 및 이용제한

이용자가 이용 계약을 해지 하고자 하는 때에는 이용자 본인이 직접 온라인을 통해 관리자에게 메일을 보내어 해지 신청을 하여야 합니다.

회사는 이용자가 다음 사항에 해당하는 행위를 하였을 경우 사전 통지 없이 이용 계약을 해지 하거나 또는 기간을 정하여 서비스 이용을 중지할 수 있습니다.

(1) 공공 질서 및 미풍 양속에 반하는 경우

(2) 범죄적 행위에 관련되는 경우

(3) 이용자가 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행 할 경우

(4) 타인의 서비스 아이디 및 비밀 번호를 도용한 경우

(5) 타인의 명예를 손상시키거나 불이익을 주는 경우

(6) 같은 사용자가 다른 아이디로 이중 등록을 한 경우

(7) 서비스에 위해를 가하는 등 서비스의 건전한 이용을 저해하는 경우

(8) 기타 관련법령이나 회사가 정한 이용조건에 위배되는 경우

제 2 조 이용 제한의 해제 절차

(1) 회사는 규정에 의하여 이용제한을 하고자 하는 경우에는 그 사유, 일시 및 기간을 정하여 서면 또는 전화 등의 방법에 의하여 해당 이용자 또는 대리인에게 통지합니다. 다만, 회사가 긴급하게 이용을 정지할 필요가 있다고 인정하는 경우에는 그러하지 아니합니다.

(2) 제1항의 규정에 의하여 이용정지의 통지를 받은 이용자 또는 그 대리인은 그 이용정지의 통지에 대하여 이의가 있을 때에는 이의신청을 할 수 있습니다.

(3) 회사는 제2항의 규정에 의한 이의신청에 대하여 그 확인을 위한 기간까지 이용정지를 일시 연기할 수 있으며, 그 결과를 이용자 또는 그 대리인에게 통지합니다.

(4) 회사는 이용정지 기간 중에 그 이용정지 사유가 해소된 것이 확인된 경우 에는 이용정지조치를 즉시 해제합니다.

제 3 조 이용자의 게시물

회사는 이용자가 게시하거나 등록하는 서비스 내의 내용물이 다음 각 사항에 해당된다고 판단되는 경우에 사전 통지 없이 삭제할 수 있습니다.

(1) 다른 이용자 또는 제 3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우

(2) 공공질서 및 미풍 양속에 위반되는 내용인 경우

(3) 범죄적 행위에 결부된다고 인정되는 내용일 경우

(4) 제 3자의 저작권 등 기타 권리를 침해하는 내용인 경우

(5) 기타 관계 법령이나 회사에서 정한 규정에 위배되는 경우


제 4 장 계약변경 등

제 1 조 계약사항의 변경

(1) 이용자는 주소 또는 이용계약 내용을 변경하거나, 서비스 를 해지할 경우에는 전화나 서비스를 통해서 이용계약을 변경/ 해지하여야 합니다.


제 5 장 정보의 제공

제 1 조 정보의 제공

(1) 회사는 이용자가 서비스 이용 중 필요가 있다고 인정되는 다양한 정보에 대해서는 전자우편이나 서신우편 등의 방법으로 이용자에게 제공할 수 있습니다.


제 6 장 손해 배상
제 1 조

1) 손해배상
KH정보교육원은 서비스 이용과 관련하여 이용자에게 발생한 어떠한 손해에 관하여도 책임을 지지 않습니다.
서비스 이용으로 발생한 분쟁에 대해 소송이 제기될 경우 KH정보교육원의 소재지를 관할하는 법원을 관할법원으로 합니다.

[부 칙]


( 시 행 일 ) 이 약관은 2015년 01월 12일부터 시행합니다.</pre>
    </div>
    <a href="#" class="openMask text-decoration-none">
    <span style ="cursor: pointer;">Terms of Use</span>
    </a>
	  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  			<span>&nbsp;</span>
	  			<span>Contact Us</span>
	  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  				  				  			<span>&nbsp;</span>
	  			 <a href = "https://github.com/swjk78/codingpeople" class = "text-decoration-none" >
	  			 <span style ="cursor: pointer;">Git</span></a>
	  			   			 <div>
	  			<hr class = hr>
	  			</div> 
			<span>© 2021. <strong>CODINGPEOPLE.</strong> All rights reserved.</span>
	  		</div>
	  </div>
</div>
</html>