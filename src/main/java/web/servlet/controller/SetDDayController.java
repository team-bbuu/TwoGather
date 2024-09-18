package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

// 디데이 설정 컨트롤러
public class SetDDayController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		
		// 디데이의 년도와 월,일 받아옴
		String id = request.getParameter("id");
		String date = request.getParameter("date");
		
		String path = "update_fail.jsp"; // default 업데이트 실패
		// 2. 받아온 년,월,일 저장
		try {
			User user = UserDAOImpl.getInstance().FindUser(id); // 유저정보
			
			if (user != null) {
				// start date 변
				user.setStartDate(date);

				// 업데이트 실행
				UserDAOImpl.getInstance().updateUser(user);

                // 성공 페이지로 이동
                request.setAttribute("user", user);
                path = "update_success.jsp"; // 성공 페이지 설정
			}
			
		}catch (SQLException e) {
			
		}
		return new ModelAndView(null, false);
	}

}
