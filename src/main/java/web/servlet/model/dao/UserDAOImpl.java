package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import config.ServerInfo;
import web.servlet.model.vo.User;

public class UserDAOImpl implements UserDAO {
	DataSource ds;
	private UserDAOImpl() {
		
		/*try {
			InitialContext ic = new InitialContext();
			ds=	(DataSource)ic.lookup("java:comp/env/jdbc/mysql");
		}catch (NamingException e) {
			System.out.println(e);
		}*/
			
		
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
		}catch (ClassNotFoundException e) {
			System.out.println(e);
		}
		
	}
	private static UserDAOImpl dao = new UserDAOImpl();
	public static UserDAOImpl getInstance() {
		return dao;
	}
	
	public Connection getConnection() throws SQLException{
		//return ds.getConnection();
		return DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD) ;
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
	public User FindUser(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User user= null;
		
		try {
			conn = getConnection();
			String query = "SELECT id, partner_id, img_src, password, nickname, mobile, birthdate, email, gender, address, matching, start_date, break_date FROM user WHERE id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				user = new User(id, rs.getString("partner_id"), rs.getString("img_src"), rs.getString("password"), rs.getString("nickname"), rs.getString("mobile"), 
						rs.getString("birthdate"), rs.getString("email"), rs.getString("gender"), rs.getString("address"), rs.getString("matching"), rs.getString("start_date"),
						rs.getString("break_date"));
			}
		} finally {
			closeAll(rs, ps, conn);
		}
		return user;
	}
	
	@Override
	public Boolean checkEmail(String email) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean isExist= false;
		
		try {
			conn = getConnection();
			String query = "SELECT id FROM user WHERE email=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, email);
			
			rs = ps.executeQuery();
			isExist = rs.next();
		} finally {
			closeAll(rs, ps, conn);
		}
		return isExist;
	}
	
	@Override
	public Boolean checkMobile(String mobile) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean isExist= false;
		
		try {
			conn = getConnection();
			String query = "SELECT id FROM user WHERE mobile=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, mobile);
			
			rs = ps.executeQuery();
			isExist = rs.next();
		} finally {
			closeAll(rs, ps, conn);
		}
		return isExist;
	}
	
	@Override
	public void register(User vo) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = getConnection();
			String query = "INSERT INTO user(id, img_src, password, nickname, mobile, birthdate, email, gender, address) VALUES(?,?,?,?,?,?,?,?,?)";
			ps = conn.prepareStatement(query);
			
			ps.setString(1, vo.getId());
			ps.setString(2, "image/image.jpg");
			ps.setString(3, vo.getPassword());
			ps.setString(4, vo.getNickname());
			ps.setString(5, vo.getMobile());
			ps.setString(6, vo.getBirthdate());
			ps.setString(7, vo.getEmail());
			ps.setString(8, vo.getGender());
			ps.setString(9, vo.getAddress());
			
			ps.executeUpdate();
			
			
		} finally {
			closeAll(ps, conn);
		}
		
		try {
			conn = getConnection();
			String query = "INSERT INTO category(category_name, user_id) VALUES('식비,교통,숙박,시설',?)";
			ps = conn.prepareStatement(query);
			
			ps.setString(1, vo.getId());
			
			System.out.println(ps.executeUpdate() + "명 등록");
			
		} finally {
			closeAll(ps, conn);
		}
	}
	@Override
	public User login(String id, String password) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String findId(String email, String mobile) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String findPass(String id, String birthDate) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteUser(String id) {
		// TODO Auto-generated method stub
		
	}
	
	public static void main(String[] args) throws SQLException {
		//System.out.println(dao.FindUser("id01"));
		//System.out.println(dao.checkEmail("abcde3@gmail.com"));
		//System.out.println(dao.checkMobile("010-1234-5678"));
		//dao.register(new User("aa", "1234", "asasa", "010-0000-0000", "2001-01-01", "aaaaa@naver.com", "w", "서울"));
	}
}
