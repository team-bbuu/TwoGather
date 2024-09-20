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
			$('#checkId').on('click', () => {
				let id = $('[name=id]').val();
				$.ajax({
					type: "post",
					url: 'checkId.do',
					data: {'id': id},
					
					success: function(result) {
						result = JSON.parse(result);
						if(result == null) {
							$('#resultId').html('사용가능 아이디입니다.');
						}else {
							$('#resultId').html('중복된 아이디입니다.');							
						}
					},
					error: function(e) {
						console.log(e.message);
					},
				});
				
			});
		});		
	</script>
</head>
<body>
	<div class="dashboard-container">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		<div id="right">
		<div id="myPage">
			<div id="myPage-image">
				<img src="./image/login.jpg">
			</div>
			<form id="update">
				ID : <input type="text" placeholder="변경할 패스워드를 입력해주세요" name="id">
				<input type="button" id="checkId" value="중복체크"><br />
				<div id="resultId"></div>
				PW : <input type="text" placeholder="변경할 패스워드를 다시 입력해주세요" name="password"><br />
				PW2 : <input type="text" placeholder="변경할 패스워드를 다시 입력해주세요"><br />
				<input type="text" placeholder="닉네임을 입력해주세요" name="nickname"><br />
				<input type="text" placeholder="연락처를 입력해주세요" name="mobile"><br />
				<input type="date" placeholder="생년월일를 입력해주세요" name="birthdate"><br />
				<input type="text" placeholder="이메일을 입력해주세요" name="email"><br />
				<input type="radio" value="F" name="gender">W<br />
				<input type="radio" value="M" name="gender">M<br />
				<input type="text" placeholder="주소를 입력해주세요" name="address"><br />
				<div id="update-btn">
					<br /><button>회원가입</button>
				</div>
			</form>
		</div>
		</div>
	</div>
</body>
</html>