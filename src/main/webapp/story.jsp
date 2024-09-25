<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
	#container{
		overflow-y: scroll;
		height: 100%;
	}
	.storyImg{
		width: 150px;
		height: 150px;
		margin: auto;
	}

    #dropdown {
        width: 600px;
        background-color: white;
        margin-left: 50px;
        display: none;
        position: absolute;
        z-index: 10;
    }
    
    .input-group{
    	width: 600px;
    	margin-top: 5px;
    	position: relative;
    	display: flex;
    }
    
    #searchTitle{
    	width: 100%;
    }
    
    
    #searchBtn{
    	width: 25px;
    	height: 25px;
    	top: 5px;
    	bottom: 5px;
    	right: 5px;
    	position: absolute;
    }
    
    #createBtn{
    	width: 40px;
    	height: 40px;
    	margin-top: 10px;
    	margin-right: 40px;
    }
    
    .latestTitle, #searchBtn, #createBtn, .storyImg{
    	cursor: pointer;
    }
    
    .cardDelete{
    	width: 20px;
    	height: 20px;
    	position: absolute;
    	right: 0;
    	top: 0;
    	cursor: pointer;
    }
    
    .cardUpdate{
    	width: 20px;
    	height: 20px;
    	position: absolute;
    	right: 25px;
    	top: 0;
    	cursor: pointer;
    }
    
    
    .card{
    	width: 20%;
    }
    
    .modalDelete{
    	width: 20px;
    	height: 20px;
    	cursor: pointer;
    }
    
    .modalUpdate{
    	width: 20px;
    	height: 20px;
    	cursor: pointer;
    }
