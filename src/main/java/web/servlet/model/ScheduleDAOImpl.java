package web.servlet.model;

import java.util.ArrayList;

public class ScheduleDAOImpl implements ScheduleDAO {
	private ScheduleDAOImpl() {}
	private static ScheduleDAOImpl dao = new ScheduleDAOImpl();
	public static ScheduleDAOImpl getInstance() {
		return dao;
	}
	@Override
	public Schedule getLatestSchedule(String userId) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public ArrayList<Schedule> getMonthSchedule(String yearMonth, String userId) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void createSchedule(Schedule schedule, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void updateSchedule(Schedule schedule, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteSchedule(String scheduleId) {
		// TODO Auto-generated method stub
		
	}
}
