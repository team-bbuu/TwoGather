package web.servlet.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.vo.User;

public class UpdateCategoryController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		HttpSession session = request.getSession();
		String[] categories = request.getParameterValues("customCategory"); // 가계부-설정 페이지의 나의 항목 목록
		User user = (User)session.getAttribute("user");
		User partner = (User)session.getAttribute("partner");
		String path = "category.jsp";
		try {
			GagyebuDAOImpl.getInstance().updateCategory(categories, user.getId());
			GagyebuDAOImpl.getInstance().updateCategory(categories, partner.getId());
			user.setCategory(categories);
			partner.setCategory(categories);
			session.setAttribute("user", user);
			session.setAttribute("partner", partner);
		} catch (SQLException e) {
			path = "error.jsp";
		}
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

}
