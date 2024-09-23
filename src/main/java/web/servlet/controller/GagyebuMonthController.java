package web.servlet.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.vo.Gagyebu;

public class GagyebuMonthController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
//		String userId = request.getParameter("userId");
//		String partnerId = request.getParameter("partnerId");
		String userId = "id01"; // test
		String partnerId = "id20"; // test
		String path = "gagyebuMonth.jsp";
		GagyebuDAOImpl dao = GagyebuDAOImpl.getInstance();
		
		
		// 현재날짜 받아오기
		LocalDate nowDate = LocalDate.now();
		int nowDateDay = Integer.parseInt(String.valueOf(nowDate).substring(8, 10));
		LocalDate beforeMonthDate = nowDate.minusMonths(1);
		int beforeMonthExpense = 0;
		int priceDifference = 0;
		//DateTimeFormatter YYYY = DateTimeFormatter.ofPattern("YYYY");
		//String nowDateYYYY = nowDate.format(YYYY);

		
//		String yearMonth = request.getParameter("yearMonth");
		
//		String yearMonth = (String) request.getAttribute("yearMonth");
		String yearMonth = "2024-09"; // test
//		if(yearMonth == null ) {
//			// now
//			// request 
//		}else {
//			// 화면에서 이전,다음 월을 호출할때
//		}
		
		String yearMonthBefore = (Integer.parseInt(yearMonth.substring(0, 4)) - 1) + "-" + yearMonth.substring(4, 7); // 2024-09
		String Day = request.getParameter("Day");
		
		try {
			/* 왼쪽 윗부분 총입금액, 총지출액 */
			ArrayList<Gagyebu> gagyebus = dao.getMonthGagyebu(yearMonth, userId, partnerId);
			int depositMonth =  dao.getMonthDepositTotal(gagyebus);
			int expenseMonth =  dao.getMonthExpenseTotal(gagyebus);
			request.setAttribute("depositMonth", depositMonth);
			request.setAttribute("expenseMonth", expenseMonth);
			
			/* 왼쪽 아랫부분 항목별 지출 비율 */
			Map<String, Integer> category = new HashMap<>();
			category = dao.expenseRatioByCategory(gagyebus);
			System.out.println("category : " +  category);
			request.setAttribute("category", category);
		
			/* 오른쪽 윗부분 지난달 이번달 기간비교 */
			String beforeMonthDateYearMonth = yearMonthBefore.substring(0, 7);
			ArrayList<Gagyebu> gagyebusBefore = dao.getMonthGagyebu(beforeMonthDateYearMonth, userId, partnerId);
			// 현재달을 사용자가 보고 싶을때
			if(String.valueOf(nowDate).substring(5, 7) == yearMonth.substring(5, 7)) {
				
				for(Gagyebu g : gagyebusBefore) {	
					if (nowDateDay <= Integer.parseInt(g.getTransactionDate().substring(8, 10))) {
					 	beforeMonthExpense += g.getPrice();
					}					
				};
			// 다른달을 사용자가 보고 싶을때
			} else {
				beforeMonthExpense = dao.getMonthExpenseTotal(gagyebusBefore);
			}
			priceDifference = expenseMonth - beforeMonthExpense;
			request.setAttribute("priceDifference", priceDifference);
			
			/* 오른쪽 아랫부분 알고리즘 미확정 */
			
			// 추가			
			request.setAttribute("yearMonth", yearMonth);
			
			
		}catch (SQLException e) {
			path = "error.jsp";
		}
		request.setAttribute("page", path);
		
		return new ModelAndView("dashboard.jsp");
	}

}
