<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <!-- css 파일관리 고민 -->
	<!-- <link rel="stylesheet" href="styles/dashboard.css"> -->
    <style type="text/css">
    /* 공통 */
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
	}

    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- 왼쪽 영역 : 사이드바jsp -->

        <!-- 오른쪽 영역 : 콘텐츠 영역 -->
        <!-- <div class="dashboard-content"> -->
        	<!-- 각 jsp -->
        <!-- </div> -->
    </div>
</body>
</html>
