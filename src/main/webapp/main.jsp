<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Calendar, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<meta charset="UTF-8">
	<title>메인</title>
	 <!-- CDN -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<style type="text/css">
		/* a태그의 기본 속성 제거 */
	    .no-style {
	        color: inherit; /* 부모 요소의 색상 사용 */
	        text-decoration: none; /* 밑줄 제거 */
	        cursor: pointer; 
	    }
		.mainSection {
			width: 100%;
			height: 100%;
			padding: 2%;
			background: #F6F6FE;
			color: #4D4D4D;
		}
		.mainContainer{
			height: 100%;
			display: flex;
			flex-direction: column;
			gap: 2%;
		}
		.breadcrumbs {
			font-size: 1.2vw;
			font-weight: bold;
			margin-bottom: 1vw;
		}
		.section1, .section2 {
			width: 100%;
			display: flex;
/* 			border: 1px solid green; */
			gap: 10px;	
		}
		.section1 {
			height: 42%;

		}
		.section2 {
			height: 48%;
		}
		.item{
			position: relative;
			background: #FFF;
			border-radius: 20px;
			padding: 2%;			
		}
		.storySection{
			width: 50%;
/* 			border: 1px solid red; */
		}
		.scheduleSection{
			width: 50%;
/* 			border: 1px solid blue; */
		}
		.algorithmSection{
			width : 30%;
/* 			border: 1px solid red; */
		}
		.chartSection{
			width : 70%;
/* 			border: 1px solid blue;		 */
		}
		.label {
			font-size: 1.2vw;
			font-weight: bold;
			margin-bottom: 1vw;
			bottom : 0;
		}
		.moreBtn{
			cursor: pointer;
			color: gray;
			font-size: 1vw;
			text-align: right;
			position: absolute;
			bottom: 1vw;
			right: 1vw;
		}
		
		/* 각 section 스타일 */
		.stroyDiv{
			display: flex;
			height: 60%;
			gap: 1vw;
		}
		.storyRight{
			width: 50%;
		}
		.imageContainer {
			position: relative;
			width: 50%;
		}
		.imageContainer img {
	        width: 100%;
	        height: 100%;
	        object-fit: cover;
	        
		}
		.storyTitle {
			font-size: 1vw;
			font-weight: bold;
			margin-bottom: 0.3vw;
		}
		.storyContent{
			font-size: 1vw;
		}
		
		.transactionTitleDiv{
			display: flex;
			flex-direction: column;
			gap: 0.8vw;
			padding-top: 10px;
			
		}
		.algorithmTitle{
			font-size: 1vw;
		}
		.algorithmTitle div:last-of-type{
			text-align: right;	
		}
		.chart-container {
			height: 80%;
			display: flex;
			justify-content: center;
		}

		
	</style>
	</head>

	<section class="mainSection">
					<div class="breadcrumbs">메인</div>
		<div class="mainContainer">
			<div class="section1">
				<!-- 가장 가까운 일정 -->
				<div class="item scheduleSection">
					<div class="label">다가오는 일정</div>
					    <p>날짜 : ${schedule.startDate}</p>
					    <p>일정 : ${schedule.title}</p>
					    <p>상세 : ${schedule.description}</p>
					    <div id="dDayDisplay"></div> <!-- 디데이를 표시할 div -->
					<div class="moreBtn"><a class="no-style">일정 더보기</a></div>
				</div>
				
								<!-- 스토리 사진, 제목, 내용, 더보기 버튼 -->
				<div class="item storySection">
					<div class="label">최근 스토리</div>
					
					<div class="stroyDiv">
						<div class="imageContainer">
