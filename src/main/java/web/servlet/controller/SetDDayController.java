package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

// 디데이 설정 컨트롤러
public class SetDDayController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		// 디데이의 설정한 날짜 받아옴
		String startDate = request.getParameter("startDate"); // 설정한 날짜
		User user = (User)session.getAttribute("user");
		User partner = (User)session.getAttribute("partner");
		
		// 받아온 설정한 날짜 저장
		try {			
			if (user != null) {	
				// 유저, 파트너 startdate 변경 
				user.setStartDate(startDate);
				partner.setStartDate(startDate);

				// 커플 각 정보 업데이트
				UserDAOImpl.getInstance().updateUser(user);
				UserDAOImpl.getInstance().updateUser(partner);

                // 세션 갱신
				session.setAttribute("user", user);
				session.setAttribute("partner", partner);

			}
		}catch (Exception e) {
			request.setAttribute("page", "error.jsp");
			
		}
		return new ModelAndView("dashboard.jsp");
	}

}
