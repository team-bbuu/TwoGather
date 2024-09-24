<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style type="text/css">
		body {
			height: 100vh;
			display: flex;
			justify-content: center;
			align-items: center;
			background-color: #efeefe; /* 임시 색상 */
			text-align: center;
		}
		.dashboard-container {
		    display: flex;
		    width: 90%;
		    height: 90vh;
			background-color: #f7f6fc;
		    border-radius: 15px;
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		    overflow: hidden;
		    margin: 0px;
			padding: 0px;
			display: flex;
		}
		
		#left {
			width: 100%;
			height: 1080px;
			background: #dbc8fb;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		#left>img {
			max-width: 100%;
			height: 100%;
			display: block;
		}
		
		#right {
			width: 100%;
			height: 1080px;
		}
		#right-title {
			font-size: 32px;
			text-align: center;
			margin-top: 200px;
		}
		
		
	</style>
	<script type="text/javascript">
		$(function(){
			$('#loginbtn').on("click",function(){
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
								location.href="main.do"
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
	<div  class="dashboard-container">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		<div id="right">
			<div id="right-title">
				로그인하기<br /><br/>
			</div>
			<form action="login.do">
				<div id="insertId">ID</div>
				<input type="text" placeholder="아이디" name="id" id="id"><br/>
				<div id="insertPass">PASS</div>
				<input type="password" placeholder="비밀번호" name="password" id="password">
			
				<div id="loginResult"></div><br />
				<button id="loginbtn">로그인하기</button>
			</form>
			<div id="right-footer">
				<br /><a href="findId.jsp">아이디찾기</a> | <a href="findPassword.jsp">비밀번호찾기</a> | <a href="register.jsp">회원가입</a>
			</div>
		</div>
	</div>
</body>
</html>