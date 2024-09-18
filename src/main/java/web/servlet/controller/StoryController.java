package web.servlet.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;

public class StoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String id = user.getId();
		String partnerId = user.getPartnerId();
		ArrayList<Story> list = StoryDAOImpl.getInstance().getAllStory(id, partnerId);
		request.setAttribute("list", list);
		return null;
	}

}
