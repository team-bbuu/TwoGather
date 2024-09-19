package web.servlet.controller;

import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;

public class UpdateStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		//폼값 받아서
		String path="error.jsp";
		int id = Integer.parseInt(request.getParameter("storyId")) ;
		String userId = ((User)request.getSession().getAttribute("user")).getId();
		String uploadDate = String.valueOf(LocalDate.now());
		String imgSrc = request.getParameter("imgSrc");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		Story story= new Story(id, userId, uploadDate, imgSrc, title, content);
		//DAO 호출
		try {
		StoryDAOImpl.getInstance().updateStory(story);
		path = "story.jsp";
		
		}catch (SQLException e) {
			
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
