<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style type="text/css">
		body {
			height: 100vh;
			display: flex;
			justify-content: center;
			align-items: center;
			background-color: #efeefe; /* 임시 색상 */
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
			text-align: center;
			display: flex;
		}
		#left {
			width: 50%;
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
			width: 50%;
			height: 1080px;
		}
		#right-title {
			font-size: 32px;
			text-align: center;
			margin-top: 200px;
		}
		#fontId{
			margin-right: 150px;
		}
		#fontBirth{
			margin-right: 110px;
		}
		
	</style>
	<script type="text/javascript">
		$(()=>{
			
			
			$('#findPassBtn').on("click",function(){
				let id = $('#id').val();
				let birthdate = $('#birthdate').val();
				if(id==""){
					alert("id를 입력해주세요");
				}else if(birthdate == ""){
					alert("생년월일을 입력해주세요");
				}else{
					$.ajax({
						type:"post",
						url: "findPass.do",
						data:{
							"id":id,
							"birthdate":birthdate,
						},
						success: function(password) {
							if(password != ""){
								$('#right-insert').html("");
								$('#findPasswordResult').html("<font color='green'>비밀번호는 "+password+" 입니다.</font>");
							}else{
								$('#findPasswordResult').html("<font color='crimson'>일치하는 비밀번호가 존재하지 않습니다.</font>")
							}
						},error : function(e) {
							console.log(e);
						}
						
						
					})
				}	
			})
			
		})//ready
	</script>
</head>
<body>
	<div class="dashboard-container">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		<div id="right">
			<div id="right-title">
				비밀번호찾기<br /><br/>
			</div>
			<form action="#">
			<div id="right-insert">
				<font id="fontId">ID</font><br>
				<input type="text" placeholder="아이디" id="id"><br>
				<font id="fontBirth">생년월일</font><br>
				<input type="date" placeholder="2000-01-01" id="birthdate">
			</div>
			<div id="findPasswordResult"></div>
			<div id="right-findPassword-btn">
				<br /><button id="findPassBtn">비밀번호찾기</button>
			</div>
			</form>
			<div><a href="login.jsp">로그인하기</a></div>
		</div>
	</div>
</body>
</html>