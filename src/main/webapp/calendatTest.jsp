<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Calendar</title>
    <!-- css 파일 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/monthGagyebu.css">
	<style type="text/css">
		.dashboard-content {
			width: 75%;
			height: 100%;
			display: flex;
			flex-direction: column;
			justify-content: center;
			text-align: center;	
		}
		#calendar {
			width: 500px;
			height: 500px;
			color: violet;
			margin: auto;
		}
		#container {
			display: flex;
			flex-direction: row;
			justify-content: center;
		}
		#todo_container {
			border: 1rem solid rgba(255,255,255,0.9);
			border-radius: 30px;
			background: lightpink;
			margin: 0 auto;
		}
	</style>
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
 	<script>
        document.addEventListener('DOMContentLoaded', function() {
            // 시계
            const clock = document.querySelector('#clock');

            function updateClock() {
                var currentTime = new Date();
                var timeString = String(currentTime.getHours()).padStart(2, "0") + ":" + 
                                 String(currentTime.getMinutes()).padStart(2, "0") + ":" +
                                 String(currentTime.getSeconds()).padStart(2, "0");
                clock.innerHTML = timeString;
            }
            updateClock();
            setInterval(updateClock, 1000);
            
            // 캘린더
            var calendar;
            var calendarEl = document.getElementById('calendar');
            calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                selectable: true,
                events: [
                    {id: "2024-09-14", start: "2024-09-14"},
                    {id: "2024-09-15", start: "2024-09-15"}
                ],
                dateClick: function(info) {
                    //console.log("clicked event occurs :: date = " + info.dateStr);
                    removeEventFromCalendar(info.dateStr);
                }
            });
            calendar.render();

            
            // ToDo form 처리
            const todoform = document.querySelector("#todoform");
            const todoInput = document.querySelector("#todoform input");
			const todoList_ul = document.querySelector("#todolist");
			
            todoform.addEventListener("submit", handleToDoSummit);

            function handleToDoSummit(parm) {
                console.log("handleToDoSummit is called");
                parm.preventDefault(); // 리프레시 막는 함수
                var curTodo = todoInput.value;
                console.log("todoInput value : " + curTodo);
                
                todoInput.value = "";
                
                var todo_cur_li = document.createElement("li");
                var todo_cur_span = document.createElement("span");
                
                todo_cur_span.innerText = curTodo;
                todo_cur_li.appendChild(todo_cur_span);
                todoList_ul.appendChild(todo_cur_li);
            }

            function addEventToCalendar(event) {
                calendar.addEvent(event);
            }

            function removeEventFromCalendar(id) {
                var calendarEvent = calendar.getEventById(id);
                if (calendarEvent) {
                    calendarEvent.remove();
                }
            }
        });
    </script>
</head>
<body>
    <div class="dashboard-container">
        <!-- 왼쪽 영역 : 사이드바jsp -->
       <div class="nav"style="border: 1px solid red; width: 25%; height: 100%;"></div>

        <!-- 오른쪽 영역 : 콘텐츠 영역 -->
        <div class="dashboard-content">
        	<h2 id="clock">00:00:00</h2>
        	<div id="container">
        		<div id='calendar'></div>
        		<div id="todo_container">
        			<p id="cur_date">일정</p>
        			<form id="todoform">
        				<input required type="text" placeholder="Write a ToDo" />
        			</form>
        			<ul id="todolist">
        			</ul>
        		</div>
        	</div>
        	<!-- 각 jsp -->
        	<jsp:include page="monthGagyebu.jsp" />
        </div>
    </div>
</body>
</html>