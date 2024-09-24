package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.vo.Gagyebu;

// 가계부 작성 컨트롤
public class CreateGagyebuController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		// 가계부 폼값 받아옴
		boolean isDeposit = Boolean.parseBoolean(request.getParameter("isDeposit")); // 입금, 지출 구분

		String userId = request.getParameter("userId"); // 입금자명, 지출자명
		String transactionDate = request.getParameter("transactionDate");
		int price = Integer.parseInt(request.getParameter("price"));
		String title = request.getParameter("title");
		String etc = request.getParameter("etc");
		
		Gagyebu gagyebu = new Gagyebu();
		
		// 입금, 지출 분기
		if(isDeposit) {
			// 입금 
			gagyebu = new Gagyebu(0, userId, transactionDate, isDeposit, price, title, etc);
		}else {
			// 지출  
			String category = request.getParameter("category");
			String paymentType = request.getParameter("paymentType");
			
			gagyebu = new Gagyebu(0, userId ,transactionDate, isDeposit, category, price, title, paymentType, etc);
		}
		
		String path = "gagyebu.do";
		
		try {
			GagyebuDAOImpl.getInstance().createGagyebu(gagyebu);
			
		}catch (Exception e) {
			path = "error.jsp";
		}
		
		return new ModelAndView(path,true);
	}
}
