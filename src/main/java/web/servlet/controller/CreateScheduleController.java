package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.ScheduleDAOImpl;
import web.servlet.model.vo.Schedule;
import web.servlet.model.vo.User;

public class CreateScheduleController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		HttpSession session = request.getSession();
		int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
		User user = (User)session.getAttribute("user");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String path = "schedule.jsp";
		Schedule schedule = new Schedule(scheduleId ,user.getId(), false, startDate, endDate, title, description);
		try {
			ScheduleDAOImpl.getInstance().createSchedule(schedule);
		} catch (SQLException e) {
			path = "error.jsp";
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
