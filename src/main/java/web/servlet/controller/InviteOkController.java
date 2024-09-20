package web.servlet.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.GagyebuDAOImpl;
import web.servlet.model.dao.ScheduleDAOImpl;
import web.servlet.model.dao.StoryDAOImpl;
import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

public class InviteOkController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String path = "main.jsp";
		try {
			User partner = UserDAOImpl.getInstance().FindUser(user.getPartnerId());
			if(user.getBreakDate()!=null&&partner.getBreakDate()!=null) {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat formatter2 = new SimpleDateFormat("yyyy-MM-dd");
				
				Date formatDate = formatter.parse(user.getBreakDate());
				Date now = new Date();

			    String breakDate =  formatter2.format(formatDate);
			    String nowDate = formatter2.format(now);
			    
				if(nowDate.compareTo(breakDate)<=7) {
					if(!user.getBreakDate().equals(partner.getBreakDate())) {
						deleteLatestData(user.getId());
						deleteLatestData(partner.getId());
					}
				}else {
					deleteLatestData(user.getId());
					deleteLatestData(partner.getId());
				}
			}else if(user.getBreakDate()!= null||partner.getBreakDate()!=null) {
				if(user.getBreakDate()!= null) {
					deleteLatestData(user.getId());
				}else {
					deleteLatestData(partner.getId());
				}
			}
			
			User newUser = new User(user.getId(), user.getPartnerId(), user.getImgSrc(), user.getPassword(), 
					user.getNickname(), user.getMobile(), user.getBirthdate(), user.getEmail(), user.getGender(), user.getAddress(), 
					"매칭완료", null, null);
			User newPartner = new User(partner.getId(), partner.getPartnerId(), partner.getImgSrc(), partner.getPassword(),
					partner.getNickname(), partner.getMobile(), partner.getBirthdate(), partner.getEmail(), partner.getGender(), 
					partner.getAddress(), "매칭완료", null, null);
			UserDAOImpl.getInstance().updateUser(newUser);
			UserDAOImpl.getInstance().updateUser(newPartner);
			
			User sessionPartner = new User(newPartner.getId(), newPartner.getNickname(), newPartner.getImgSrc());
			session.setAttribute("user", newUser);
			session.setAttribute("partner", sessionPartner);
			
		} catch (SQLException | ParseException e) {
			path = "error.jsp";
		}
		
		request.setAttribute("page", path);
		return new ModelAndView("dashboard.jsp");
	}

	private void deleteLatestData(String userId) throws SQLException {
		String[] categories = new String[] {"식비","교통","숙박","시설"};
		StoryDAOImpl.getInstance().deleteStory(userId);
		GagyebuDAOImpl.getInstance().deleteGagyebu(userId);
		GagyebuDAOImpl.getInstance().updateCategory(categories, userId);
		ScheduleDAOImpl.getInstance().deleteSchedule(userId);
	}
}
