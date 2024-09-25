package web.servlet.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.do")
@MultipartConfig()
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public DispatcherServlet() {
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requesturl = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requesturl.substring(contextPath.length()+1);
		Controller controller= HandlerMapping.getInstance().createComponent(command);
		try {
			ModelAndView mv = controller.handleRequest(request, response);
			if(mv != null) {
				String path= mv.getPath();
				
				if(!mv.isRedirect()) {
					request.getRequestDispatcher(path).forward(request, response);
				}else {
					response.sendRedirect(path);
				}
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
