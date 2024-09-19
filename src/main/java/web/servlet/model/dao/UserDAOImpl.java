package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

import javax.sql.DataSource;

import config.ServerInfo;
import web.servlet.model.vo.User;

public class UserDAOImpl implements UserDAO {
	DataSource ds;
	private UserDAOImpl() {

		/*
		try {
			InitialContext ic = new InitialContext();
			ds = (DataSource)ic.lookup("java:comp/env/jdbc/mysql");
		}catch (NamingException e) {
			System.out.println(e);
		}
		*/
		
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
//		return ds.getConnection();
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
	
	// LO 믿음 파트너id는 컨트롤러에서 작업
	@Override
	public User login(String id, String password) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		User vo = null;
		String[] javaCategory = null;
		
		try {
			conn = getConnection();
			String query = "SELECT u.id, u.partner_id, u.img_src, u.password, u.nickname, u.mobile, u.birthdate, u.email, u.gender, u.address, u.matching, u.start_date, u.break_date, c.category_name FROM User u, category c WHERE u.id = c.user_id AND u.id = ? AND u.password = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			ps.setString(2, password);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				// 카테고리에 데이터가 없다면
				javaCategory = rs.getString("c.category_name").split(",");
				if(javaCategory !=null) {
					vo = new User(id,
							  rs.getString("u.partner_id"),
							  rs.getString("u.img_src"),
							  password,
							  rs.getString("u.nickname"),
							  rs.getString("u.mobile"),
							  rs.getString("u.birthdate"),
							  rs.getString("u.email"),
							  rs.getString("u.gender"),
							  rs.getString("u.address"),
							  rs.getString("u.matching"),
							  rs.getString("u.start_date"),
							  rs.getString("u.break_date"),
							  javaCategory);
				}
			}
		}catch (Exception e) {
			System.out.println(e);
		} finally {
			closeAll(rs, ps, conn);
		}
		return vo;
	}
	// 믿음
	@Override
	public String findId(String email, String mobile) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String id = null;
		
		try {
			conn = getConnection();
			String query = "SELECT id FROM User WHERE email = ? AND mobile = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, mobile);
			rs = ps.executeQuery();
			if (rs.next()) {
				id = rs.getString("id");
			}
		} finally {
			closeAll(rs, ps, conn);
		}
		return id;
	}
	// 믿음
	@Override
	public String findPass(String id, String birthDate) throws Exception {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String password = null;
		
		try {
			conn = getConnection();
			String query = "SELECT password FROM User WHERE id = ? AND birthDate = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			ps.setString(2, birthDate);
			rs = ps.executeQuery();
			if (rs.next()) {
				password = rs.getString("password");
			}
		} finally {
			closeAll(rs, ps, conn);
		}
		return password;
	}
	/* 회원정보 수정 */
	@Override
	public void updateUser(User user) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = getConnection();
			// user의 id만 제외하였음
			String query = "UPDATE User SET partner_id=?, img_src=?, password=?, nickname=?, mobile=?,"
					+ "birthdate=?, email=?, gender=?, address=?, matching=?, start_date=?,"
					+ "break_date=? WHERE id=?";
			ps = conn.prepareStatement(query);
			
			ps.setString(1, user.getPartnerId());
			ps.setString(2, user.getimgSrc());
			ps.setString(3, user.getpassword());
			ps.setString(4, user.getNickname());
			ps.setString(5, user.getMobile());
			ps.setString(6, user.getBirthdate());
			ps.setString(7, user.getEmail());
			ps.setString(8, user.getGender());
			ps.setString(9, user.getAddress());
			ps.setString(10, user.getMatching());
			ps.setString(11, user.getStartDate());
			ps.setString(12, user.getBreakDate());
			ps.setString(13, user.getId());
			
			System.out.println(ps.executeUpdate() + "회원정보 업데이트");
		
		}catch (Exception e) {
			System.out.println("updateUser 메소드 e : " + e);
		}finally {
			closeAll(ps, conn);
		}
	}
	
	/* 회원탈퇴 */
	@Override
	public void deleteUser(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			conn = getConnection();
			String query = "DELETE FROM User Where id=?";
			
			// 유저 아이디 삭제
			ps = conn.prepareStatement(query);
			ps.setString(1, id);
			
			System.out.println(ps.executeUpdate() + "회원탈퇴");
			
		}catch (Exception e) {
			System.out.println("deleteUser 메소드 e : " + e);
		}finally {
			closeAll(ps, conn);
		}
	}
	
	
	/* test */
	public static void main(String[] args) throws SQLException {
		// 선민 
		//System.out.println(dao.FindUser("id01"));
		//System.out.println(dao.checkEmail("abcde3@gmail.com"));
		//System.out.println(dao.checkMobile("010-1234-5678"));
		//dao.register(new User("aa", "1234", "asasa", "010-0000-0000", "2001-01-01", "aaaaa@naver.com", "w", "서울"));

	
		// 현정 
		// UserDAO dao = UserDAOImpl.getInstance();
		// dao.updateUser(new User("id019", null, "image/a.jpg", "pass19", "나연2", "010-9012-3966", "1979-08-10", "abcde19@gmail.com", "f", "서울시 서대문구 홍제동", "매칭전", null, null,	null));

		// believeme
//		String id = UserDAOImpl.getInstance().findId("abcde1@gmail.com", "010-1234-5678");
//		System.out.println("id :: " + id);
//		String password = UserDAOImpl.getInstance().findPass("id1", "1997-02-10");
//		System.out.println("password :: " + password);
//		User vo = UserDAOImpl.getInstance().login("id01", "pass1");
//		System.out.println("vo :: " + Arrays.toString(vo.getCategory()));
//		System.out.println(vo);
	}

}
