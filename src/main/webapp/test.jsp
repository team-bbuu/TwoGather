 <%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
 
 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="UTF-8">
  </head>
  <body>
  
  <table>
      <tr>
          <th>번호</th>
          <th>제목</th>
          <th>글쓴이</th>
          <th>등록시간</th>
          <th>조회수</th>
      </tr>
      
    <%
 
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	try (
    		Connection conn = DriverManager.getConnection(
    				"jdbc:mysql://localhost:3306/TwoGather", "root", "Kosta284!@");
    		Statement stmt = conn.createStatement();
    		
  
    		ResultSet rs = stmt.executeQuery("select * from board order by num desc");
    		) {
    	
    		while (rs.next()) {    	
    %>
    		<tr>
    			<td style="text-align:center;"><%=rs.getInt("num")%></td>
    			<td style="text-align:left;">
    				<a href="view.jsp?num=<%=rs.getInt("num")%>">
    					<%=rs.getString("title") %>
    				</a>
    			</td>
    			<td style="text-align:center;"><%=rs.getString("writer") %></td>
    			<td style="text-align:center;"><%=rs.getString("regtime") %></td>
    			<td style="text-align:center;"><%=rs.getInt("hits") %></td>
    			</tr>
    <%
        	}
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	%>
  </table>
  

  </body>
  </html>