package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.UserDAOImpl;

public class FindPassController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id =request.getParameter("id");
		String birthDate =request.getParameter("birthdate");
		try {
			String password = UserDAOImpl.getInstance().findPass(id, birthDate);
			if(password!=null) {
				response.getWriter().write(password);
			}
		} catch (Exception e) {
			
		}
		return null;
	}

}
