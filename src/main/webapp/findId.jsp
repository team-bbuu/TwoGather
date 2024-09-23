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
		
		#insertEmail{
			margin-right: 135px;
		}
		#insertMobile{
			margin-right: 125px;
		}
		
	</style>
	<script type="text/javascript">
		$(()=>{
			$('#findIdBtn').on("click",function(){
			let email1= $('#email1').val();
			let email2 = $('#email2').val();
			let email= email1+"@"+email2;
			let mobile1= $('#mobile1').val();
			let mobile2= $('#mobile2').val();
			let mobile3= $('#mobile3').val();
			let mobile =mobile1+"-"+mobile2+"-"+mobile3;
			if(email1 =="" | email2 ==""){ //이메일 비입력시
				event.preventDefault();
				alert("이메일을 입력해주세요.")
			}else if(mobile1.length!=3 | mobile2<=99 | mobile3<=999){ //자리 수 부족 시
				event.preventDefault();
				alert("전화번호를 다시 확인해주세요.")
			}else if(mobile2>9999 | mobile3>9999){ //자리수 초과 시
				event.preventDefault();
				alert("전화번호를 다시 확인해주세요.")
			}else{
				$.ajax({
					type:"post",
					url:"findId.do",
					data:{
						"email":email,
						"mobile":mobile,
					},
					success: function(userId) {
						if(userId != ""){
							$('#right-insert').html("");
							$('#findIdResult').html("<font color='green'>ID는 "+userId+" 입니다.</font>");
						}else{
							$('#findIdResult').html("<font color='crimson'>일치하는 ID가 존재하지 않습니다.</font>");
						}
					}
					,error: function() {
						location.href="error.jsp";
					}
				})
			}
			
			})//onclick
			
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
				아이디찾기<br /><br/>
			</div>
			<div id="right-insert">
				
				<div id="insertEmail">Email</div>
				<input type="text" class="imputEmail" name="email1" id="email1" > @
				<input type="text" class="imputEmail" name="email2" id="email2" value="gmail.com"><br/> 
				
				<div id="insertMobile">Mobile</div>
				<input type="text" class="inputMobile" name="mpbile1" id="mobile1" value="010"> -
				<input type="number" class="inputMobile" name="mobile2" id="mobile2"> -
				<input type="number" class="inputMobile" name="mobile3" id="mobile3">
			</div>
			<div id="findIdResult"></div>
			<div id="right-findId-btn">
				<br /><button id="findIdBtn">아이디찾기</button>
			</div>
			<div>
			<a href="login.jsp">로그인하기</a> |
			<a href="findPassword.jsp">비밀번호찾기</a></div>
			
		</div>
	</div>
</body>
</html>