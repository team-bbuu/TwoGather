package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import web.servlet.model.vo.User;

public class UserDAOImpl implements UserDAO {
	DataSource ds;
	private UserDAOImpl() {
		
		try {
			InitialContext ic = new InitialContext();
			ds=	(DataSource)ic.lookup("java:comp/env/jdbc/mysql");
		}catch (NamingException e) {
			System.out.println(e);
		}
		
		/*
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
		}catch (ClassNotFoundException e) {
			System.out.println(e);
		}
		*/
	}
	private static UserDAOImpl dao = new UserDAOImpl();
	public static UserDAOImpl getInstance() {
		return dao;
	}
	
	public Connection getConnection() throws SQLException{
		return ds.getConnection();
		//return DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD) ;
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
	public Boolean checkID(String id) {
		
		return null;
	}
	@Override
	public Boolean checkEmail(String email) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Boolean checkMobile(String mobile) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public User register(User vo) {
		// TODO Auto-generated method stub
		return null;
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
	public void breakPartner(String id) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteUser(String id) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void invitePartner(String id, String partnerId) {
		// TODO Auto-generated method stub
		
	}
}
