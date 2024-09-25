<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TwoGather</title>
    <!-- css 파일 -->

<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/monthGagyebu.css"> --%>
	<style type="text/css">
		*{
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Roboto', 'Helvetica', 'Arial', 'sans-serif';
			
		}
		input{
			border: none;
			outline: none;
		}
		ul {
			list-style: none;
			margin: 0;
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
		html body {
			background-color: #efeefe; /* 임시 색상 */
		}
		body {
			height: 100vh;
			display: flex;
			justify-content: center;
			align-items: center;
			/* color: #4D4D4D; */
			color: #5A5A5A;
		}
	
		.dashboard-container {
		    display: flex;
		    width: 90%;
		    height: 90vh;
/* 		    max-width: 1920px; */
			max-width: 1700px;
		    max-height: 972px;
			background-color: #f7f6fc;
		    border-radius: 15px;
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
		    overflow: hidden;
		}
		.dashboard-content{
			width: 80%;
			height: 100%;
			margin: 0 auto;
		
		}
		
		/* 상대방 초대하기 모달 */
		.modal-content{
			padding: 1vw;
		}
		.modalHeader {
			display: flex;
			justify-content: space-between;
			margin-bottom: 1vw;
		}
		.modal-title{
			font-size: 1.5vw;
			font-weight: bold;
		}
		.modalContent{
			margin-bottom: 1vw;
			
		}
		.inviteInput{
			width: 100%;
			height: 2vw;
			padding: 5px;
			border: 1px solid gray;
			margin-bottom: 1.4vw;
		}
		.buttonArea{
			display: flex;
			justify-content: center;
			gap: 1vw;
		}
		.modal-button{
			border-radius: 20px;
			padding: 5px 1.8vw;
		}
		.closeBtn{
			border: 1px solid #8c8c8c;
			color: #8c8c8c;
		}
		.confirmBtn{
			background-color: #8187f5;
			color: white;
		}
		
	</style>

	<!-- jQuery CDN 추가 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>
<body>
    <div class="dashboard-container">
        <!-- 왼쪽 영역 : 사이드바jsp -->
		<jsp:include page="nav.jsp" />

        <!-- 오른쪽 영역 : 콘텐츠 영역 -->
        <div class="dashboard-content">
        	<!-- 각 jsp -->
        	<c:import url="${page}"></c:import>
        	
        		<!-- 초대하기 모달 -->
				<div class="modal fade" id="myModal">
					<div class="modal-dialog modal-dialog-centered">
						<form class="modal-content" action="invitePartner.do" method="post" id="inviteFrm">
							<div class="modalHeader">
					        	<div class="modal-title">상대방 초대하기</div>
				        		<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							
				        	<div class="modalContent">
				        		<input type="text" class="inviteInput" placeholder="상대방 아이디를 입력하세요." id="partnerId" name="partnerId">
				        	</div>
				        	<div class="buttonArea">
					        	<button type="button" class="modal-button closeBtn" data-dismiss="modal">취소</button>
				        		<input type="submit" class="modal-button confirmBtn" id="confirmBtn" value="확인"/>
				        	</div>
				        
				        </form>
					</div>
				</div> 
				
				
				<div class="modal fade" id="matchingModal">
					<div class="modal-dialog modal-dialog-centered">
						<form class="modal-content" action="invitePartner.do" method="post" id="inviteFrm">
							<div class="modalHeader">
				        		<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							
				        	<div class="modalContent">
				        		안돼 돌아가
				        	</div>
				        	<div class="buttonArea">
					        	<button type="button" class="modal-button closeBtn" data-dismiss="modal">취소</button>
				        	</div>
				        
				        </form>
					</div>
				</div>        	
        </div>
    </div>
</body>
</html>
