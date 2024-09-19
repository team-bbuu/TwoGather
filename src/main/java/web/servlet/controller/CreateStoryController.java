package web.servlet.controller;

import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;

public class CreateStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		String path="error.jsp";
		String userId = ((User)request.getSession().getAttribute("user")).getId();
		String uploadDate = String.valueOf(LocalDate.now());
		String imgSrc = request.getParameter("img_src"); // 폼 이름 지정 필요
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		Story story = new Story(0, userId, uploadDate, imgSrc, title, content);
		try {
		StoryDAOImpl.getInstance().createStory(story);
		path= "story.jsp";
		}catch (SQLException e) {
			
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
