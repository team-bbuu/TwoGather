package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
//		String path = "landing.jsp"; // 메인홈페이지
		String path = "login.jsp";
		try {
			HttpSession session = request.getSession();
			if(session.getAttribute("user") != null) {
				session.invalidate();
			}
		} catch (Exception e) {
			path = "error.jsp";
		}
		return new ModelAndView(path);
	}

}
