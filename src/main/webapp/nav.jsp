<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width =device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.navContainer{
		position: relative;
		width: 25%; 
		height: 100%; 
		background: #fff;
		padding: 1.5vw;
	}
	/* a태그의 기본 속성 제거 */
    .no-style {
        text-decoration: none; /* 밑줄 제거 */
        cursor: pointer; 
        color: black;
    }
    a:hover {
    	text-decoration: none; 
	    color: inherit; /* hover 시 색상 변경 방지 */
	}
	.logo {
		font-size: 2vw;
		font-weight: bold;
		margin-bottom: 3vw;
	}
	
	/* 커플 프로필 등 */
	.coupleInfo{
		display: flex;
		justify-content: space-around;
		align-items:center;
		margin-bottom: 1.8vw;
	}
	/* 커플 이미지 */
	.userImage{
		position: relative;
		border-radius: 50%;
		width: 6vw;
		height: 6vw;
		overflow: hidden;
	}
	.userImage img {
        width: 100%;
        height: 100%;
        object-fit: cover;
	}
	/* 하트 아이콘 */
	.heartIcon{
		position: relative;
		width: 2vw;
		height: 2vw;
	}
	.inviteState {
		display: flex;
		justify-content: center;
		margin-bottom: 2vw;
	}
	.inviteBtn{
		color: #8c8c8c;
		padding: 5px 15px;
		border-radius: 20px;
	}	

	.inviteBtn{
		border: 1px solid #8c8c8c;
	}
	.navUl {
		display: flex;
		flex-direction: column;
		gap: 1.2vw;
	}
	.nav-item{
	}
	.nav-item:hover, .inviteBtn:hover {
		background-color: #8187f5;
		color: white;
		border: 1px solid white;
	
	}
	.nav-item > a, .nav-item > p {
		font-size: 1.2vw;
	
	}
	.gagyebuLi {
		padding-left: 1vw;
	
	}
	.gagyebuLi > p {
		margin-bottom: 0;
	}
	
	.gagyebuLi a {
		font-size: 1vw;
	}
	
	/* 로그아웃 버튼 */
	.logutBtn {
		position: absolute;
		bottom: 1vw;
		font-size: 1vw;
		color: gray;
	}
	
</style> 
</head>
	<div class="navContainer">
		<div class="logo">
			Two Gather
		</div>
		
		<div class="coupleInfo">
			<div class="userImage">
				<img src="${pageContext.request.contextPath}/image/cat.jpg">
			</div>
			<div class="heartIcon">
				<img src="${pageContext.request.contextPath}/image/heart-icon.svg">
			</div>
			<div class="userImage">
				<img src="${pageContext.request.contextPath}/image/cat.jpg">
			</div>
			
		</div>
		<!-- 초대하기 버튼, 디데이표시 등 -->
		<div class="inviteState">
	    	<button type="button" class="inviteBtn" data-toggle="modal" data-target="#myModal">
				초대하기
			</button>		
		</div>

		<ul class="navUl">
		    <li class="nav-item">
		    	<a class="nav-link no-style" href="main.do">메인</a>
		    </li>
		    
		    <li class="nav-item gagyebuLi">
		   		<p>가계부</p>
		    	<a class="nav-link no-style" href="gagyebu.do">월별 가계부</a>
			    <a class="nav-link no-style" href="gagyebuMonth.do">결산</a>
<!-- 		    	<a class="nav-link no-style" href="main.do">설정</a> -->
		    </li>
		    
		    <li class="nav-item">
		    	<a class="nav-link no-style" href="schedule.do">일정</a>
		    </li>
   		    <li class="nav-item">
		    	<a class="nav-link no-style" href="story.do">스토리</a>
		    </li>
  		    <li class="nav-item">
		    	<a class="nav-link no-style" href="mypage.do">마이페이지</a>
		    </li>
		</ul>
		
		<div class="logutBtn">로그아웃</div>
		</div>
</html>