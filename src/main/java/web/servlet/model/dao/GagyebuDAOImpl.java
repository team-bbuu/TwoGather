package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import web.servlet.model.vo.Gagyebu;

public class GagyebuDAOImpl implements GagyebuDAO {
	DataSource ds;
	private GagyebuDAOImpl() {
		
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
	private static GagyebuDAOImpl dao = new GagyebuDAOImpl();
	public static GagyebuDAOImpl getInstance() {
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
	public Map<Integer, int[]> getYearTransaction(String year) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public ArrayList<Gagyebu> getMonthGagyebu(String yearMonth) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void createGagyebu(Gagyebu g, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void updateGagyebu(Gagyebu g, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteGagyebu(Gagyebu g, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public int getMonthDepositTotal(ArrayList<Gagyebu> gagyebus) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int getMonthExpenseTotal(ArrayList<Gagyebu> gagyebus) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public Map<String, Integer> expenseRatioByCategory(ArrayList<Gagyebu> gagyebus) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateCategory(String[] categories, String userId) {
		// TODO Auto-generated method stub
		
	}
}
