<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style type="text/css">
		input{
			border: none;
			outline: none;
		}
		/* a태그의 기본 속성 제거 */
	    .no-style {
	        text-decoration: none; /* 밑줄 제거 */
	        cursor: pointer;
	   		color: #4D4D4D;
	        padding: 0;
	    }
	    a:hover {
	    	text-decoration: none; 
		    color: inherit; /* hover 시 색상 변경 방지 */
		}
		button {
			background: none; /* 배경 제거 */
			border: none; /* 테두리 제거 */
			padding: 0; /* 패딩 제거 */
			margin: 0; /* 마진 제거 */
			font: inherit; /* 상속된 폰트 사용 */
			color: inherit; /* 상속된 텍스트 색상 사용 */
			cursor: pointer; /* 클릭 가능 커서 */
		}
		body {
			margin: 0;
			width: 100%;
			height: 100vh;
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			background-color: #efeefe;
			color: #4D4D4D;
		}
		section {
		    width: 90%;
		    height: 90vh;
		    display: flex;
			background-color: #f7f6fc;
		    border-radius: 15px;
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		    overflow: hidden;
		    margin: 0;
			padding: 0;
			
		}
		
		#left {
			width: 100%;			
/* 			background: #dbc8fb; */
			display: flex;
			justify-content: center;
			align-items: center;
		}
		#left>img {
			width: 100%;
			height: 100%;
			object-fit: cover;
			opacity: 0.8
			
		}
		
		#right {
			width: 100%;
			display: flex;
			flex-direction: column;
			justify-content: center;
		}
		#right-title {
			display: flex;
			justify-content: center;
			align-items: center;
			font-size: 2.3vw;
			font-weight: bold;
			margin-bottom: 50px;
		}
		.contentSection{
			display: flex;
			flex-direction: column;
		}
		.logoDiv{
			position: relative;
			width: 3vw;
			height: 3vw;
			margin-right: 5px;
		}
		.logoDiv > img{
			width: 100%;
			height: 100%;
			object-fit: contain;
		}
		.sectionTitle{
			color: blue;
		}
		
		form{
			margin: 0 auto 40px auto;
		}
		.inputSection{
			margin: 0 auto;
			width: fit-content;
		}
		.inputLabel {
			font-size: 30px;
			margin-bottom: 5px;
		}
		.inputStyle {
			border: 1px solid #4D4D4D;
			font-size: 24px;
			padding: 0 3px;
			width: 400px;
			height: 40px;
			margin-bottom: 30px;
		}
		#id{
		}
		#loginResult{
			font-size: 1.2vw;
			height: 1.3vw;
			margin-bottom: 30px;
			text-align: center;
		}
		.loginButtonDiv{
			display: flex;
			justify-content: center;
		}
		#loginbtn{
			width: 300px;
			height: 50px;
			border: 1px solid #4D4D4D;
			font-size: 24px;
			border-radius: 25px;
		}
		#loginbtn:hover{
			background-color: #8187f5;
			border: 1px solid #8187f5;
			color: white;
		
		}
		
		#right-footer{
			display: flex;
			justify-content: center;
		}
		#right-footer > a{
			font-size: 24px;
			
		}
		#right-footer > a:hover{
			color: #8187f5;
		}
		#right-footer span {
			height: 100%;
			margin: 0 10px;
			border: 1px solid #4D4D4D;
			
		}
		
		
	</style>
	<script type="text/javascript">
		$(function(){
			$('#loginbtn').on("click",function(event){
				event.preventDefault();
				let id = $('#id').val();
				let password = $('#password').val();
				 $.ajax({
					type: "post",
					url: "login.do",
					data: {
						"id":id,
						"password":password,
					},
					success: function (isCorrect) {
						if(isCorrect != null){
							if(isCorrect=="true"){
								location.href="main.do";
							}else{
								$('#loginResult').html("<font color='crimson'> 잘못된 ID 또는 PASS 입니다. 다시 시도해 주세요.</font>")
							}
						}
					},
					error: function() {
						location.href="error.jsp";
					},
				}) 
			})//onclick
		})//ready
		
	</script>
</head>
<body>
	<section  class="dashboard-container">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		
		<div id="right">
			<div class="contentSection">
				<div id="right-title">
					<div class="logoDiv"><img src="${pageContext.request.contextPath}/image/logo.png"></div>	
					<span>Two Gather</span>
				</div>
				
			
				<form action="login.do">
					<div class="inputSection">
						<div id="insertId" class="inputLabel">Id</div>
						<input type="text" placeholder="아이디를 입력하세요" name="id" id="id" class="inputStyle"><br/>
						<div id="insertPass" class="inputLabel">Password</div>
						<input type="password" placeholder="비밀번호를 입력하세요" name="password" id="password" class="inputStyle">
					
					
					</div>
				
					<div id="loginResult"></div>
					<div class="loginButtonDiv"><button id="loginbtn">로그인하기</button></div>
				</form>
				
				<div id="right-footer">
					<a href="findId.jsp" class="no-style">아이디찾기</a> 
					<span></span> 
					<a href="findPassword.jsp" class="no-style">비밀번호찾기</a>
					<span></span>
					<a href="register.jsp" class="no-style">회원가입</a>
				</div>
				
				
			
			</div>
		</div>
	</section>
</body>
</html>