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
            User user = (User) session.getAttribute("user");
            user.setMatching("매칭전");
            user.setPartnerId(null);
			UserDAOImpl.getInstance().updateUser(user);
			User partner = (User) session.getAttribute("partner");
			partner.setMatching("매칭전");
			partner.setPartnerId(null);
			UserDAOImpl.getInstance().updateUser(partner);
			session.setAttribute("user", user);
			session.removeAttribute("partner");
		} catch (Exception e) {
			
		}
		return new ModelAndView(path);
	}

}
