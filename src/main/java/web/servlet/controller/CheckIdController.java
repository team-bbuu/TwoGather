package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class CheckIdController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id =request.getParameter("id");

		try {
			User user = UserDAOImpl.getInstance().FindUser(id);
			String gson = new Gson().toJson(user);
			response.getWriter().write(gson);
		} catch (Exception e) {
			
		}
		return null;
	}
}
