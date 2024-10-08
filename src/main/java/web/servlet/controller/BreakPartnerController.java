package web.servlet.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class BreakPartnerController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		//변경할 값 생성
		String matching = "매칭전";
		String breakDate = String.valueOf(LocalDateTime.now()).substring(0,19).replace("T", " ");
		//session에서 user 받아오기
		HttpSession session = request.getSession();
		UserDAOImpl dao = UserDAOImpl.getInstance();
		
		try {
		//유저 업데이트
		User user = (User)session.getAttribute("user");
		user.setMatching(matching);
		user.setBreakDate(breakDate);
		dao.updateUser(user);
		session.setAttribute("user", user); // session에 변경된 유저 덮어쓰기
		//partner 업데이트
		User partner =(User) session.getAttribute("partner");
		partner.setMatching(matching);
		partner.setBreakDate(breakDate);
		dao.updateUser(partner);
		}catch (SQLException e) {
			
		}
		return null;
	}
}
