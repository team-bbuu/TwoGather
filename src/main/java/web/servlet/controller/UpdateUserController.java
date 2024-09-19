package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;


public class UpdateUserController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		//폼값 받아서
		String imgSrc = request.getParameter("imgSrc");
		String password = request.getParameter("password");
		String nickName = request.getParameter("nickname");
		String mobile =request.getParameter("mobile");
		String email =request.getParameter("email");
		String address =request.getParameter("address");
		
		String path="error.jsp";
		//email,mobile 검증
		UserDAOImpl dao = UserDAOImpl.getInstance();
		HttpSession session = request.getSession();
		try {
		if(dao.checkEmail(email)|dao.checkMobile(mobile) ) {
			//이미 존재하는 email, mobile일 경우 
			
		}else { // mobile,email 중복 x
			User user = (User)session.getAttribute("user");
			//정보 수정
			user.setimgSrc(imgSrc);
			user.setPassword(password);
			user.setNickname(nickName);
			user.setMobile(mobile);
			user.setEmail(email);
			user.setAddress(address);
			//변경된 유저 db 저장
			
			dao.updateUser(user);
			path= "myPage.jsp";
			//변경된 유저 세션 저장
			session.setAttribute("user", user);
			}
		}catch (SQLException e) {
			
		}
		
		
		return new ModelAndView("dashboard.jsp");
	}

}
