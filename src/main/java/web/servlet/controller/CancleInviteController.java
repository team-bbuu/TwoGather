package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class CancleInviteController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String path = "main.jsp";
		try {
			HttpSession session = request.getSession();
			//유저 정보 변경 후 저장
            User user = (User) session.getAttribute("user");
            user.setMatching("매칭전");
            user.setPartnerId(null);
			UserDAOImpl.getInstance().updateUser(user);
			//파트너 정보 변경 후 저장
			User partner = (User) session.getAttribute("partner");
			partner.setMatching("매칭전");
			partner.setPartnerId(null);
			UserDAOImpl.getInstance().updateUser(partner);
			//세션 저장 및 삭제
			session.setAttribute("user", user);
			session.removeAttribute("partner");
		} catch (Exception e) {
			
		}
		return new ModelAndView(path);
	}

}
