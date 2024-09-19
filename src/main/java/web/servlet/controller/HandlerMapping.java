package web.servlet.controller;

public class HandlerMapping {
	private static HandlerMapping handler = new HandlerMapping();
	private HandlerMapping() {}
	public static HandlerMapping getInstance() {
		return handler;
	}
	
	Controller createComponent(String command){
		Controller controller = null;
		/*
		if(command.equals("login.do")) {
			controller = new LoginController();
		}else if(command.equals("findId.do")) {
			controller = new FindIdController();
		}else if(command.equals("findPass.do")) {
			controller = new FindPassController();
		}else if(command.equals("checkId.do")) {
			controller = new CheckIdController();
		}else if(command.equals("register.do")) {
			 controller = new RegisterController();
		}else if(command.equals("main.do")) {
			 controller = new MainController();
		}else if(command.equals("invitePartner.do")) {
			 controller = new InvitePartnerController();
		}else if(command.equals("inviteOk.do")) {
			 controller = new InviteOkController();
		}else if(command.equals("logout.do")) {
			 controller = new LogoutController();
		}else if(command.equals("cancleInvite.do")) {
			 controller = new CancleInviteController();
		}else if(command.equals("setDDay.do")) {
			 controller = new SetDDayController();
		}else if(command.equals("gagyebu.do")) {
			 controller = new GagyebuCreateController();
		}else if(command.equals("updateGagyebu.do")) {
			 controller = new UpdateGagyebuController();
		}else if(command.equals("deleteGagyebu.do")) {
			 controller = new DeleteGagyebuController();
		}else if(command.equals("createGagyebu.do")) {
			 controller = new CreateGagyebuController();
		}else if(command.equals("gagyebuMonth.do")) {
			 controller = new GagyebuMonthController();
		}else if(command.equals("updateCategory.do")) {
			 controller = new UpdateCategoryController();
		}else if(command.equals("schedule.do")) {
			 controller = new ScheduleController();
		}else if(command.equals("updateSchedule.do")) {
			 controller = new UpdateScheduleController();
		}else if(command.equals("deleteSchedule.do")) {
			 controller = new DeleteScheduleController();
		}else if(command.equals("createSchedule.do")) {
			 controller = new CreateScheduleController();
		}else if(command.equals("updateUser.do")) {
			 controller = new UpdateUserController();
		}else if(command.equals("breakPartner.do")) {
			 controller = new BreakPartnerController();
		}else if(command.equals("deleteUser.do")) {
			 controller = new DeleteUserController();
		}else if(command.equals("story.do")) {
			 controller = new StoryController();
		}else if(command.equals("createStory.do")) {
			 controller = new CreateStoryController();
		}else if(command.equals("updateStory.do")) {
			 controller = new UpdateStoryController();
		}else if(command.equals("deleteStory.do")) {
			 controller = new DeleteStoryController();
		}
		*/
		
		return controller;
	}
	
}
