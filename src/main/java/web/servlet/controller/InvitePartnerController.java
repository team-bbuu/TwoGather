package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import web.servlet.model.dao.UserDAO;
import web.servlet.model.dao.UserDAOImpl;
import web.servlet.model.vo.User;

// 초대하기 > 파트너 아이디 확인(checkId) > 상대방 매칭전 > 초대하기 > 테이블 row 2개 변경 updateUser * 2
//							싱대방 이미 매칭되어있는 상태 -> alert("이미 매칭된 상태 입니다.")
public class InvitePartnerController implements Controller{	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(); 	
		User user = (User)session.getAttribute("user");
		
		// String userId = user.getId(); // 아이디 추출
		
		// test id10, id11 파트너 연결 
		String userId = "id010";
		String partnerId = request.getParameter("partnerId"); // 파트너아이디 값 받아옴
		
		System.out.println("partnerId : " + partnerId);
		
		// matching 유형 : 매칭전, 요청함, 요청받음, 매칭완료
		
		System.out.println("InvitePartnerController ==========");

		try {
			
			System.out.println("InvitePartnerController try ========");
			UserDAO userDao = UserDAOImpl.getInstance(); // 로그인 유저 객체
			User partner = userDao.FindUser(partnerId); // 파트너 아이디 찾아서 객체 담음
			user = userDao.FindUser(userId); // test
			// 유저, 파트너 테이블에서 partnerId, matching 변경
			user.setMatching("요청함");
			user.setPartnerId(partnerId);
			partner.setMatching("요청받음");
			partner.setPartnerId(userId);
			
			// 유저, 파트너 업데이트 실행
			userDao.updateUser(user);
			userDao.updateUser(partner);
			
            // 세션 갱신
			session.setAttribute("user", user);
			session.setAttribute("partner", partner);
			
		}catch (Exception e) {
			request.setAttribute("page", "error.jsp");
		}
		
		return new ModelAndView("main.do");
	}
}
