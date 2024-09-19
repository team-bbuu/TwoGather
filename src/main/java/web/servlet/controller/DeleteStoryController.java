package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.StoryDAOImpl;

public class DeleteStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		//폼값 받기 
		//id 받을 방법 모르겠음
		String path ="error.jsp";
		int id =Integer.parseInt(request.getParameter("storyId"));
		try {
		StoryDAOImpl.getInstance().deleteStory(id);
		path= "story.jsp";
		}catch (SQLException e) {
			
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
