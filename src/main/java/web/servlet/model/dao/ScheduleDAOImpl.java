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
	DataSource ds;
	private ScheduleDAOImpl() {
		try {
			InitialContext ic = new InitialContext();
			ds=	(DataSource)ic.lookup("java:comp/env/jdbc/mysql");
		}catch (NamingException e) {
			System.out.println(e);
		}
	}
	private static ScheduleDAOImpl dao = new ScheduleDAOImpl();
	public static ScheduleDAOImpl getInstance() {
		return dao;
	}
	
	public Connection getConnection() throws SQLException{
		return ds.getConnection();
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
	public Schedule getLatestSchedule(String userId, String partnerId) throws SQLException{
		String query = "SELECT id,User_id,is_personal,start_date,end_date,title,description FROM schedule "
				+ "WHERE start_date>curdate() AND user_id IN ( ?,?) "
				+ "ORDER BY datediff(start_date,curdate()) LIMIT 1";
		ResultSet rs = null;
		Schedule schedule = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, userId);
			ps.setString(2, partnerId);
			rs= ps.executeQuery();
			if(rs.next()) {
				schedule = new Schedule(rs.getInt(1), rs.getString(2), rs.getBoolean(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
			}
		}
		
		
		return schedule;
	}
	@Override
	public ArrayList<Schedule> getMonthSchedule(String yearMonth, String userId, String partnerId)  throws SQLException{
		String query = "SELECT id,User_id,is_personal,start_date,end_date,title,description FROM schedule \r\n"
				+ "WHERE user_id IN (?,?) AND (start_date LIKE ? or end_date LIKE ?)";
		ResultSet rs = null;
		ArrayList<Schedule> list = new ArrayList<Schedule>();
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, userId);
			ps.setString(2, partnerId);
			ps.setString(3, yearMonth+"%");
			ps.setString(4, yearMonth+"%");
			rs=ps.executeQuery();
			while(rs.next()) {
				list.add(new Schedule(rs.getInt(1), rs.getString(2), rs.getBoolean(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7)));
			}
		}
		return list;
	}
	@Override
	public void createSchedule(Schedule schedule) throws SQLException {
		String query = "INSERT INTO schedule(User_id,is_personal,start_date,end_date,title,description) VALUES \r\n"
				+ "(?,?,?,?,?,?);";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, schedule.getUserId());
			ps.setString(2, String.valueOf(schedule.isPersonal()) );
			ps.setString(3, schedule.getStartDate());
			ps.setString(4, schedule.getEndDate());
			ps.setString(5, schedule.getTitle());
			ps.setString(6, schedule.getDescription());
			ps.executeUpdate();
		}
		
	}
	@Override
	public void updateSchedule(Schedule schedule)  throws SQLException{
		String query = "UPDATE schedule set user_id=? , is_personal = ? ,start_date=?"
				+ ",end_date=?,title=?,description=? WHERE id=?;";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, schedule.getUserId());
			ps.setString(2, String.valueOf(schedule.isPersonal()) );
			ps.setString(3, schedule.getStartDate());
			ps.setString(4, schedule.getEndDate());
			ps.setString(5, schedule.getTitle());
			ps.setString(6, schedule.getDescription());
			ps.setInt(7, schedule.getId());
			ps.executeUpdate();
		}
		
	}
	@Override
	public void deleteSchedule(int scheduleId)  throws SQLException{
		String query = "DELETE FROM schedule WHERE id=?";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setInt(1, scheduleId);
			ps.executeUpdate();
		}
		
	}
	@Override
	public void deleteSchedule(String userId)  throws SQLException{
		String query = "DELETE FROM schedule WHERE user_id=?";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, userId);
			ps.executeUpdate();
		}
		
	}
	/*
	public static void main(String[] args) {
		ScheduleDAO dao = getInstance();
		Schedule sc = null;
		ArrayList<Schedule> list = new ArrayList<Schedule>();
		
		/*
		sc = dao.getLatestSchedule("id01", "id20");
		System.out.println(sc);
		
		/*
		list = dao.getMonthSchedule("2024-09", "id01", "id20");
		list.forEach((i)->{
			System.out.println(i);
		});
		
		/*
		sc= new Schedule(0,"id01",false,"2024-01-01", "2024-01-01", "데이트","데이트이다.");
		dao.createSchedule(sc);
		
		/*
		sc= new Schedule(33,"id01",false,"2024-01-05", "2024-01-05", "데이트2","데이트이다2.");
		dao.updateSchedule(sc);
		
		//dao.deleteSchedule(33);
	}
	*/
}
