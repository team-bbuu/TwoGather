package web.servlet.model.dao;

import java.util.ArrayList;

import web.servlet.model.vo.Schedule;

public interface ScheduleDAO {
	Schedule getLatestSchedule (String userId);  // 가장 가까운 일정 불러오는 메소드     
	ArrayList<Schedule> getMonthSchedule (String yearMonth, String userId); // 월 데이터 받아오는 메소드
	void createSchedule (Schedule schedule, String userId);  // 일정 생성
	void updateSchedule (Schedule schedule, String userId);  // 일정 수정
	void deleteSchedule (String scheduleId);// 일정 삭제
}
