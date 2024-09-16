<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!-- css 파일 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/monthGagyebu.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- 왼쪽 영역 : 사이드바jsp -->
       <div class="nav"style="border: 1px solid red; width: 25%; height: 100%;"></div>

        <!-- 오른쪽 영역 : 콘텐츠 영역 -->
        <div class="dashboard-content">
        	<!-- 각 jsp -->
        	<jsp:include page="monthGagyebu.jsp" />
        </div>
    </div>
</body>
</html>