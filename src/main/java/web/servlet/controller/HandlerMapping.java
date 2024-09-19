package web.servlet.controller;

public class HandlerMapping {
	private static HandlerMapping handler = new HandlerMapping();
	private HandlerMapping() {}
	public static HandlerMapping getInstance() {
		return handler;
	}
	
	Controller createComponent(String command){
		Controller controller = null;
		if(command.equals("")) {
			
		}else if(command.equals("")) {
			
		}
		
		return controller;
	}
}
