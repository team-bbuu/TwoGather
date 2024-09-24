package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class RegisterController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		//폼값 받아서
		String id = request.getParameter("id");
		String passward = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String mobile = request.getParameter("mobile");
		String birthDate = request.getParameter("birthdate");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		
		//dao 호출
		UserDAOImpl dao = UserDAOImpl.getInstance();
		try {
		if(dao.checkEmail(email) | dao.checkMobile(mobile)) { //email, mobile 중복일 때
			response.getWriter().write("fail");
		}else { // 중복 아닐 때
			User user = new User(id, passward, nickname, mobile, birthDate, email, gender, address);
			dao.register(user);
			response.getWriter().write("success");
		}
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;

	}

}
