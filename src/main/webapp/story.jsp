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
		border: 2px solid;
	}

    #dropdown {
        width: 200px;
        border: 2px solid blue;
        display: none;
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
			$("#messageModal").find(".modal-body").html("정말 삭제하시겠습니까?");
			$("#messageModal").find(".modal-footer").html("<button type='button' class='btn btn-danger' id='delete'>삭제하기</button><button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
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
				$("#image-show").html("<img src='" + parent.siblings(".modal-body").find("#img").attr("src") + "'>");
				$("#detailModal").modal("hide");
			}else{
				$("#image-show").html("<img src='" + parent.siblings(".storyImg").attr("src") + "' >");
			}
			
		});
		
		$("#createBtn").on("click", function() {
			$(".inputImg")[0].reset();
			$("#image-show").html("");
			$("#submit").html("작성하기");
			$(".inputImg").attr("action", "createStory.do");
		});
		
		$("#searchBtn").on("clcik", function() {
			
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

    <div class="modal fade" id="messageModal">
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
    
    <div class="modal fade" id="formModal">
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
        			<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        		</div>
      		</div>
      	</div>
    </div>
    
	<div class="modal fade" id="detailModal">
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
        		<div class="modal-footer">
        			<button type="button" class="updateBtn btn btn-danger" data-toggle="modal" data-target="#formModal">수정하기</button>
					<button type="button" class="deleteBtn btn btn-danger" data-toggle="modal" data-target="#messageModal">삭제하기</button>
        			<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        		</div>
      		</div>
      	</div>
    </div>
    
	<div id="container">
		<button type="button" class="btn btn-danger" id="createBtn" data-toggle="modal" data-target="#formModal">작성하기</button>
		<div class="input-group mt-3">
			<input type="text" class="form-control" placeholder="Search" name="searchTitle" id="searchTitle" value="" autocomplete="off">
			<div class="input-group-append">
				<button class="btn btn-success" type="button" id="searchBtn">검색</button>
			</div>
		</div>
		<div id="dropdown"></div>
		<div class="d-flex flex-wrap mt-3">
			<c:forEach items="${list}" var="story">
			<%-- ${list.imgSrc}  /image/a.jpg --%>
			
				<div class="card">
			        <img alt="뭘까요?" src="${pageContext.request.contextPath}/uploads/${story.imgSrc}" id="${story.imgSrc}" class="storyImg card-img-top">
				
					<div class="card-body" data-toggle="modal" data-target="#detailModal">
						<div id="${story.uploadDate }" class="uploadDate">${story.uploadDate }</div>
						<div id="${story.title}" class="title">${story.title }</div>
						<div style="display: none;" class="storyId">${story.id}</div>
						<div style="display: none;" class="content">${story.content}</div>
					</div>
					<div class="card-footer">
						<button type="button" class="updateBtn btn btn-danger" data-toggle="modal" data-target="#formModal">수정하기</button>
						<button type="button" class="deleteBtn btn btn-danger" data-toggle="modal" data-target="#messageModal">삭제하기</button>
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