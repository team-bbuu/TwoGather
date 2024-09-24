package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyPageController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("page", "myPage.jsp");
		return new ModelAndView("dashboard.jsp");
	}
	
}
