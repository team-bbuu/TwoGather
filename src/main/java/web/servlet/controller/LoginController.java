package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class LoginController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String page = "error.jsp";
		//폼값 받아서
		String id = request.getParameter("id");
		String pass = request.getParameter("passward");
		//dao 호출
		try {
		User user = UserDAOImpl.getInstance().login(id, pass);
		HttpSession session = request.getSession();
		//바인딩
		if(user!=null) {
			session.setAttribute("user", user);
			if(user.getMatching().equals("매칭완료")) {
				User partner = UserDAOImpl.getInstance().FindUser(user.getPartnerId());
				User partner2 = new User(partner.getId(), partner.getNickname(), partner.getImgSrc());
				session.setAttribute("partner", partner2);
			}
			page="main.do";
		}
		}catch (SQLException e) {
			
		}request.setAttribute("page", page);
		return new ModelAndView("dashboard.jsp");
	}

}
