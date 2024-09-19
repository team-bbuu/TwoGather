package web.servlet.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.ScheduleDAOImpl;
import web.servlet.model.vo.Schedule;
import web.servlet.model.vo.User;

public class ScheduleController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		HttpSession session = request.getSession();
		String yearMonth = request.getParameter("yearMonth");
		User user = (User)session.getAttribute("user");
		User partner = (User)session.getAttribute("partner");
		String path = "schedule.jsp";
		ArrayList<Schedule> schedules = new ArrayList<Schedule>();
		try {
			schedules = ScheduleDAOImpl.getInstance().getMonthSchedule(yearMonth, user.getId(), partner.getId());
			request.setAttribute("schedules", schedules);
		} catch (SQLException e) {
			path = "error.jsp";
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
