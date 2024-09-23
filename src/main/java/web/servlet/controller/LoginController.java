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
		
		//폼값 받아서
		String id = request.getParameter("id");
		String pass = request.getParameter("password");
		//dao 호출
		try {
		User user = UserDAOImpl.getInstance().login(id, pass);
		HttpSession session = request.getSession();
		boolean isCorrect  = false;
		//바인딩
		if(user!=null) {
			isCorrect = true;
			session.setAttribute("user", user);
			if(user.getMatching().equals("매칭완료")) {
				User partner = UserDAOImpl.getInstance().FindUser(user.getPartnerId());
				User partner2 = new User(partner.getId(), partner.getNickname(), partner.getImgSrc());
				session.setAttribute("partner", partner2);
			}
			
		}
		response.getWriter().write(String.valueOf(isCorrect));
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

}
