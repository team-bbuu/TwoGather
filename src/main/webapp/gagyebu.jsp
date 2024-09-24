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
		  justify-content: center;
		  align-items: center;
		  border: 1px solid red;
		}
		
		.calendar-container {
		  width: 100%;
		  height: 100%;
		  margin: 30px auto;
		  border: 1px solid #ccc;
		  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		  padding: 10px;
		  background-color: #fdefde;
		  border: 3px solid red;
		}
		
		.calendar-header {
		  display: flex;
		  justify-content: space-between;
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
		  border-bottom: 1px solid #ccc;
		  padding-bottom: 5px;
		}
		/* grid-template-columns 속성을 사용하여 그리드 컨테이너의 열 크기를 유연하게 조정할 수 있으며, 
		반응형 웹 디자인에서 유용하게 활용된다. 
		이렇게 함으로써 웹페이지의 레이아웃을 다양한 화면 크기와 장치에 맞추는데 도움이 된다. */
		
		.day {
		  padding: 5px;
		}
		
		.calendar-dates {
		  display: grid;
		  grid-template-columns: repeat(7, 1fr);
		  grid-gap: 5px;
		}
		
		.date {
		  cursor: pointer;
		  padding: 5px;
		  border: 1px solid black;
		}
		
		.date:hover {
		  background-color: #f5f5f5;
		}
		#detailView{
			border: 1px solid black;
			width: 30%;
			height: 100%;
			background-color: white;
			position: absolute;
			right: 0;
			display: none;
			
		}
		#closeBtnImg{
			width: 10%;
			margin-left: 80%;
		}
		
		.list {
			border: 1px solid red;
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
    			const clickDate = event.target;
    			//clickDate.textContent
    		  $('#detailView').attr("style","display: block");
    		  $('#selectDate').html(clickDate.textContent.split("+")[0]);
    		  
    		  console.log("clickDate : ")
    		
    		 
    		//  let daytransactiondata = for()
    		  //$('#transactions').html("");
    		  $('#form').attr("style","display: none");
    		  
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
    		    var tdeposit = "";
    		    var texpense = "";
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
    		    	if(arrayIsDeposit[t]=="true")tdeposit += arrayPrice[t];
    		    	else if(arrayIsDeposit[t]=="false") texpense += arrayPrice[t];
    		    }
    		    if(tdeposit == "") tdeposit=0;
    		    if(texpense == "") texpense=0;
    		    let text ="<div>"+i+"<br>"
				+"+"+tdeposit+"<br>"
				+"-"+texpense+"</div>";
    		    dateElement.innerHTML=  text;  		    
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
    		});
    	})
    </script>
  </head>
  <div class="gagyebuSection">
    <div class="calendar-container">
      <div class="calendar-header">
        <button id="prevBtn">이전</button>
        <h2 id="currentMonth"></h2>
        <button id="nextBtn">다음</button>
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
    	<img alt="" src="./image/a.png" id="closeBtnImg"><br>
    	<div id="selectDate">
    		
    	</div>
    	<div id="transactions">2</div>
    	<div id="form">
    		3
    	</div>
    </div>
    
	<div class="list">
		<c:forEach items="${gagyebus}" var="gagyebu">
			<div class="${gagyebu.transactionDate}" data-isDeposit="${gagyebu.isDeposit}" 
			data-price="${gagyebu.price}" >
			${gagyebu}</div>
		</c:forEach>
	</div>
  </div>
 
</html>
