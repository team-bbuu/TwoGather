<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!-- css 파일 -->
	<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css"> --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	
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
    overflow: hidden;
}
	</style>
</head>
<body>
    <div class="dashboard-container">
        <!-- 왼쪽 영역 : 사이드바jsp -->
       <div class="nav"style="border: 1px solid red; width: 25%; height: 100%;">
       		<jsp:include page="nav.jsp" />
       </div>
			
        <!-- 오른쪽 영역 : 콘텐츠 영역 -->
        <div class="dashboard-content">
        	<jsp:include page="${page}" />
        	
        </div>
    </div>
</body>
</html>
