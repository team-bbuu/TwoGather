package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.vo.Gagyebu;

// 가계부 수정 컨트롤러
public class UpdateGagyebuController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		// 가계부 폼값 받아옴
		boolean isDeposit = Boolean.parseBoolean(request.getParameter("isDeposit"));

		int gagyebuId = Integer.parseInt(request.getParameter("gagyebuId")); // 입금, 지출 구분
		String userId = request.getParameter("userId"); // 입금자, 지출자명
		String transactionDate = request.getParameter("transactionDate");
		int price = Integer.parseInt(request.getParameter("price"));
		String title = request.getParameter("title");
		String etc = request.getParameter("etc");
		
		Gagyebu gagyebu = new Gagyebu();
		
		// 입금, 지출 분기
		if(isDeposit) {
			// 입금 
			gagyebu = new Gagyebu(gagyebuId, userId, transactionDate, isDeposit, price, title, etc);
		}else {
			// 지출  
			String category = request.getParameter("category");
			String paymentType = request.getParameter("paymentType");
			gagyebu = new Gagyebu(gagyebuId, userId ,transactionDate, isDeposit, category, price, title, paymentType, etc);
		}
		
		String path = "monthGagyebu.jsp";
		
		try {
			GagyebuDAOImpl.getInstance().updateGagyebu(gagyebu);
			
		}catch (Exception e) {
			path = "error.jsp";
		}
		
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}
}
