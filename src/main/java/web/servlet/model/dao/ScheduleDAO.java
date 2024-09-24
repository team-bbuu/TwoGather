package web.servlet.model.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import web.servlet.model.vo.Schedule;

public interface ScheduleDAO {
	Schedule getLatestSchedule (String userId,String partnerId) throws SQLException;  // 가장 가까운 일정 불러오는 메소드     
	ArrayList<Schedule> getMonthSchedule (String yearMonth, String userId, String partnerId) throws SQLException; // 월 데이터 받아오는 메소드
	void createSchedule (Schedule schedule) throws SQLException;  // 일정 생성
	void updateSchedule (Schedule schedule) throws SQLException;  // 일정 수정
	void deleteSchedule (int scheduleId) throws SQLException;// 일정 삭제
	void deleteSchedule(String userId) throws SQLException;
}
