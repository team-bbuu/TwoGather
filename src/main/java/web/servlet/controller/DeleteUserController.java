package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class DeleteUserController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		User user= (User)session.getAttribute("user");
		String id = user.getId();
		
		UserDAOImpl.getInstance().deleteUser(id);
		return null;
	}

}
