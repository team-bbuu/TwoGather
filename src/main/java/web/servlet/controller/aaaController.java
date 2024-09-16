package web.servlet.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class aaaController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * 1. 폼값 받아서
		 * 2. dao 생성 후 비즈니스 로직 호출
		 * 3. 바인딩
		 * 4. mv에 값 담아서 리턴
		 */
		return new ModelAndView(null, false);
	}

}
