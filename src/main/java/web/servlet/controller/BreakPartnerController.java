package web.servlet.controller;

import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class BreakPartnerController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//변경할 값 생성
		String matching = "매칭전";
		String breakDate = String.valueOf(LocalDate.now());
		//session에서 user 받아오기
		HttpSession session = request.getSession();
		UserDAOImpl dao = UserDAOImpl.getInstance();
		User user = (User)session.getAttribute("user");
		String userId = user.getId();
		String partnerId = user.getPartnerId();
		//유저 업데이트
		user.setMatching(matching);
		user.setBreakDate(breakDate);
		dao.updateUser(user);
		session.setAttribute("user", user); // session에 변경된 유저 덮어쓰기
		//partner 업데이트
		user= dao.FindUser(partnerId);
		user.setMatching(matching);
		user.setBreakDate(breakDate);
		dao.updateUser(user);
		
		return null;
	}
	
}