</style>
<script type="text/javascript">
	$(()=>{
		getLocalStorage();
		
		$(".card-body").on("click", function() {
			$("#img").attr("src", "${pageContext.request.contextPath}/uploads/" + $(this).prev().attr("id"));
			$("#title").html($(this).find(".title").html());
			$("#content").html($(this).find(".content").html());
			$("#storyId").html($(this).find(".storyId").html());
			$("#uploadDate").html($(this).find(".uploadDate").html());
			$("#detailModal").modal("show");
		});
		
		$(".card-img-top").on("click", function() {
			$("#img").attr("src", "${pageContext.request.contextPath}/uploads/" + $(this).attr("id"));
			$("#title").html($(this).next().find(".title").html());
			$("#content").html($(this).next().find(".content").html());
			$("#storyId").html($(this).next().find(".storyId").html());
			$("#uploadDate").html($(this).next().find(".uploadDate").html());
			$("#detailModal").modal("show");
		});
		
		$(".deleteBtn").on("click", function() {
			$("#detailModal").modal("hide");
			$("#messageModal").find(".modal-body").html("정말 삭제하시겠습니까?");
			$("#messageModal").find(".modal-footer").html("<button type='button' class='btn btn-danger' id='delete'>삭제하기</button>");
			$("#delete").attr("value", $(this).parent().prev().find(".storyId").html());
		});
		
		$("#submit").on("click", function() {
			if($("#imgForm").val()!=""&&$("#titleForm").val()!=""){
				document.frm.submit();
			}else{
				$("#formModal").modal("hide");
				$("#messageModal").find(".modal-body").html("정보를 입력해주세요");
				$("#messageModal").find(".modal-footer").html("<button type='button' class='btn btn-danger' data-dismiss='modal' data-toggle='modal' data-target='#formModal'>확인</button>");
				$("#messageModal").modal("show");
			}
		});
		
		$(".updateBtn").on("click", function() {
			$(".inputImg")[0].reset();
			$("#titleForm").val($(this).parent().prev().find(".title").html());
			$("#contentForm").val($(this).parent().prev().find(".content").html());
			$("#submit").html("수정하기");
			$(".inputImg").attr("action", "updateStory.do");
			$("#storyIdForm").val($(this).parent().prev().find(".storyId").html());
			let parent = $(this).parent();
			if(parent.attr("class")=="modal-footer"){
				$("#image-show").html("<img src='" + parent.siblings(".modal-body").find("#img").attr("src") + "' class='storyImg'>");
				$("#detailModal").modal("hide");
			}else{
				$("#image-show").html("<img src='" + parent.siblings(".storyImg").attr("src") + "' class='storyImg'>");
			}
			$("#formModal").modal("show");
		});
		
		$("#createBtn").on("click", function() {
			$(".inputImg")[0].reset();
			$("#image-show").html("");
			$("#submit").html("작성하기");
			$(".inputImg").attr("action", "createStory.do");
		});
		
		$("#messageModal").find(".modal-footer").on('click', '#refresh', refresh);
		$("#messageModal").find(".modal-footer").on('click', '#delete', deletef);
		$("#dropdown").on('click', '.latestTitle', latestTitle);
		
		function refresh() {
			location.href = "story.do";
		};
		
		function deletef(){
			$.ajax({
				type:'post',
				url:'deleteStory.do',
				data:{'storyId':$(this).val()},
			
				success: function(result){
					$("#messageModal").find(".modal-body").html("삭제가 완료되었습니다.");
					$("#messageModal").find(".modal-footer").html("<button type='button' class='btn btn-danger' id='refresh' data-dismiss='modal'>확인</button>");
				}
			});
		}
		
	    var nameArr;

		function getLocalStorage() {
			nameArr = [];
	    	for (let i = 0; i < localStorage.length; i++) {
				let key = localStorage.key(i);
				if (key.startsWith("TwoGatherTitle")) {
					let data = localStorage.getItem(key);
					nameArr.push(data);
				}
	    	}	
		}
		
		$("#searchBtn").on("click", function() {
			localStorage.setItem('TwoGatherTitle' + '&' + $("#searchTitle").val(), $("#searchTitle").val());
			location.href = "selectStory.do?title=" + $("#searchTitle").val();
		})
		
	    
	    $("#searchTitle").keyup(function () {
	        if (!this.value.trim()) {
	            $("#dropdown").html();
	            $("#dropdown").css("display","none");
	            return;
	        }
	        $("#dropdown").html();
	        $("#dropdown").css("display","none");


	        let schArr = [];
	        for (let i = 0; i < nameArr.length; i++) {
	            if (nameArr[i].includes(this.value)) {
	                schArr.push("<div class='latestTitle'>" + nameArr[i] + "</div>");
	            }
	        }

	        if (schArr.length) {
	        	let sch = "";
	            schArr.forEach((item) => {
	            	sch += item;
	            })
	            $("#dropdown").html(sch);
	            $("#dropdown").css("display","block");
	        }

	        if (event.keyCode == 13) {
	            if ($("#dropdown").children().first()) {
	                $("#searchTitle").val($("#dropdown").children().first().html());
	                $("#dropdown").css("display","none");
	            }
	        }
	    });
	    
	    function latestTitle() {
	    	$("#searchTitle").val($(this).html());
	    	$("#dropdown").css("display","none");
		};
	});
