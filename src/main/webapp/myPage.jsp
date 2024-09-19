<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
		#nav {
			width: 25%;
			background: #ddd;
			height: 100%;
			border-radius: 15px 15px 0px 0px;
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
</head>
<body>
	<div class="dashboard-container">
		<!-- 왼쪽 NAV -->
		<div id="nav">
		NAV
		</div>
		<div id="right">
		<div id="myPage">
			<div id="myPage-image">
				<img src="./image/login.jpg">
			</div>
			<div id="myPage-id">
				내 아이디 출력
			</div>
			<div id="update">
				ID : <input type="text" placeholder="변경할 패스워드를 입력해주세요"><br />
				PW : <input type="text" placeholder="변경할 패스워드를 다시 입력해주세요"><br />
				<input type="text" placeholder="닉네임을 입력해주세요"><br />
				<input type="text" placeholder="연락처를 입력해주세요"><br />
				생년월일 출력<br />
				<input type="text" placeholder="이메일을 입력해주세요"><br />
				성별 출력<br />
				<input type="text" placeholder="주소를 입력해주세요"><br />
			</div>
			<div id="update-btn">
				<br /><button>정보수정하기</button>
			</div>
			<div id="myPage-footer">
				<br />헤어지기 | 회원탈퇴			
			</div>
		</div>
		</div>
	</div>
</body>
</html>