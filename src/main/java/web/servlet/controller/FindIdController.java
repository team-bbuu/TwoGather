package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;

import web.servlet.model.dao.UserDAOImpl;

public class FindIdController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String email =request.getParameter("email");
		String mobile =request.getParameter("mobile");
		String path = "";
		try {
			String userId = UserDAOImpl.getInstance().findId(email, mobile);
			if(userId!=null) {
				request.setAttribute("userId", userId);
				path = ""; // path설정 고민
			}
		} catch (Exception e) {
			
		}
		return new ModelAndView(path);
	}
}