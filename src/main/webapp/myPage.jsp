<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="web.servlet.model.vo.User"%>
    <%
	User user = new User("id01", "id20", "image/login.jpg", "pass1", "쭈니", "010-1234-5678", "1997-02-10", "abcde1@gmail.com", "m", "서울시 강남구 역삼동", "매칭완료", "2024-09-13", "null");
	session.setAttribute("user", user);
	%>
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
		button {
		    background: none; /* 배경 제거 */
		    border: none; /* 테두리 제거 */
		    padding: 0; /* 패딩 제거 */
		    margin: 0; /* 마진 제거 */
		    font: inherit; /* 상속된 폰트 사용 */
		    color: inherit; /* 상속된 텍스트 색상 사용 */
		    cursor: pointer; /* 클릭 가능 커서 */
		}
		.dashboard-container {
		    display: flex;
		    width: 90%;
		    height: 90vh;
			background-color: #f7f6fc;
		    border-radius: 15px;

		}
		
		#right {
			flex: 1;
			display: flex;
			font-size: 1.2rem;
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
			border-radius: 150px;
		}
		form {
			width: 30%;
			
		}
		#update-btn {
			text-align: center;
		}
		input {
			width: 100%;
			height: 30px;
		}
		
		/* 모달css */
		.modal_btn_image, .modal_btn_image>img, modal_popup>img {
			width: 150px;
			height: 150px;
			border-radius: 150px;
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
<body>
	<div class="dashboard-container">
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
						        <div class="addImage" id="image-show">
						        	<img src="${user.imgSrc}" style="width: 150px; height: 150px; border-radius: 150px;">
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
					        <button type="button" class="modal_btn_image">
					            <img src="${user.imgSrc}">
					        </button>
					    </section>
					</main>
				</div>
				<form action="updateUser.do" method="post">
					<div id="myPage-id">
						${user.id}<br /><br /><br />
					</div>
					<div id="update">
						패스워드<br /><input type="text" placeholder="변경할 패스워드를 입력해주세요" name="password"><br /><br />
						패스워드 확인<br /><input type="text" placeholder="변경할 패스워드를 다시 입력해주세요"><br /><br />
						닉네임<br /><input type="text" placeholder="닉네임을 입력해주세요" name="nickname"><br /><br />
						연락처<br /><input type="text" placeholder="연락처를 입력해주세요" name="mobile"><br /><br />
						<div id="resultMobile"></div>
						<div>생년월일</div>
						<div>${user.birthdate}</div><br />
						이메일<br /><input type="text" placeholder="이메일을 입력해주세요" name="email"><br /><br />
						<div id="resultEmail"></div>
						<div>성별</div>
						<div>${user.gender}</div><br />
						주소<br /><input type="text" placeholder="주소를 입력해주세요" name="address"><br /><br />
					</div>
					<div id="update-btn">
						<br /><input type="submit" name="update" value="정보수정"><br />
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
	const modalImage = document.querySelector('.modal_image');
	const modalBreak = document.querySelector('.modal_break');
	const modalDelete = document.querySelector('.modal_delete');
	const modalOpenImage = document.querySelector('.modal_btn_image');
	const modalOpenBreak = document.querySelector('.modal_btn_break');
	const modalOpenDelete = document.querySelector('.modal_btn_delete');
	const modalCloseImage = document.querySelector('.close_btn_image');
	const modalCloseBreak = document.querySelector('.close_btn_break');
	const modalCloseDelete = document.querySelector('.close_btn_delete');

	modalOpenImage.addEventListener('click',function(){
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
	});
	
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
	
</body>
</html>