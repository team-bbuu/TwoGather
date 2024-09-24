package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.UserDAOImpl;

public class FindIdController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String email =request.getParameter("email");
		String mobile =request.getParameter("mobile");
		try {
			String userId = UserDAOImpl.getInstance().findId(email, mobile);
			if(userId!=null) {
				response.getWriter().write(userId);
			}
		} catch (Exception e) {
			
		}
		return null;
	}
}