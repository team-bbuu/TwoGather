package web.servlet.controller;

import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;

public class UpdateStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//폼값 받아서
		//id 값을 어떻게 받을지 모르겠음
		int id = 0;
		String userId = ((User)request.getSession().getAttribute("user")).getId();
		String uploadDate = String.valueOf(LocalDate.now());
		String imgSrc = request.getParameter("imgSrc");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		Story story= new Story(id, userId, uploadDate, imgSrc, title, content);
		//DAO 호출
		StoryDAOImpl.getInstance().updateStory(story);
		
		return null;
	}

}
