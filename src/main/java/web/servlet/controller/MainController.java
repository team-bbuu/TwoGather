package web.servlet.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.dao.ScheduleDAOImpl;
import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.vo.Gagyebu;
import web.servlet.model.vo.Schedule;
import web.servlet.model.vo.Story;
import web.servlet.model.vo.User;

public class MainController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("main controller =========================");
		
		String page = "error.jsp";
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		//폼값 받아서
//		String userId = user.getId();
		String userId = "id01"; // test
//		String partnerId = user.getPartnerId();
		String partnerId = "id20"; // test
		String year = String.valueOf(LocalDate.now()).substring(0, 4);
		String yearMonth= String.valueOf(LocalDate.now()).substring(0, 7);
		try {
		//DAO 호출
		Story story = StoryDAOImpl.getInstance().getLatestStory(userId, partnerId);
		Schedule schedule = ScheduleDAOImpl.getInstance().getLatestSchedule(userId, partnerId);
		
		GagyebuDAOImpl dao = GagyebuDAOImpl.getInstance();
		Map<Integer,int[]> map = dao.getYearTransaction(year, userId, partnerId);
		ArrayList<Gagyebu> gagyebus = dao.getMonthGagyebu(yearMonth, userId, partnerId);
		int depositTotal = dao.getMonthDepositTotal(gagyebus);
		int expenseTotal = dao.getMonthExpenseTotal(gagyebus);
		//바인딩
		request.setAttribute("story", story);
		request.setAttribute("schedule", schedule);
		request.setAttribute("map", map);
		request.setAttribute("deposit", depositTotal);
		request.setAttribute("expense", expenseTotal);
		
		System.out.println("getYearTransaction : " + map);
		page= "main.jsp";
		
		}catch (Exception e) {
			System.out.println("main controller e : " + e);
		}
		
		request.setAttribute("page", page);
		return new ModelAndView("dashboard.jsp", false);
	}
	
}
