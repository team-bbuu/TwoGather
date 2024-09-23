package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.StoryDAOImpl;

public class DeleteStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		//폼값 받기 
		int id =Integer.parseInt(request.getParameter("storyId"));
		try {
			StoryDAOImpl.getInstance().deleteStory(id);
		}catch (SQLException e) {
			
		}
		return null;
	}

}
