<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Insert title here</title>
	<link rel="stylesheet" href="resources/css/myPageImage.css" />
	<link rel="stylesheet" href="resources/css/myPageModal.css" />
	<link rel="stylesheet" href="resources/css/imageUpload.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="resources/js/myPageImage.js"></script>

	<style type="text/css">
		button {
		    background: none; /* 배경 제거 */
		    border: none; /* 테두리 제거 */
		    padding: 0; /* 패딩 제거 */
		    margin: 0; /* 마진 제거 */
		    font: inherit; /* 상속된 폰트 사용 */
		    color: inherit; /* 상속된 텍스트 색상 사용 */
		    cursor: pointer; /* 클릭 가능 커서 */
		}
		.myPageSection {
			overflow: hidden;
			width: 100%;
			height: 100%;
			padding: 2%;
			background: #F6F6FE;
			color: #4D4D4D;
			font-size: 10px;
		}
		
		#right {
			flex: 1;
			display: flex;
			font-size: 17px;
		}
		#myPage {
			width: 100%;
			display: flex;
			flex-direction: column;
			align-items: center;
		}	
		form {
			width: 70%;
		}
		input[type="text"] {
			width: 320px;
			height: 30px;
			margin-bottom: 10px;
/* 			margin-left: 40px; */
		}
		/* 정보수정 버튼 */
		.btnArea {
			display: flex;
			justify-content: center;
			align-content: center;
		}
		.updateBtn{
			width: 300px;
			height: 50px;
			border: 1px solid #4D4D4D;
			font-size: 24px;
			border-radius: 25px;
			margin: 15px 0px;
		
		}
	
		/* 모달css */
		.modal_btn_image, .modal_btn_image>img, modal_popup>img {
			width: 150px;
			height: 150px;
			border-radius: 50%;
		    cursor: pointer;
		}
		.modal_btn_image:hover {
		    box-shadow: 3px 4px 11px 0px #00000040;
		}
		.modal_image.on, .modal_break.on, .modal_delete.on {
		    display: block;
		}		
		/*모달 팝업 영역 스타일링*/
		.modal_image, .modal_break, .modal_delete {
		/*팝업 배경*/
			display: none; /*평소에는 보이지 않도록*/
		    position: absolute;
		    top:0;
		    left: 0;
		    width: 100%;
		    height: 100vh;
		    overflow: hidden;
		    background: rgba(0,0,0,0.5);
		}
		.modal_popup {
		/*팝업*/
			
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    padding: 20px;
		    background: #ffffff;
		    border-radius: 20px;
		}
		.modal_popup .close_btn_image, .close_btn_break, .close_btn_image_delete  {
		    display: block;
		    padding: 10px 20px;
		    background-color: rgb(116, 0, 0);
		    border: none;
		    border-radius: 5px;
		    color: #fff;
		    cursor: pointer;
		    transition: box-shadow 0.2s;
		}
		/* 모달css 끝 */
		
		#modal_break_btn, #modal_deteleUser_btn {
		    cursor: pointer;
		    color: inherit;
		    text-decoration: none;
		}
		#myPage-footer {
			display: inline-flex;
		}
		
		.addImage {
		  width: 400px;
		  height: 300px;
		  background-color: lightgray;
		  border-radius: 20px 20px / 20px 20px;
		  overflow: hidden;
		  margin: 0px 10px 10px 0px;
		}
		
		.inputImg {
		  width: 450px;
		  height: 350px;
		}
		
		.addImage > img {
		  width: 100%;
		  height: 100%;
		  object-fit: cover;
		}
		
		.profileImage{
			position: relative;
			width: 10vw;
			height: 10vw;
			border-radius: 50%;
			overflow: hidden;
		
		}
		.profileImage > img{
			width: 100%;
			height: 100%;
	        object-fit: cover;
			
		}
		#myPage-id{
			text-align: center;
			margin: 15px 0px;
			font-weight: bolder;
		}
		#update{
			font-weight: bolder;
		}
		.modal_btn_break,.modal_btn_delete{
			margin: 0px 10px;
		}
		.label{
			width: fit-content;
		}
		.inputSection{
			display: flex;
			justify-content: space-between;
		}
		
	</style>
	<script type="text/javascript">

		$(()=>{
		    $('[name=update]').on('submit', function(event) {
		        event.preventDefault(); // 폼 제출 방지
	
		        $.ajax({
		            type: "post",
		            url: 'updateUser.do',
		            data: $(this).serialize(),
		            
		            success: function(result) {
		                if (result.success === true) {
		                    alert("수정이 완료되었습니다");
		                } else {
		                	$('#resultEmail').html("");
		                    $('#resultMobile').html("");
		                    if (result.checkEmail === true) {
		                        $('#resultEmail').html("이미 사용중인 이메일입니다");
		                    }
		                    if (result.checkMoblie === true) {
		                        $('#resultMobile').html("이미 사용중인 연락처입니다");
		                    }
		                }
		            },
		            error: function(e) {
		                console.log(e.message);
		            }
		        });
		    });
		    
		    $('[name=updateImage]').on('click', function() {
		    	let image = "";
		        $.ajax({
		            type: "post",
		            url: 'updateUser.do',
		            data: {'image':image},
		            
		            success: function(result) {
		            	$('.modal_image').css("display", "none");
		            },
		            error: function(e) {
		                console.log(e.message);
		            }
		        });
		    });
		    
		    $('[name=break]').on('click', function() {
		        $.ajax({
		            type: "post",
		            url: 'breakPartner.do',
		            
		            success: function(result) {
		            	$('.modal_break').css("display", "none");
		            },
		            error: function(e) {
		                console.log(e.message);
		            }
		        });
		    });
		    
		    $('[name=delete]').on('click', function() {
		        $.ajax({
		            type: "post",
		            url: 'deleteUser.do',

		            success: function(result) {
		            	location.href = "login.jsp";
		            },
		            error: function(e) {
		                console.log(e.message);
		            }
		        });
		    });
		  
		});	
	</script>