</script>
</head>

    <div class="modal fade" id="messageModal" data-backdrop='static' data-keyboard='false'>
    	<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content"> 
        		<!-- Modal Header -->
        		<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
        		</div>
        
        		<!-- Modal body -->
        		<div class="modal-body">
        		</div>
        
      			<!-- Modal footer -->
        		<div class="modal-footer">
        		</div>
      		</div>
      	</div>
    </div>
    
    <div class="modal fade" id="formModal" data-backdrop='static' data-keyboard='false'>
    	<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content"> 
        		<!-- Modal Header -->
        		<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
        		</div>
        
        		<!-- Modal body -->
        		<div class="modal-body">
	        		<form class="inputImg" method="post" enctype="multipart/form-data" action="createStory.do" name="frm">
					    <div class="addImage" id="image-show"></div>
					    <label for="imgForm">
							업로드
						</label>
						<input type="file" accept="image/*" onchange="loadFile(this)" name="img_src" id="imgForm" style="display: none;"/>
					    <div class="form-group">
						    <label for="titleForm">제목:</label>
						    <input type="text" class="form-control" id="titleForm" name="title">
					    </div>
					    <div class="form-group">
						    <label for="contentForm">게시물 내용:</label>
						    <input type="text" class="form-control" id="contentForm" name="content">
					    </div>
					    <input type="text" id="storyIdForm" name="storyId" style="display: none;">
				    </form>
        		</div>
        
      			<!-- Modal footer -->
        		<div class="modal-footer">
        			<button type="button" class="btn btn-danger" id="submit">작성하기</button>
        		</div>
      		</div>
      	</div>
    </div>
    
	<div class="modal fade" id="detailModal" data-backdrop='static' data-keyboard='false'>
    	<div class="modal-dialog modal-dialog-centered">
    		<div class="modal-content"> 
        		<!-- Modal Header -->
        		<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal">&times;</button>
        		</div>
        
        		<!-- Modal body -->
        		<div class="modal-body">
        			<img alt="뭘까요...." src="" id="img" class="storyImg"><br/><br/>
					제목:<div id="title" class="title"></div><br/>
					게시물 내용:<br/> <div id="content" class="content"></div>
					<div style="display: none;" id="storyId" class="storyId"></div>
					<div style="display: none;" id="uploadDate"></div>
					
        		</div>
        
      			<!-- Modal footer -->
        		<div class="modal-footer" style="justify-content: space-evenly;">
        			<img alt="수정" src="${pageContext.request.contextPath}/image/수정.png" class="updateBtn modalUpdate">
					<img alt="삭제" src="${pageContext.request.contextPath}/image/삭제.png" class="deleteBtn modalDelete" data-toggle="modal" data-target="#messageModal">
        		</div>
      		</div>
      	</div>
    </div>
    
	<div id="container">
		<div class="d-flex justify-content-between mt-4" style="margin-right: 15px; margin-left: 50px;">
			<div class="input-group">
				<input type="text" placeholder="Search" class="rounded-top border border-right-0 border-top-0 border-left-0" name="searchTitle" id="searchTitle" value="" autocomplete="off">
				<img alt="검색" src="${pageContext.request.contextPath}/image/search.png" id="searchBtn">
			</div>
			<img alt="검색" style="margin-top: 0;" src="${pageContext.request.contextPath}/image/addStory.png" id="createBtn" data-toggle="modal" data-target="#formModal">
		</div>
		<div id="dropdown"></div>
		<div class="d-flex flex-wrap">
			<c:forEach items="${list}" var="story">			
				<div class="card rounded-5 mt-3 ml-5">
					<img alt="뭘까요?" src="${pageContext.request.contextPath}/uploads/${story.imgSrc}" id="${story.imgSrc}" class="storyImg card-img-top">
				
					<div class="card-body">
						<div id="${story.uploadDate }" class="uploadDate">${story.uploadDate }</div>
						<div id="${story.title}" class="title">${story.title }</div>
						<div style="display: none;" class="storyId">${story.id}</div>
						<div style="display: none;" class="content">${story.content}</div>
					</div>
					<div class="card-footer p-0">
						<img alt="수정" src="${pageContext.request.contextPath}/image/수정.png" class="updateBtn cardUpdate">
						<img alt="삭제" src="${pageContext.request.contextPath}/image/삭제.png" class="deleteBtn cardDelete" data-toggle="modal" data-target="#messageModal">
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
<script type="text/javascript">
	function loadFile(input) {
		let file = input.files[0]; // 선택 파일 가져오기
		let newImg = document.createElement("img"); // 새 이미지 태그 생성
	
		// 이미지 source 가져오기
		newImg.src = URL.createObjectURL(file);
		newImg.className = "storyImg";
		// newImg.style.width = "100%";
		// newImg.style.height = "100%";
		// newImg.style.objectFit = "cover";
	
		// 이미지를 image-show div 에 추가
		let container = document.getElementById("image-show");
		container.innerHTML = "";
		container.appendChild(newImg);
		//$("#imgForm").val("/image/a.jpg" );
	}
</script>
</html>