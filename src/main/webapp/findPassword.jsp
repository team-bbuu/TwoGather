<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
		body {
			margin: 0px;
			padding: 0px;
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
			width: 50%;
			height: 1080px;
			background: #c8fbf5;
		}
		#right-title {
			font-size: 32px;
			text-align: center;
			margin-top: 200px;
		}
		#right-insert{
			text-align: center;
			
		}
		#right-findPassword-btn {
			text-align: center;
		}
	</style>
</head>
<body>
	<div id="total">
		<div id="left">
			<img src="./image/login.jpg">
		</div>
		<div id="right">
			<div id="right-title">
				비밀번호찾기<br /><br/>
			</div>
			<div id="right-insert">
				<input type="text" placeholder="이메일을 입력해주세요"><br/>
				<input type="text" placeholder="전화번호를 입력해주세요">
			</div>
			<div id="right-findPassword-btn">
				<br /><button>비밀번호찾기</button>
			</div>
		</div>
	</div>
</body>
</html>