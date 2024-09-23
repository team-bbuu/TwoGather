<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style type="text/css">
	    *{
	    	margin: 0;
	    	padding: 0;
	    	box-sizing: border-box;
		    font-family: Arial, sans-serif;
	    }
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
		}
		#total {
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
			max-height: 100%;
			display: block;
		}
		#right {
			flex: 1;
			display: flex;
		}
		#myPage {
			width: 100%;
			display: flex;
			flex-direction: column;
			align-items: center;
		}	
		#myPage-image>img{
			width: 150px;
			height: 150px;
		}
		#update-btn {
			text-align: center;
		}
	</style>
	<script type="text/javascript">
		$(()=>{
			$('#checkIdBtn').on('click', () => {
				let id = $('[name=id]').val();
				if(id == ""){
					alert("id를 입력해주세요.")
					return;
				}else{
					$.ajax({
						type: "post",
						url: 'checkId.do',
						data: {'id': id},
						
						success: function(result) {
							result = JSON.parse(result);
							if(result == null) {
								$('#resultId').html("<font color='green'>사용가능한 아이디입니다.</font>");
								check =true;
								
							}else {
								$('#resultId').html("<font color='crimson'>사용불가능한 아이디입니다.</font>");							
							}
						},
						error: function(e) {
							console.log(e.message);
						},
				})
				
				};
				
			});//checkId
			$('#password2').on("keyup",function(){
				let password1 = $('#password1').val();
				let password2 = $('#password2').val();
				if(password1 == password2){
					$('#passEqual').html("<font color='green'>비밀번호가 일치합니다.</font>")
				}else{
					$('#passEqual').html("<font color='red'>비밀번호가 일치하지 않습니다.</font>")
				}
			})//passEqual
			
			$('#registerBtn').on("click",function(){
				event.preventDefault();
				let id = $('#id').val();
				let password1 = $('#password1').val();
				let password2 = $('#password2').val();
				let nickname = $('#nickname').val();
				let mobile1 = $('#mobile1').val();
				let mobile2 = $('#mobile2').val();
				let mobile3 = $('#mobile3').val();
				let mobile = mobile1+"-"+mobile2+"-"+mobile3;
				let birthdate = $('#birthdate').val();
				let email1 = $('#email1').val();
				let email2 = $('#email2').val();
				let email = email1+"@"+email2;
				let gender = $('[name=gender]').val();
				let address = $('#address').val();
				if(id==""){
					alert("아이디를 입력해주세요.");
					return;
				}else if(password1 == "" | password2 == ""){
					alert("비밀번호를 입력해주세요.");
					return;
				}else if(password1 != password2){
					alert("비밀번호가 일치하지 않습니다.");
					return;
				}else if(nickname == ""){
					alert("닉네임을 입력해주세요.");
					return;
				}else if(mobile1.length!=3 | mobile2<=99 | mobile3<=999){ //자리 수 부족 시
					alert("전화번호를 다시 확인해주세요.");
					return;
				}else if(mobile2>9999 | mobile3>9999){ //자리수 초과 시
					alert("전화번호를 다시 확인해주세요.");
					return;
				}else if(birthdate == ""){
					alert("생년월일을 입력해주세요.");
					return;
				}else if(email1 =="" | email2 ==""){ //이메일 비입력시
					alert("이메일을 입력해주세요.")
					return;
				}else if(gender ==""){
					alert("성별을 선택해주세요.");
					return;
				}else {
					if(id == ""){
						alert("id를 입력해주세요.");
						return;
					}else{
						$.ajax({
							type: "post",
							url: 'checkId.do',
							data: {'id': id},
							
							success: function(result) {
								result = JSON.parse(result);
								if(result == null) {
									$('#resultId').html("");
									$.ajax({
										type:"post",
										url:"register.do",
										data:{
											"id":id,
											"password":password1,
											"nickname":nickname,
											"mobile":mobile,
											"birthdate":birthdate,
											"email":email,
											"gender":gender,
											"address":address,
										},
										success: function(result) {
											if(result != null){
												if(result == "success"){
													alert("회원가입이 완료되었습니다.")
													location.href="login.jsp";
												}else if(result == "fail"){
													$('#registerResult').html("<font color='red'>전화번호 또는 이메일을 다시 확인해주세요.</font>");
												}
											}
										},error: function(e) {
											console.log(e);
										}
										
									})
									
									
								}else {
									$('#resultId').html("<font color='crimson'>사용불가능한 아이디입니다.</font>");							
								}
							},
							error: function(e) {
								console.log(e.message);
							},
					})//checkId
					
					
				}}//else
			})//register
			
		});	//ready	
	</script>
</head>
<body>
	<div class="dashboard-container">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		<div id="right">
		<div id="myPage">
		
			<form id="update">
				<font id="fontId">ID </font> <br>
				<input type="text" placeholder="아이디" name="id" id="id">
				<input type="button" id="checkIdBtn" value="중복체크"><br />
				<div id="resultId"></div>
				<font>PW</font> <br>
				<input type="password" placeholder="비밀번호" name="password" id="password1"><br />
				<font>PW</font>  <br>
				<input type="password" placeholder="비밀번호 확인" id="password2"><br />
				<div id="passEqual"></div>
				<font>Nickname</font><br>
				<input type="text" placeholder="닉네임" name="nickname" id="nickname"><br />
				<font>Mobile</font><br>
				<input type="text" name="mobile1" id="mobile1" value="010"> -
				<input type="number" name="mobile2" id="mobile2"> -
				<input type="number" name="mobile3" id="mobile3"><br />
				<font>Birthdate</font><br>
				<input type="date" placeholder="생년월일" name="birthdate" id="birthdate"><br />
				<font>Email</font><br>
				<input type="text" name="email1" id="email1"> @ 
				<input type="text" name="email2" id="email2" value="gmail.com"> <br>
				<font>Gender</font><br>
				<input type="radio" value="F" name="gender" id="gender1">남성
				<input type="radio" value="M" name="gender" id="gender2">여성<br />
				<font>Address</font>
				<input type="text" placeholder="주소" name="address" id="address"><br />
				<div id="registerResult"></div>
				<br /><button id="registerBtn">회원가입</button>
			</form>
		</div>
		</div>
	</div>
</body>
</html>