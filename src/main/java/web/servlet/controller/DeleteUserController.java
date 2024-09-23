package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class DeleteUserController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		String path= "error.jsp";	
		HttpSession session = request.getSession();
		User user= (User)session.getAttribute("user");
		String id = user.getId();
		try {
		UserDAOImpl.getInstance().deleteUser(id);
		path="login.jsp";
		}catch (SQLException e) {
				}
		return new ModelAndView(path);
	}

}
