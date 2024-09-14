package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Array;

import config.ServerInfo;
import web.servlet.model.vo.Gagyebu;

public class GagyebuDAOImpl implements GagyebuDAO {
	DataSource ds;
	private GagyebuDAOImpl() {
		
//		try {
//			InitialContext ic = new InitialContext();
//			ds=	(DataSource)ic.lookup("java:comp/env/jdbc/mysql");
//		}catch (NamingException e) {
//			System.out.println(e);
//		}
		
		
		try {
			Class.forName(ServerInfo.DRIVER_NAME);
		}catch (ClassNotFoundException e) {
			System.out.println(e);
		}
		
	}
	private static GagyebuDAOImpl dao = new GagyebuDAOImpl();
	public static GagyebuDAOImpl getInstance() {
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
		int depositTotal = 0;
		for(Gagyebu gagyebu : gagyebus) {
			if(gagyebu.isDeposit())	depositTotal += gagyebu.getPrice();
		}
		return depositTotal;
	}
	@Override
	public int getMonthExpenseTotal(ArrayList<Gagyebu> gagyebus) {
		int depositTotal = 0;
		for(Gagyebu gagyebu : gagyebus) {
			if(!gagyebu.isDeposit())	depositTotal += gagyebu.getPrice();
		}
		return depositTotal;
	}
	
	// 가계부 리스트 생성 테스트 메소드
	public ArrayList<Gagyebu> gagyebuList(String userId) throws SQLException {
		ArrayList<Gagyebu> gagyebus = new ArrayList<Gagyebu>();
		
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
			conn = getConnection();
			String query = "SELECT category, price FROM Gagyebu WHERE User_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, userId);
			
			rs = ps.executeQuery();
			
			// 리스트에 추가
			while(rs.next()) {
				String category = rs.getString("category");
				int price = rs.getInt("price");
				
				Gagyebu gagyebu = new Gagyebu();
				gagyebu.setCategory(category);
				gagyebu.setPrice(price);
				
				gagyebus.add(gagyebu);
			}
			
		}catch (Exception e) {
			System.out.println("가계부 리스트 만들기 e : " + e);
		}finally {
			closeAll(ps, conn);
		}
		
		return gagyebus;
	}
	
	/* 항목별 지출 비율 데이터 조회 메소드 */
	@Override
//	public Map<String, Integer> expenseRatioByCategory(ArrayList<Gagyebu> gagyebus)
	public Map<String, Integer> expenseRatioByCategory() throws SQLException {
		ArrayList<Gagyebu> gagyebus = new ArrayList<Gagyebu>();
		Map<String, Integer> categoriesMap = new HashMap<String, Integer>();
		
		gagyebus = gagyebuList("id01"); // 테스트
		
	    Connection conn = null;
	    PreparedStatement ps = null;
	    
	    // System.out.println("gagyebu list : " + gagyebus);
		
		try {
			conn = getConnection();
			String query="";
			
			// 각 항목별 금액 집계
			for(Gagyebu gagyebu : gagyebus) {
				String category = gagyebu.getCategory();
				int amount = gagyebu.getPrice();
				
				// 해당 카테고리에 금액을 더해나감
				categoriesMap.put(category, categoriesMap.getOrDefault(category, 0) + amount);
			}
			
			System.out.println("expenseRatioByCategory : " + categoriesMap);
			
		}catch (Exception e) {
			System.out.println("expenseRatioByCategory e : " + e);
		}finally {
			closeAll(ps, conn);
		}
		
		return categoriesMap;
	}
	
	@Override
	public void updateCategory(String[] categories, String userId) {
		// TODO Auto-generated method stub
		
	}
	
	// test
	public static void main(String[] args) throws SQLException {
		GagyebuDAO dao = GagyebuDAOImpl.getInstance();
		
		dao.expenseRatioByCategory();
	}
}
