<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Calendar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
 	
    <style type="text/css">
    	.gagyebuSection {
    	  position: relative;
		  text-align: center;
		  width: 100%;
		  height: 100%;
		  display: flex;
		  flex-direction: column;
		  align-items: center;
		  color: #4D4D4D;
		}
   		.breadcrumbs {
			font-size: 1.2vw;
			font-weight: bold;
			width: 100%;
			text-align: left;
			margin-top:2%;
			margin-left: 2%;
		}
		.calendar-container {
		  width: 85%;
 		  height: 70%;
		  padding: 10px;
		  
		}
		
		.calendar-header {
		  display: flex;
		  justify-content: center;
		  gap: 1vw;
		  align-items: center;
 		  margin-bottom: 10px;
		}
		
		.calendar-days {
		  display: grid;
		  grid-template-columns: repeat(7, 1fr);
		  /* 
		  grid-template-columns : CSS의 Grid 레이아웃에서 사용되는 속성(property) 중 하나로, 
		  그리드 컨테이너(grid container)의 열(column) 크기를 지정하는 것을 말한다.
		  repeat(7, 1fr) : 1행에 7개의 열이 있으며, 
		  각 열의 크기를 동일하게 1분의 1(fractional unit, fr)로 설정하라는 의미한다. */
		  font-weight: bold;
		  padding-bottom: 5px;
		}
		/* grid-template-columns 속성을 사용하여 그리드 컨테이너의 열 크기를 유연하게 조정할 수 있으며, 
		반응형 웹 디자인에서 유용하게 활용된다. 
		이렇게 함으로써 웹페이지의 레이아웃을 다양한 화면 크기와 장치에 맞추는데 도움이 된다. */
		
		.day {
		  padding: 5px;
		}
		/* 날짜 그리드 */
		.calendar-dates {
		  display: grid;
		  grid-template-columns: repeat(7, 1fr);
		  /* 행 높이를 균등하게 설정 */
	   	 /*  grid-auto-rows: 100%;  */
 		  grid-auto-rows: 100px; /* 각 행의 높이를 균등하게 설정 */
		  grid-gap: 5px;
		  width: 100%;
		  grid-gap: 10px; /* 그리드 셀 간의 간격 */
		  /* height: 80%; /* 부모 높이에 맞추기 */ */
		  
		}
		.date {
		  cursor: pointer;
		  padding: 5px;
		  border-radius:20px;
		  background-color: white;
		  box-sizing: border-box;
		}	
		.date:hover {
		  background-color: #EFEEFE;
		}
		#detailView{
			width: 33%;
			height: 100%;
			background-color: white;
			position: absolute;
			right: 0;
			display: none;
			padding: 10px;
			
		}
		.closeBtnDiv{
			display: flex;
			justify-content: end;
		}
		#closeBtnImg{
			width: 30px;
		}
		.list {
			display: none;
		}
		#form{
			position: absolute;
			bottom: 0;
			width: 100%;
			border: 1px solid blue;
		}
		#createBtn{
			width: 28px;
			margin-top: 10px;
		}
		.editBtn, .deleteBtn {
			width: 20px;
			height: 20px;
		}
		.inputstyle{
			border: 1px solid black;
		}
		#prevBtn, #nextBtn{
			position: relative;
			width: 20px;
			height: 20px;
		}
		#prevBtn > img, #nextBtn > img{
			width: 100%;
			height: 100%;
		}
		#currentMonth{
			font-size: 24px;
		}
		.datContainer{
			height: 100%;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
		}
		/* 일자 */
		.dateSpan{	
			width: 100%;
			text-align: left;
			padding-left: 12px;
			font-size: 20px;
		}
		.transactionPriceDiv{
		}
		.tdeposit, .texpense{
			text-align: right;
			padding-right: 12px;
			font-size: 16px;
		}
		.tdeposit{
			color: #D65B8F;
		}
		.texpense{
			color: #5E9EFA;
		}
		#selectDate{
			text-align: left;
			font-size: 22px;
			font-weight: bold;
			margin-bottom: 10px;
		}
		.transactionRecord{
			display: flex;
			justify-content: space-between;
			align-items: center;
			border: 1px solid lightgray;
			padding: 10px 5px;
			margin-bottom: 10px;
			font-weight: bold;
		}
		.recordLabel{
			
		}
		.recordTitle{
		
		}
		.recordPrice{
		}
    </style>
    <script type="text/javascript">
    	$(()=>{
    		const calendarDates = document.getElementById("calendarDates"); // 달력을 붙일 div
    		const currentMonthElement = document.getElementById("currentMonth"); // 현재 월
    		const prevBtn = document.getElementById("prevBtn"); // 이전 버튼
    		const nextBtn = document.getElementById("nextBtn"); // 다음 버튼
    		const currentDate = document.getElementById("date");

    		const today = new Date(); // 현재 날짜를 나타내는 Date 객체를 저장
    		let currentMonth = today.getMonth(); // 현재 월 저장. getMonth(): 0부터 시작하는 월을 반환. (1월은 0, 2월은 1 반환)
    		let currentYear = today.getFullYear(); // 현재연도 저장
    		 
    		// 날짜 클릭 상세 페이지 구성
    		function handleDateClick(event) {
    			const clickDate = $(event.target).closest(".date");
    			//clickDate.textContent
    		//오른쪽 창 표시
    		  $('#detailView').attr("style","display: block");
    		  $('#selectDate').html(clickDate.text().split("+")[0]+"일");
    		 let cid = clickDate.find("input[type='hidden']").val();
    		 let html2 = "";
    		 for(let t=0; t<$('.'+cid).length; t++){
    			 let deposit = "";
    			 let isDeposit = $('.'+cid).eq(t).attr('data-isDeposit');
    			 if(isDeposit == "true") deposit="입금" 
    			 else if(isDeposit == "false")deposit="출금" 
    			 //transactions 채워넣는 부분 
		    	html2+=	"<div class='transactionRecord'><div class='recordLabel'>" +
    			  deposit + "</div>"+ "<div class='recordTitle'>" +
    			 $('.'+cid).eq(t).attr('data-title') + "</div><div class='recordPrice'>" + 
    			 $('.'+cid).eq(t).attr('data-price')+"원</div>"  +
    		      	/* "<div><img alt='수정' src='./image/수정.png' class='editBtn'>"+ */
    		      	"<img alt='삭제' src='./image/삭제.png' class='deleteBtn'>"+
    		      	"<input type='hidden' value='"+$('.'+cid).eq(t).attr('data-id')+"'>"+
    		      "</div>";
    		 }
    		 
    		 $('#transactions').html(html2);
    		 //폼 감추기
    		  $('#form').attr("style","display: none");
    		  $('#transactionDate').val(cid);
    		}

    		// renderCalendar 함수는 월별 캘랜더를 생성하고 표시하는 함수
    		function renderCalendar() {
    		  const firstDayOfMonth = new Date(currentYear, currentMonth, 1); // 현재 월의 첫 번째 날짜를 나타내는 Date 객체를 저장, 해당 월의 첫 번째 날짜에 대한 정보를 얻는다.
    		  const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate(); // 현재 월의 총 일 수를 나타내는 값을 저장, 해당 월이 몇 일까지 있는지 알 수 있다.
    		  const startDayOfWeek = firstDayOfMonth.getDay(); // 현재 월의 첫 번째 날짜의 요일을 나타내는 값을 저장. 해당 월의 첫 번째 날짜가 무슨 요일인지 알 수 있다.
    		  currentMonthElement.textContent = currentYear+"년"+(currentMonth + 1)+"월"; // 현재 월과 연도를 설정하여 표시

    		  calendarDates.innerHTML = ""; // 일자를 표시하는 그리드 컨테이너를 비운다

    		  // 빈 날짜(이전 달)
    		  for (let i = 0; i < startDayOfWeek; i++) {
    		    const emptyDate = document.createElement("div"); //  빈 날짜를 나타내는 div 요소를 생성
    		    emptyDate.classList.add("date", "empty"); // 생성한 div 요소에 "date"와 "empty" 클래스를 추가
    		    calendarDates.appendChild(emptyDate); // 생성한 빈 날짜 요소를 캘린더 그리드에 추가
    		  }

    		  // 현재 달의 날짜
    		  /* 
    		    1. for 문을 이용하여 현재 월의 총 일 수만큼 반복하여 월의 날짜를 순서대로 표시한다.
    		    2. const dateElement = document.createElement("div");를 통해 날짜를 나타내는 div 요소를 생성한다.
    		    3. dateElement.classList.add("date");를 통해 생성한 div 요소에 "date" 클래스를 추가한다.
    		    4. dateElement.textContent = i;를 통해 해당 날짜 값을 div 요소의 텍스트로 설정한다.
    		    5. 날짜와 해당 날의 총 입금액과 지출액을 추가한다.
    		    6. calendarDates.appendChild(dateElement);를 통해 생성한 날짜 요소를 캘린더 그리드에 추가한다.
    		  */
    		  for (let i = 1; i <= daysInMonth; i++) {
    		    const dateElement = document.createElement("div");
    		    dateElement.classList.add("date");
    		    
    		 // currentMonth와 i를 두 자리 숫자로 변환
    		    let formattedMonth = (currentMonth + 1).toString().padStart(2, '0'); // 월이 1부터 시작하므로 +1
    		    let formattedDay = i.toString().padStart(2, '0'); // 일자도 두 자리로 변환

    		    // classid 생성 ('2024-09-02' 형식)
    		    let classid = currentYear + "-" + formattedMonth + "-" + formattedDay;
    		    var tdeposit = 0;
    		    var texpense = 0;
    		    var isDeposit="";
    		    var price = "";
    		    //deposit,price 값 뽑아내기
    		    $('.'+classid).each(function(index,item){
    		    	isDeposit += $(item).attr("data-isDeposit")+",";
    		    	price += $(item).attr("data-price")+",";
    		    });
    		    
    		    //split으로 배열 만들기
    		    let arrayIsDeposit= isDeposit.split(",");
    		    let arrayPrice = price.split(",");
    		    //조건식
    		    for(let t=0; t<arrayIsDeposit.length;t++){
    		    	if(arrayIsDeposit[t]=="true")tdeposit += arrayPrice[t]*1;
    		    	else if(arrayIsDeposit[t]=="false") texpense += arrayPrice[t]*1;
    		    }
    		    if(tdeposit == "") tdeposit=0;
    		    if(texpense == "") texpense=0;
    		    let html ="<div class='datContainer'><div class='dateSpan'>"+i+"</div>"
				+"<div><div class='tdeposit'>+"+tdeposit+"</div>"
				+"<div class='texpense'>-"+texpense+"</div></div></div>"
				+"<input type='hidden' value='"+classid+"' name='cid'>";
				+"<input type='hidden' value='"+$('')+"' name='cid'>";
    		    dateElement.innerHTML=  html;  		    
    		    dateElement.addEventListener("click", handleDateClick); // 클릭 이벤트 추가
    		    calendarDates.appendChild(dateElement);
    		  }
    		}

    		renderCalendar(); // 페이지가 로드되면 renderCalendar 함수를 실행하여 초기 캘린더를 표시한다

    		prevBtn.addEventListener("click", () => {
    		  currentMonth--;
    		  if (currentMonth < 0) {
    		    currentMonth = 11;
    		    currentYear--;
    		  }
    		  renderCalendar();
    		});
    		/* 
    		1. 이전 버튼(prevBtn)을 클릭하면 현재 월을 이전 월로 변경하고, 연도가 바뀌어야 한다면 연도를 변경한다.
    		2. 변경된 월과 연도를 바탕으로 renderCalendar 함수를 호출하여 이전 월의 캘린더를 표시한다.
    		*/

    		nextBtn.addEventListener("click", () => {
    		  currentMonth++;
    		  if (currentMonth > 11) {
    		    currentMonth = 0;
    		    currentYear++;
    		  }
    		  renderCalendar();
    		});
    		/* 
    		1. 다음 버튼(nextBtn)을 클릭하면 현재 월을 다음 월로 변경하고, 연도가 바뀌어야 한다면 연도를 변경한다.
    		2. 변경된 월과 연도를 바탕으로 renderCalendar 함수를 호출하여 다음 월의 캘린더를 표시한다.
    		*/
    		// detailView JS
    		$('#closeBtnImg').on("click",function(){
    			$('#detailView').attr("style","display: none");
    		});//오른쪽 창 닫기
    		$('#createBtn').on("click",function(){
    			$('#form').attr("style","display: block");
    			$('#editgagyebu').attr("style","display: none");
    			$('#creategagyebu').attr("style","display: block");
    			
    		});//등록버튼
    		
    		$(document).on('click', '.editBtn', function() {
    			$('#form').attr("style","display: block");
    			$('#creategagyebu').attr("style","display: none");
    			$('#editgagyebu').attr("style","display: block");
    		});//수정버튼
			
    		$(document).on('click', '.deleteBtn', function(deleteEvent) {
				let check = confirm("해당 가게부를 삭제할까요?");
				if(check){
					let gid = $(deleteEvent.target).next().val();
					alert(gid);
					location.href="deleteGagyebu.do?gagyebuId="+gid;
				}else{
					return;
				}
     		});//삭제버튼
    		
    	})//ready
    </script>
  </head>
  <div class="gagyebuSection">
 			<div class="breadcrumbs">가계부 월별 가계부</div>
    <div class="calendar-container">
      <div class="calendar-header">
        <button id="prevBtn">
        	<img src="${pageContext.request.contextPath}/image/prevArrow.jpg" alt="이전">
        </button>
        <span id="currentMonth"></span>
        <button id="nextBtn">
        	<img src="${pageContext.request.contextPath}/image/nextArrow.jpg" alt="이전">
        </button>
      </div>
     
      <div class="calendar-days">
        <div class="day">일</div>
        <div class="day">월</div>
        <div class="day">화</div>
        <div class="day">수</div>
        <div class="day">목</div>
        <div class="day">금</div>
        <div class="day">토</div>
      </div>
      <div class="calendar-dates" id="calendarDates"></div>
    </div>
    <div id="detailView">
    	<div class="closeBtnDiv"><img alt="" src="./image/닫기.png" id="closeBtnImg"></div>
    	<div id="selectDate"></div>
    	<div id="transactions"></div>
    	
    	<div id="form">
    		<form action="createGagyebu.do" method="post">
    			<input type="hidden" name="transactionDate" id="transactionDate">
    			<select name="isDeposit" id="isDeposit">
    				<option value="true">입금</option>
    				<option value="false">지출</option>
    			</select>
    			<input type="radio" name="userId" value="${user.id}">${user.nickname}
    			<input type="radio" name="userId" value="${partner.id}">${partner.nickname}
    			<br>
    			<input type="text" class="inputstyle" name="price" placeholder="금액"><br>
    			<input type="text" class="inputstyle" name="title" placeholder="제목"><br>
    			<input type="text" class="inputstyle" name="etc" placeholder="비고"><br>
    			<input type="submit" id="creategagyebu" value="등록">
    			<input type="button" id="editgagyebu" value="수정">
    		</form>
    	</div>
    	<!-- 추가버튼 -->
    	<img alt="" src="./image/추가.png" id="createBtn">
   		</div>
    
	<div class="list">
		<c:forEach items="${gagyebus}" var="gagyebu">
			<div class="${gagyebu.transactionDate}" data-isDeposit="${gagyebu.isDeposit}" 
			data-price="${gagyebu.price}" data-title="${gagyebu.title}" data-id="${gagyebu.id}" >
			${gagyebu}</div>
		</c:forEach>
	</div>
  </div>
 
</html>
