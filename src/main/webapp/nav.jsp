<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		color: #4D4D4D;
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
	.logo {
		font-size: 1.5vw;
		font-weight: bold;
		margin-bottom: 3vw;
		display: flex;
	}
	.logoDiv{
		position: relative;
		margin-right: 5px;
		width: 2vw;
		height: 2vw;
	}
	.logoDiv > img{
		width: 100%;
		height: 100%;
	}
	
	/* 커플 프로필 등 */
	.coupleInfo{
		display: flex;
		justify-content: space-around;
		align-items:center;
		margin-bottom: 1.2vw;
	}
	.username {
		font-size: 1vw;
		display: flex;
		justify-content: center;
		padding-top: 5px;
	}
	.inviteState2{
		font-size: 1vw;
		text-align: center;
		color: #7B83E6;
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
	.heartIcon > img {
		width: 100%;
		height: 100%;
        object-fit: cover;
	}
	.inviteState {
		display: flex;
		justify-content: center;
		margin-bottom: 1vw;
	}
	.inviteBtn{
		color: #8c8c8c;
		padding: 5px 15px;
		border-radius: 20px;
	}	

	.inviteBtn{
		border: 1px solid #8c8c8c;
	}
 	.inviteBtn:hover {
		background-color: #8187f5;
		color: white;
		border: 1px solid white;
	}
	.requestMsg{
		color: #8187f5;
		text-align: center;
		padding-bottom:5px;
	}
	.requestBtnArea{
		display: flex;
		justify-content: center;
		gap: 10px;
		text-align: center;
		margin-bottom: 1vw;
	}
	.requestBtn {
		cursor: pointer;
		padding: 2px 10px;
		border-radius: 20px;
		color: #5A5A5A;
		border: 1px solid #5A5A5A;
		background-color: inherit;
	}
	.requestBtn:hover{
		background-color: #8187f5;
		border: 1px solid #8187f5;
		color: white;
	}
	.requestBtn .no{
		border: #8187f5;
		
	}
	
	.navUl {
		display: flex;
		flex-direction: column;
/* 		gap: 1.2vw; */
	}
	.nav-item{
		font-weight: bold;
		padding: 0.5vw 0 0.5vw 0.5vw;
	}
	.gagyebuLi>p{
		font-weight: bold;
		padding: 0.5vw 0 0 0.5vw;
	}

	.nav-item:hover, .subMemu > a:hover {
/* 		background-color: #8187f5; */
		color: #8187f5;
/* 		border: 1px solid white; */
	
	}
	/* 메뉴 텍스트 */
	.nav-item > a, .gagyebuLi > p {
		font-size: 1.2vw;
	}

	/* 가계부 메뉴 감싸고 있는 div */
	.gagyebuLi {
		padding-bottom: 0.5vw
	}
	.subMemu{
		border-left: 1px solid gray;
		margin-left: 5px;
		padding-top:5px;
		padding-left: 15px;
	}
	.subMemu {
		display: flex;
		flex-direction: column;
		gap: 10px;
	}
	.gagyebuLi > p {
		margin-bottom: 0;
	}
	.gagyebuLi a {
		font-size: 1vw;
	}
	
	/* 로그아웃 버튼 */
	.logoutBtn {
		position: absolute;
		bottom: 1vw;
		font-size: 1vw;
		color: gray;
	}
</style> 
</head>
	<div class="navContainer">

		<div class="logo">
			<div class="logoDiv"><img src="${pageContext.request.contextPath}/image/logo.png"></div>	
			<a href="main.do" class="no-style">Two Gather</a>
		</div>
		<div class="coupleInfo">
			<!-- 매칭전, 요청중: 로그인 유저 프로필만 뜸 -->
<%-- 			${user.matching == '매칭전' || user.matching == '요청함'} --%>
			<c:if test="${user.matching == '매칭전' || user.matching == '요청함' || user.matching == '요청받음'}">
				<div class="userProfile">
					<div class="userImage">
						<img src="${pageContext.request.contextPath}/image/cat.jpg">
					</div>
					<div class="username">${user.nickname}</div>
				</div>				
			</c:if>
		
			<!-- 매칭완료 -->
			<c:if test="${user.matching == '매칭완료'}">
				<div class="userProfile">
					<div class="userImage">
						<img src="${pageContext.request.contextPath}/image/cat.jpg">
					</div>
					<div class="username">${user.nickname}</div>
				</div>
				<div class="heartIcon">
					<img src="${pageContext.request.contextPath}/image/heartIcon.png">
				</div>
				
				<div class="userProfile">
						<div class="userImage">
							<img src="${pageContext.request.contextPath}/image/cat.jpg">
						</div>
						<div class="username">${partner.nickname}</div>
				</div>
			</c:if>	
					
		</div>
		<!-- 파트너 매칭전: 초대하기 버튼, 디데이표시 등 -->
		<c:if test="${user.matching == '매칭전'}">
			<div class="inviteState">
				<button type="button" class="inviteBtn" data-toggle="modal" data-target="#myModal">초대하기</button>
			</div>		
		</c:if>
		
		<c:if test="${user.matching == '요청함'}">
			<div class="inviteState2">
				초대요청중
			</div>
		</c:if>

		<!-- 요청받은 유저는 로그인하여 메인페이지로 들어올때 요청 알림 모달 띄우기 -->
		<c:if test="${user.matching == '요청받음'}">
        		<div class="requestMsg">
        			${user.partnerId}님이 초대요청 하였습니다.<br>
					수락하시겠습니까?
				</div>
				<form class="requestBtnArea" action="inviteOk.do" method="post"  id="requestFrm">
					<input type="submit" class="requestBtn ok" value="수락">
					<!-- <div class="requestBtn no">거절</div> -->
				</form>
		</c:if>
		
		

		<ul class="navUl">
		    <li class="nav-item" onclick="clickMenu(this)">
		    	<a class="nav-link no-style" href="main.do">메인</a>
		    </li>
		    
		    <li class="gagyebuLi">
		   		<p>가계부</p>

		   		<div class="subMemu">
			    	<a class="nav-link no-style" href="gagyebu.do" onclick="clickMenu(this)">월별 가계부</a>
				    <a class="nav-link no-style" href="gagyebuMonth.do" onclick="clickMenu(this)">결산</a>		   		
		   		</div>
		    </li>
		    
<!-- 		    <li class="nav-item" onclick="clickMenu(this)">
		    	<a class="nav-link no-style" href="schedule.do">일정</a>
		    </li> -->
   		    <li class="nav-item" onclick="clickMenu(this)">
		    	<a class="nav-link no-style" href="story.do">스토리</a>
		    </li>
  		    <li class="nav-item" onclick="clickMenu(this)">
		    	<a class="nav-link no-style" href="mypage.do">마이페이지</a>
		    </li>
		</ul>
		
		<div class="logoutBtn">
			<a class="no-style" href="logout.do">로그아웃</a>
		</div>
		</div>
		
</html>