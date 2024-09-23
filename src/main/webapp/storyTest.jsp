<%@page import="web.servlet.model.vo.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% 
	User user = new User("id01", "image/a.jpg", "쭈니");
	user.setPartnerId("id20");
	session.setAttribute("user", user); %>
<a href="story.do">aaa</a>
</body>
</html>