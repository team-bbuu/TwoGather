package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.StoryDAOImpl;

public class DeleteStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//폼값 받기 
		//id 받을 방법 모르겠음
		int id = 0;
		
		StoryDAOImpl.getInstance().deleteStory(id);
		return null;
	}

}
