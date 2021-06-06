<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/miniFooterSide.css">
<head>
<meta charset="UTF-8">

</head>

<div class = display>
<div class = "text-center">
	<a href= "<%=request.getContextPath()%>/index.jsp">
<img src = "<%=request.getContextPath()%>/image/example.png" class = "containerimg">
</a>
 </div>

  		<div class = "blue-box-contact">방문 및 연락</div>
		<div class = "border-footer-side-contact" >
			<div class = "footer-side-text-left">
        
        <strong>주 소</strong> : (07212) 서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F,20F<br>
        <strong>TEL</strong> : 02)1544-9970<span>&nbsp;</span><span>·</span><span>&nbsp;</span>   
        <strong>FAX</strong> :  02)2163-8560<span>&nbsp;</span><span>·</span><span>&nbsp;</span> 
        <strong>사업자등록번호</strong> : 876-85-00632<span>&nbsp;</span><span>·</span><span>&nbsp;</span>   
        <strong>기관명</strong> : Coding People<span>&nbsp;</span><span>·</span><span>&nbsp;</span>  
        <strong>관리자</strong> : 김진규, 소경수, 윤준혁, 이석현, 이창엽<br><br>
        <strong>오시는 길</strong> : 지하철 2, 9호선 당산역 12번 출구 400m
        
<!--         여기서 사이즈를 지정합니다 -->
		<div id="cope-location" style="width:100%;height:400px;"></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f57a5e791dbd78116ad7a86d5b20eb21"></script>
		
		<script>
			var mapContainer = document.getElementById('cope-location'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new kakao.maps.LatLng(37.533783, 126.896876), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			  
			// 마커를 표시할 위치입니다 
			var position =  new kakao.maps.LatLng(37.533783, 126.896876);
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			  position: position,
			  clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
			});
			
			// 아래 코드는 위의 마커를 생성하는 코드에서 clickable: true 와 같이
			// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
			// marker.setClickable(true);
			
			// 마커를 지도에 표시합니다.
			marker.setMap(map);
			
			// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
			var iwContent = '<div style="padding:5px;"><a style="text-decoration: none; font-size-15px; color:blue;" href="https://www.naver.com">!Coding People!</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent,
			    removable : iwRemoveable
			});
			
			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
			      // 마커 위에 인포윈도우를 표시합니다
			      infowindow.open(map, marker);  
			});
			</script>

			</div>
		</div>
		</div>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>