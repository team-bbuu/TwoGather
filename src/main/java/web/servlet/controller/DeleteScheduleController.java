package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.ScheduleDAOImpl;

public class DeleteScheduleController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
		String path = "schedule.jsp";
		try {
			ScheduleDAOImpl.getInstance().deleteSchedule(scheduleId);
		} catch (SQLException e) {
			path = "error.jsp";
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
