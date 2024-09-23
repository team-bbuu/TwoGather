package web.servlet.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;


public class CreateStoryController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		String path="error.jsp";
		String userId = ((User)request.getSession().getAttribute("user")).getId();
		String uploadDate = String.valueOf(LocalDate.now());
		try {
			// Get the uploaded file (img_src from the form)
	        Part filePart = request.getPart("img_src"); // Retrieves <input type="file" name="img_src">
	        String fileName = filePart.getSubmittedFileName();
	
	        // Define the path where you want to save the file (on your server)
	        String savePath = request.getServletContext().getRealPath("/uploads") + File.separator + fileName;
	        File fileSaveDir = new File(savePath);
	
	        // Save the file to the specified path
	        filePart.write(savePath);
	
	        // Now save the file path to the database
	        String imgSrc = "/uploads/" + fileName;
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			System.out.println(imgSrc + ", " + title + ", " + content);
			Story story = new Story(0, userId, uploadDate, imgSrc, title, content);
			StoryDAOImpl.getInstance().createStory(story);
			path= "story.do";
		}catch (SQLException | IOException | ServletException e) {
			System.out.println(e.getMessage());
		}
		return new ModelAndView(path);
	}

}
