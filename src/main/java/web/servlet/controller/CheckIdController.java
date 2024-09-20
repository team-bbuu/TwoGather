package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class CheckIdController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		String id =request.getParameter("id");
		String path = "";
		boolean isExist = false;

		try {
			User user = UserDAOImpl.getInstance().FindUser(id);
			if(user!=null) {
				isExist = true;
			}
			// 유저 존재유무 체크 
			request.setAttribute("isExist", isExist);
			// invitePartner에서 matching 확인가능 (추후 ajax 에서 객체로 핸들가능할지 확인하기)
			request.setAttribute("user", user); 
		} catch (Exception e) {
			
		}
		return new ModelAndView(path);
	}
}
