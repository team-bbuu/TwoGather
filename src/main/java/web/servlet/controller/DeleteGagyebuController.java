package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.vo.Gagyebu;

// 가계부 삭제 컨트롤러
public class DeleteGagyebuController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String gagyebuId = request.getParameter("gagyebuId"); // 삭제할 가계부 아이디
		
		String path = "monthGagyebu.jsp";
		
		try {
			GagyebuDAOImpl.getInstance().deleteGagyebu(Integer.parseInt(gagyebuId));
			
		}catch (Exception e) {
			path = "error.jsp";
		}
		
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}
	
}
