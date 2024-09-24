<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Calendar, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<meta charset="UTF-8">
	<title>결산</title>
	 <!-- CDN -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<style type="text/css">
		.mainSection {
			width: 100%;
			height: 100%;
			padding: 1.5vw;
			background: #F6F6FE;
			display: flex;
			flex-direction: column;
			gap: 2%;
			overflow: scroll;
			color: #5A5A5A;
		}
		.breadcrumbs {
			font-size: 1.2vw;
			font-weight: bold;
		}
		.monthNav{
			font-size: 2vw;
			display: flex;
			justify-content: center;
			gap: 10px;
/* 			margin-bottom: 1vw; */
		}
		.currentYearMonth{
			line-height: 2;
		}
		.arrowImg {
			position: relative;
			width: 1vw;
		
		}
		
		.mainContainer{
			display: flex;
			flex-direction: column;
			justify-content: space-evenly;
			height: 100%;
		}
		
		.section1, .section2 {
			display: flex;
			gap: 2%;
			
		}
		.section1 {
			height: 30%;
		}
		.section2 {
			height: 60%;
		}
		.item{
			flex: 1;
			background: #FFF;
			border-radius: 20px;
			padding: 2%;
		}
		.label {
			font-size: 1.2vw;
			font-weight: bold;
			margin-bottom: 1.5vw;
			bottom : 0;
		}
		
		/* 총 입금, 지출 */
		.transactionContainer{
			display: flex;
			flex-direction: column;
			gap: 1.2vw;
		}
		.transactionTitle{
			display: flex;
			justify-content: space-between;
			font-size: 1.2vw;
		}
		.priceDifference{
			font-size: 1.2vw;
		}
		.priceDifferenceDiv{
			text-align: center;
		}
		
		.chart-container{
			width:100%;
			height: 80%;
			display: flex;
			justify-content: center;
		}
		.chart-container div:nth-child(2) {
			display: flex;
			justify-content: center;
			align-items: center;
			font-size: 1.2vw;
		}
		font{
			font-size: 1.5vw;
			font-weight: bold;
		}
		.arrowImg img {
        width: 100%;
        height: 100%;
        object-fit: contain;
    }
	
	</style>

</head>
	<section class="mainSection">
		<div>
			<div class="breadcrumbs">가계부 결산</div>
			<% 
				String yearMonth = (String) request.getAttribute("yearMonth");
			    String[] parts = yearMonth.split("-"); // '-'로 분리
			    String formattedDate = parts[0] + "년 " + Integer.parseInt(parts[1]) + "월";
			%>
			<div class="monthNav">
				<div class="arrowImg"><img src="${pageContext.request.contextPath}/image/arrowLeft.svg" alt="prev"></div>
				<div class="currentYearMonth"><%= formattedDate %></div>
				<div class="arrowImg"><img src="${pageContext.request.contextPath}/image/arrowRight.svg" alt="next"></div>				
			</div>
		</div>
		
		<div class="mainContainer">
			<div class="section1">
				<div class="item transactionSection">
					<div class="label">이번 달 현황</div>
					<div class="transactionContainer">
						<div class="transactionTitle">
							<div>총 입금</div>
							<div>${depositMonth} 원</div>
						</div>
						<div class="transactionTitle">
							<div>총 지출</div>
							<div>${expenseMonth} 원</div>
						</div>
					</div>
				</div>
				<div class="item priceDifference">
					<div class="label">전월 대비 동일 기간 비교</div>
					<div class="priceDifferenceDiv">
						<c:choose>
							<c:when test="${priceDifference > 0}">
								지난 달보다 <br> 지출이 <font>${priceDifference}원</font> 늘었습니다</c:when>
							<c:when test="${priceDifference < 0}">지난 달보다 <br> 지출이 <font>${priceDifference}원</font> 줄었습니다</c:when>
							<c:otherwise>지난 달과 지출이 동일합니다</c:otherwise>
				        </c:choose>
					</div>
				</div>

			</div>
			<div class="section2">
				<div class="item">
					<div class="label">이번 달 항목별 지출</div>
					 <c:if test="${not empty category}">
					    <script type="text/javascript">
					        console.log("category : " + '${category}');
					    </script>
					</c:if>
				    <div class="chart-container">
				        <canvas id="donut-chart"></canvas>
				    </div>			
				</div>
				
				<div class="item">
				<div class="label">무언가의 알고리즘</div>
				</div>
			
			</div>	
		</div>
		
		<!-- 항목별 차트 -->
		<%
		    // request에서 category 데이터를 Map으로 캐스팅
		    Map<String, Integer> categoryMap = (Map<String, Integer>) request.getAttribute("category");
		%>
		<script type="text/javascript">
		    // Java의 Map을 JavaScript 객체로 변환
		    const categoryData = {
		        <% 
		        // Map의 데이터를 key-value 형식으로 출력
		        for (Map.Entry<String, Integer> entry : categoryMap.entrySet()) { 
		            String key = (entry.getKey() == null) ? "기타" : entry.getKey(); // null일 경우 "기타"로 처리
		            out.print("\"" + key + "\": " + entry.getValue() + ",");
		        } 
		        %> 
		    };
		    console.log(categoryData);
		</script>
		
		<script type="text/javascript">
		    const labels = Object.keys(categoryData);  // 항목 이름
		    const data = Object.values(categoryData);  // 항목 값들
		
		    const ctx = document.getElementById('donut-chart').getContext('2d');
		    
		    const donutChart = new Chart(ctx, {
		        type: 'doughnut',
		        data: {
		            labels: labels, // 카테고리 이름
		            datasets: [{
		                label: '카테고리별 지출',
		                data: data,  // 지출 데이터
		                backgroundColor: [
		                    'rgba(255, 99, 132, 0.6)',
		                    'rgba(54, 162, 235, 0.6)',
		                    'rgba(255, 206, 86, 0.6)',
		                    'rgba(75, 192, 192, 0.6)',
		                    'rgba(153, 102, 255, 0.6)',
		                    'rgba(255, 159, 64, 0.6)',
		                    'rgba(199, 199, 199, 0.6)',
		                    'rgba(83, 102, 255, 0.6)',
		                    'rgba(255, 195, 113, 0.6)',
		                    'rgba(255, 77, 79, 0.6)',
		                    'rgba(75, 192, 192, 0.6)',
		                    'rgba(50, 205, 50, 0.6)',
		                    'rgba(255, 20, 147, 0.6)',
		                    'rgba(0, 191, 255, 0.6)',
		                    'rgba(255, 140, 0, 0.6)',
		                    'rgba(138, 43, 226, 0.6)',
		                    'rgba(255, 228, 196, 0.6)',
		                    'rgba(255, 20, 147, 0.6)',
		                    'rgba(240, 230, 140, 0.6)',
		                    'rgba(173, 216, 230, 0.6)',
		                ],
		            }]
		        },
		        options: {
		            responsive: true,
		            plugins: {
		                legend: {
		                    position: 'top', // 범례의 위치
		                },
		                tooltip: {
		                    enabled: true, // 툴팁 활성화
		                    callbacks: {
		                        label: function(tooltipItem) {
		                            const label = tooltipItem.label || '';
		                            const value = tooltipItem.raw; // 값
		                            return `${label}: ${value}`; // "항목 이름: 값" 형태로 표시
		                        }
		                    }
		                }
		            }
		        }
		    });

		</script>

	</section>
	
	
</html>