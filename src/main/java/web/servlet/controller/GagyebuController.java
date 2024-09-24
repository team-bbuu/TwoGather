package web.servlet.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.vo.Gagyebu;
import web.servlet.model.vo.User;

// 월별 가계부 생성
public class GagyebuController implements Controller{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ArrayList<Gagyebu> gagyebus = new ArrayList<Gagyebu>();
		
		String yearMonth = request.getParameter("yearMonth"); //2024-09
		if(yearMonth == null) {
			yearMonth= String.valueOf(LocalDate.now()).substring(0,7);
		}
		User user = (User)session.getAttribute("user");
		User partner = (User)session.getAttribute("partner");
		
		String path = "gagyebu.jsp";
		
		try {
			gagyebus = GagyebuDAOImpl.getInstance().getMonthGagyebu(yearMonth, user.getId(), partner.getId());
			
			request.setAttribute("gagyebus", gagyebus);
			
		}catch (SQLException e) {
			path = "error.jsp";
		}
		
		request.setAttribute("page", path);
		
		return new ModelAndView("dashboard.jsp");
	}

}
