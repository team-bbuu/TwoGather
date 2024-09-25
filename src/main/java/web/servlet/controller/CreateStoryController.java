package web.servlet.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
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
	        
	        String uploadsDirPath = request.getServletContext().getRealPath("/uploads");
//	        String uploadsDirPath = "C:\\Users\\Sunmin\\Desktop\\284\\Kosta284\\Kosta284\\TwoGather\\src\\main\\webapp\\uploads";
	        
	        // 현정
//	        String uploadsDirPath ="Users/emily/Dev/kosta-projects/TwoGather/src/main/webapp/uploads/";
	        
	        File uploadsDir = new File(uploadsDirPath);
	        if (!uploadsDir.exists()) {
	            uploadsDir.mkdir(); // Create the directory if it doesn't exist
	        }

	        // Optionally, prevent file name collisions
	        String newFileName = System.currentTimeMillis() + "_" + fileName;
	        String savePath = uploadsDirPath + File.separator + newFileName;
	
	        filePart.write(savePath);
	        // Now save the file path to the database
	        String imgSrc = newFileName;
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			Story story = new Story(0, userId, uploadDate, imgSrc, title, content);
			StoryDAOImpl.getInstance().createStory(story);
			path= "story.do";
		}catch (SQLException | IOException | ServletException e) {
			System.out.println(e.getMessage());
		}

		return new ModelAndView(path,true);
	}

}