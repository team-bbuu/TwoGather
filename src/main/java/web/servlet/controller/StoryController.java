package web.servlet.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;

public class StoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String path = "error.jsp";
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		String id = user.getId();
		String partnerId = user.getPartnerId();
		try {
		ArrayList<Story> list = StoryDAOImpl.getInstance().getAllStory(id, partnerId);
		request.setAttribute("list", list);
		path="story.jsp";
		}catch (SQLException e) {
			
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