</head>
	<c:choose>
		<c:when test="">
		
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	<div class="myPageSection">
		<!-- 왼쪽 NAV -->
		<div id="right">
			<div id="myPage">
			
				<div id="myPage-image">
					<!--모달 팝업-->
					<div class="modal_image">
					    <div class="modal_popup">
					        <h3>프로필 이미지</h3>
					        <!-- 이미지파일업로드 부분-->
							<form class="inputImg" method="post" enctype="multipart/form-data">
						    	<!-- 이미지 파일 받기위해 enctype 설정 -->
						        <div class="addImage " id="image-show">
						        	
						        	
						        </div>
						        <!-- 이미지 보여줄 영역 -->
						        <input type="file" accept="image/*" onchange="loadFile(this)" id="imageUpload"/>
						        <!-- input이나 select 등의 데이터가 변경될때 호출, 파일 불러왔을때 loadFile 함수실행 -->
						    </form>
					        <button type="button" name="updateImage">적용</button>
					        <button type="button" class="close_btn_image">닫기</button>
					    </div>
					</div>
					
					<!--end 모달 팝업-->
					<main>
					    <section>
					       <%--  <button type="button" class="modal_btn_image">
					            <img src="${user.imgSrc}">
					        </button> --%>
					        <div class="profileImage">
					        	
						        <c:if test="${!user.imgSrc.equals('default')}">
						        	<img src="${pageContext.request.contextPath}/uploads/${user.imgSrc}">
						        </c:if>
						        <c:if test="${user.imgSrc.equals('default')}">
						        	<img src="${pageContext.request.contextPath}/image/profileDefault.png">
						        </c:if>
					        	
					        
					        </div>
					    </section>
					</main>
				</div>
				
				<form action="updateUser.do" method="post">
					<div id="myPage-id">
						${user.id}
					</div>
					<div id="update">
						<div class="inputSection">
							<div class="label">패스워드</div>
							<input type="text" placeholder="변경할 패스워드를 입력해주세요" name="password">
						</div>
						
						<div class="inputSection">
						<div class="label">패스워드 확인</div>
						<input type="text" placeholder="변경할 패스워드를 다시 입력해주세요">
						</div>
						
						<div class="inputSection">
						<div class="label">닉네임</div>
						<input type="text" placeholder="닉네임을 입력해주세요" name="nickname">
						</div>
						
						<div class="inputSection">
						<div class="label">연락처</div>
						<input type="text" placeholder="연락처를 입력해주세요" name="mobile">
						</div>
						
						<div id="resultMobile"></div>
						
						<div class="inputSection">
						<div class="label">생년월일</div>
						<input type="text" disabled="disabled" value="${user.birthdate}">
						</div>
						
						<div class="inputSection">
						<div class="label">이메일</div>
						<input type="text" placeholder="이메일을 입력해주세요" name="email">
						</div>
						
						<div id="resultEmail"></div>
						
						<div class="inputSection">
						<div class="label">성별</div>
						<c:if test="${user.gender.equals('m')}">
						<input type="text" disabled="disabled" value="남성">
						</c:if>
						<c:if test="${user.gender.equals('f')}">
						<input type="text" disabled="disabled" value="여성">
						</c:if>
						</div>
						
						<div class="inputSection">
						<div class="label">주소</div>
						<input type="text" placeholder="주소를 입력해주세요" name="address">
						</div>
						
					</div>
					
					<div class="btnArea">
						<input type="submit" name="update" value="정보수정" class="updateBtn">
					</div>
				</form>
				
				<div id="myPage-footer">
					<br />
					
					<!--모달 팝업-->
					<div class="modal_break">
					    <div class="modal_popup">
					        <h3>정말로 헤어지시겠습니까?</h3>
					        <button type="button" name="break">헤어지기</button>
					        <button type="button" class="close_btn_break">닫기</button>
					    </div>
					</div>
					<!--end 모달 팝업-->
					
					<main>
					    <section>
					        <button type="button" class="modal_btn_break">
					           헤어지기
					        </button>
					    </section>
					</main>
					
					|

					<!--모달 팝업-->
					<div class="modal_delete">
					    <div class="modal_popup">
					        <h3>정말로 탈퇴하시겠습니까?</h3>
					        <button type="button" name="delete">탈퇴하기</button>
					        <button type="button" class="close_btn_delete">닫기</button>
					    </div>
					</div>
					<!--end 모달 팝업-->
					<main>
					    <section>
					        <button type="button" class="modal_btn_delete">
					           회원탈퇴
					        </button>
					    </section>
					</main>


			</div>
		</div>
	</div>
	<script type="text/javascript">
