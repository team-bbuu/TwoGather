package web.servlet.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;


public class UpdateUserController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response){
		//폼값 받아서
		String imgSrc = request.getParameter("imgSrc");
		String password = request.getParameter("password");
		String nickName = request.getParameter("nickname");
		String mobile =request.getParameter("mobile");
		String email =request.getParameter("email");
		String address =request.getParameter("address");
		
		//email,mobile 검증
		UserDAOImpl dao = UserDAOImpl.getInstance();
		HttpSession session = request.getSession();
		
		Map<String, Boolean> resMap = new HashMap<>();
		resMap.put("success", false);
		resMap.put("checkEmail", false);
		resMap.put("checkMoblie", false);
		
		try {
			if(!dao.checkEmail(email) && !dao.checkMobile(mobile)){ // mobile,email 중복 x
				resMap.replace("success", true);
				User user = (User)session.getAttribute("user");
				//정보 수정
				user.setimgSrc(imgSrc);
				user.setPassword(password);
				user.setNickname(nickName);
				user.setMobile(mobile);
				user.setEmail(email);
				user.setAddress(address);
				//변경된 유저 db 저장
				
				dao.updateUser(user);
				//변경된 유저 세션 저장
				session.setAttribute("user", user);
				
			} else {
				if(dao.checkEmail(email)) {
					resMap.replace("checkEmail", true);
				}
				if(dao.checkMobile(mobile)) {
					resMap.replace("checkMoblie", true);
				}
			}
			response.setContentType("application/json"); // JSON 응답 형식 설정
			response.getWriter().write(new Gson().toJson(resMap));
		}catch (SQLException e) {
			
		} catch (IOException e) {
			
		}
		return null;
	}

}
