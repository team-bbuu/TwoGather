package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class CheckIdController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id =request.getParameter("id");
		String path = "";
		boolean isExist = false;
		try {
			User user = UserDAOImpl.getInstance().FindUser(id);
			if(user!=null) {
				isExist = true;
			}
			request.setAttribute("isExist", isExist);
		} catch (Exception e) {
			
		}
		return new ModelAndView(path);
	}
}