/* 	const modalImage = document.querySelector('.modal_image');
	const modalBreak = document.querySelector('.modal_break');
	const modalDelete = document.querySelector('.modal_delete');
	const modalOpenImage = document.querySelector('.modal_btn_image');
	const modalOpenBreak = document.querySelector('.modal_btn_break');
	const modalOpenDelete = document.querySelector('.modal_btn_delete');
	const modalCloseImage = document.querySelector('.close_btn_image');
	const modalCloseBreak = document.querySelector('.close_btn_break');
	const modalCloseDelete = document.querySelector('.close_btn_delete');
 */
	/* modalOpenImage.addEventListener('click',function(){
	    modalImage.style.display = 'block';
	});
	modalCloseImage.addEventListener('click',function(){
	    modalImage.style.display = 'none';
	});

	modalOpenBreak.addEventListener('click',function(){
	    modalBreak.style.display = 'block';
	});
	modalCloseBreak.addEventListener('click',function(){
	    modalBreak.style.display = 'none';
	});

	modalOpenDelete.addEventListener('click',function(){
	    modalDelete.style.display = 'block';
	});
	modalCloseDelete.addEventListener('click',function(){
	    modalDelete.style.display = 'none';
	}); */
	
	function loadFile(input) {
		  let file = input.files[0]; // 선택 파일 가져오기

		  let newImg = document.createElement("img"); // 새 이미지 태그 생성

		  // 이미지 source 가져오기
		  newImg.src = URL.createObjectURL(file);
		  // newImg.style.width = "100%";
		  // newImg.style.height = "100%";
		  // newImg.style.objectFit = "cover";

		  // 이미지를 image-show div 에 추가
		  let container = document.getElementById("image-show");
		  container.appendChild(newImg);
		}
	</script>
	</div>
</html>