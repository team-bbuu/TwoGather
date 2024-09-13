package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import web.servlet.model.vo.Schedule;

public class ScheduleDAOImpl implements ScheduleDAO {
	private DataSource ds;
	
	private ScheduleDAOImpl() {
		try {
			InitialContext ic = new InitialContext();
			ds = (DataSource)ic.lookup("java:comp/env/jdbc/mysql");
			System.out.println("DataSource lookup...Success~~!!");
		} catch (NamingException e) {
			System.out.println("DataSource lookup...Fail~~!!");
		}
	}
	private static ScheduleDAOImpl dao = new ScheduleDAOImpl();
	public static ScheduleDAOImpl getInstance() {
		return dao;
	}
	
	public Connection gerConnect() throws SQLException {
		System.out.println("DB 연결 성공...");
		return ds.getConnection();//Pool 에서 하나씩 꺼내오는 방식..
	}
	
	public void closeAll(PreparedStatement ps, Connection conn) throws SQLException {
		if(ps!=null) ps.close();
		if(conn!=null) conn.close();
	}
	
	public void closeAll(ResultSet rs, PreparedStatement ps, Connection conn) throws SQLException {
		if(rs!=null) rs.close();
		closeAll(ps, conn);
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
