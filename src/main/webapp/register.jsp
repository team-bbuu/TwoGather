<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<style type="text/css">
	    * {
	    	margin: 0;
	    	padding: 0;
	    	box-sizing: border-box;
		    font-family: Arial, sans-serif;
		}
		input {
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
		.inputLabel {
			font-size: 18px;
			margin-bottom: 5px;
		}
		.inputStyle {
			border: 1px solid #4D4D4D;
			font-size: 14px;
			padding: 0 3px;
			width: 400px;
			height: 25px;
			margin-bottom: 10px;
		}
		.id {
			border: 1px solid #4D4D4D;
			font-size: 14px;
			padding: 0 3px;
			width: 297px;
			height: 25px;
			margin-bottom: 10px;
		}
		.isExist {
			border: 1px solid #4D4D4D;
			font-size: 14px;
			padding: 0 3px;
			width: 97px;
			height: 25px;
			margin-bottom: 10px;
		}
		.gender {
			border: 1px solid #4D4D4D;
			font-size: 14px;
			padding: 0 3px;
			width: 20px;
			height: 25px;
			margin-bottom: 10px;
		}
		.mobile {
			border: 1px solid #4D4D4D;
			font-size: 14px;
			padding: 0 3px;
			width: 124px;
			height: 25px;
			margin-bottom: 10px;
		}
		.email{
			border: 1px solid #4D4D4D;
			font-size: 14px;
			padding: 0 3px;
			width: 188px;
			height: 25px;
			margin-bottom: 10px;
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
		#registerBtn, #cancleBtn{
			width: 160px;
			height: 40px;
			border: 1px solid #4D4D4D;
			font-size: 20px;
			border-radius: 25px;
		}
		#registerBtn:hover, #cancleBtn:hover {
			background-color: #8187f5;
			border: 1px solid #8187f5;
			color: white;
		}
		#footer {
			margin: 0 40px;
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
	<section class="dashboard-container">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		<div id="right">
		<div id="myPage">
			<div id="right-title">
				<div class="logoDiv"><img src="${pageContext.request.contextPath}/image/logo.png"></div>	
				<span>Two Gather</span>
			</div>
			<form id="update">
				<font id="fontId" class="inputLabel">Id </font> <br>
				<input type="text" placeholder="아이디" name="id" id="id" class="id">
				<input type="button" id="checkIdBtn" value="중복체크" class="isExist"><br />
				<div id="resultId"></div>
				<font class="inputLabel">Password</font> <br>
				<input type="password" placeholder="비밀번호" name="password" id="password1" class="inputStyle"><br />
				<font class="inputLabel">Password check</font>  <br>
				<input type="password" placeholder="비밀번호 확인" id="password2" class="inputStyle"><br />
				<div id="passEqual"></div>
				<font class="inputLabel">Nickname</font><br>
				<input type="text" placeholder="닉네임" name="nickname" id="nickname" class="inputStyle"><br />
				<font class="inputLabel">Mobile</font><br>
				<input type="text" name="mobile1" id="mobile1" value="010" class="mobile"> -
				<input type="number" name="mobile2" id="mobile2" class="mobile"> -
				<input type="number" name="mobile3" id="mobile3" class="mobile"><br />
				<font class="inputLabel">BirthDay</font><br>
				<input type="date" placeholder="생년월일" name="birthdate" id="birthdate" class="inputStyle"><br />
				<font class="inputLabel">Email</font><br>
				<input type="text" name="email1" id="email1" class="email"> @ 
				<input type="text" name="email2" id="email2" value="gmail.com" class="email"> <br>
				<font class="inputLabel">Gender</font><br>
				<input type="radio" value="F" name="gender" id="gender1" class="gender"><font class="inputLabel">남성</font>
				<input type="radio" value="M" name="gender" id="gender2" class="gender"><font class="inputLabel">여성</font><br />
				<font class="inputLabel">Address</font><br>
				<input type="text" placeholder="주소" name="address" id="address" class="inputStyle"><br />
				<div id="registerResult"></div>
				<div id="footer">
					<br /><button type="button" id="cancleBtn" onclick="location.href='login.jsp'">취소</button>
					<button id="registerBtn">회원가입</button>
				</div>
			</form>
		</div>
		</div>
	</section>
</body>
</html>