<%-- 						<img src="${pageContext.request.contextPath}/image/cat.jpg" alt="story-image"> --%>
							<img src="${pageContext.request.contextPath}/uploads/${story.imgSrc}" alt="story-image">
						</div>
						<div class="storyRight">
							<div class="storyTitle">${story.title}</div>
							<div class="storyContent">${story.content}</div>
						</div>
					
					</div>
					
					<div class="moreBtn"><a href="story.do" class="no-style">스토리 더보기</a></div>
				</div>
			</div>
			
			<div class="section2">
				<div class="item algorithmSection">
					<div class="label">적금계산기</div>
					<div class="algorithmTitle">
						목표금액:<br>
						<input type="number" name="targetAmount" id="targetAmount" min="0" placeholder="0">원
					</div>
					<div class="algorithmTitle">
						월 납입액<br>
						<input type="number" name="depositAmount" id="depositAmount" min="0" placeholder="0">원
					</div>
					<div class="algorithmTitle">
						이자율<br>
						<input type="number" name="interestRate" step="0.1" id="interestRate" min="0" max="100" placeholder="0.0">%
					</div>
					<div class="algorithmTitle form-check-inline">
						<label class="form-check-label" for="compound">
							<input type="radio" class="form-check-input" id="compound" name="isCompound" value="true" checked="checked">복리
						</label>
					</div>
					<div class="algorithmTitle form-check-inline">
						<label class="form-check-label" for="simple">
							<input type="radio" class="form-check-input" id="simple" name="isCompound" value="false">단리
						</label>
					</div>
					<div  class="algorithmTitle" id="algoResult"></div>
					<div class="moreBtn"><button type="button" class="btn btn-outline-primary" id="searchAlgo">알아보기</button></div>
				</div>	
					
				<!-- 가계부 곡선차트 : 1월 ~ 12월 입금, 지출 -->
				<div class="item chartSection">
					<div class="label">월별 입금, 지출 현황 </div>
					<div class="chart-container">
						<canvas id="line-chart"></canvas>
					
					</div>
				</div>
			</div>
		</div>
		

		<script type="text/javascript">
		    const schedules = ${schedule.startDate}; // 서버에서 전달받은 일정 데이터
		    
		    console.log("schedules : ", schedules);
		    console.log("schedules : ", ${schedule.startDate});
	
		    const startDate = new Date(schedules); // 시작 날짜를 Date 객체로 변환
	        const currentDate = new Date(); // 현재 날짜

	        // 현재 날짜의 시간을 0으로 설정하여 날짜만 비교
	        currentDate.setHours(0, 0, 0, 0);

	        // 디데이 계산
	        const diffTime = startDate - currentDate; // 밀리초 차이
	        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // 일수로 변환

	        // 디데이 출력
	        const dDayText = diffDays >= 0 ? `${diffDays}일` : "지났습니다";
	        console.log(`ID: ${schedule.id}, 디데이: ${dDayText}`);
		</script>
		
		<%
		    Object mapObject = request.getAttribute("map");
		    Map<Integer, int[]> map = null;
		
		    if (mapObject instanceof Map) {
		        map = (Map<Integer, int[]>)mapObject;
		    } else {
		        map = new HashMap<>(); // 빈 맵으로 초기화
		    }
		
		    int[] deposits = new int[12];
		    int[] expenses = new int[12];
		
		    for (int month = 1; month <= 12; month++) {
		        int[] amounts = map.get(month);
		        deposits[month - 1] = (amounts != null) ? amounts[0] : 0; // 입금액
		        expenses[month - 1] = (amounts != null) ? amounts[1] : 0; // 지출액
		    }
		%>
		<script type="text/javascript">
		    const deposits = <%= Arrays.toString(deposits) %>; // Java 배열을 JavaScript 배열로 변환
		    const expenses = <%= Arrays.toString(expenses) %>;
		
		    // 최대값 계산
		    const maxDeposit = Math.max(...deposits);
		    const maxExpense = Math.max(...expenses);
		    const maxYValue = Math.max(maxDeposit, maxExpense); // 최대값 결정
		    const buffer = maxYValue * 0.1; // 10%
		    const finalMaxYValue = maxYValue + buffer; // 최종 최대값
		
		    const ctx = document.querySelector("#line-chart").getContext("2d"); // 2D context 가져오기
		
		    const myChart = new Chart(ctx, {
		        type: 'line',
		        data: {
		            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		            datasets: [
		                {
		                    label: '입금',
		                    data: deposits,
		                    borderColor: 'rgba(255, 182, 193, 1)', 
		                    tension: 0.4,
		                    pointRadius: 4,
		                    hoverRadius: 6,
		                    pointStyle: 'circle',
		                    fill: true, // 배경 채우기 활성화
		                    backgroundColor: function() {
		                        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
		                        gradient.addColorStop(0, 'rgba(255, 182, 193, 0.2)'); // 시작 색상
		                        gradient.addColorStop(1, 'rgba(255, 182, 193, 0)'); // 끝 색상
		                        return gradient;
		                    },
		                },
		                {
		                    label: '지출',
		                    data: expenses,
		                    borderColor: 'rgba(173, 216, 230, 1)', 
		                    tension: 0.4,
		                    pointRadius: 4,
		                    hoverRadius: 6,
		                    pointStyle: 'circle',
		                    fill: true, 
		                    backgroundColor: function() {
		                        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
		                        gradient.addColorStop(0, 'rgba(173, 216, 230, 0.2)'); 
		                        gradient.addColorStop(1, 'rgba(173, 216, 230, 0)'); 
		                        return gradient;
		                    },
		                },
		            ]
		        },
		        options: {
		            responsive: true,
		            scales: {
		                y: {
		                    type: 'linear',
		                    min: 0,
		                    max: finalMaxYValue, // 최대값으로 설정
		                }
		            }
		        }
		    });
		</script>
		
		<script>
			$(()=>{
				$("#searchAlgo").on("click", function() {
					$("#algoResult").html("금액과 이자율을 입력해주세요");
					if($("#targetAmount").val()!=""&&$("#depositAmount").val()!=""&&$("#interestRate").val()!=""){
						if($("#targetAmount").val() > 0 && $("#depositAmount").val() > 0 && $("#targetAmount").val() >= $("#depositAmount").val() && $("#interestRate").val() > 0 && $("#interestRate").val() < 100){
							$.ajax({
								type: "post",
								url: "algo.do",
								data: {
									"targetAmount":$("#targetAmount").val(),
									"depositAmount":$("#depositAmount").val(),
									"interestRate":$("#interestRate").val(),
									"isCompound":$("[name=isCompound]").val(),
								},
								success: function (result) {
									if(result>=12){
										if(result%12==0){
											$("#algoResult").html($("#targetAmount").val() + "원을 모으기 위해 <b>" + Math.floor(result/12) + "년</b>이 걸립니다.");																				
										}else{
											$("#algoResult").html($("#targetAmount").val() + "원을 모으기 위해 <b>" + Math.floor(result/12) + "년 " + (result%12) + "개월</b>이 걸립니다.");
										}
									}else{
										$("#algoResult").html($("#targetAmount").val() + "원을 모으기 위해 <b>" + result + "개월</b>이 걸립니다.");
									}
										
								},
								error: function() {
									loaction.href="error.jsp";
								},
							});	
						}
					}
				});
			});
		    const start = new Date('${schedule.startDate}');
		    const today = new Date(); // 현재 날
		    
		    // 디데이 계산
		    const timeDiff = start - today;
		    const dDay = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)); // 일수로 변환
		
		    // 디데이 표시
		    const dDayDisplay = document.getElementById('dDayDisplay');
		    dDayDisplay.textContent = '디데이 : ' + dDay + '일 남았습니다';
		</script>
	</section>
</html>