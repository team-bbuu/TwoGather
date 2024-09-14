package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Arrays;
import java.util.Map;

import javax.sql.DataSource;

import config.ServerInfo;
import web.servlet.model.vo.Gagyebu;
import web.servlet.model.vo.User;

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
		String query = "";
		ResultSet rs = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			
		}catch (SQLException e) {
			System.out.println(e);
		}
		return null;
	}
	@Override
	public ArrayList<Gagyebu> getMonthGagyebu(String yearMonth,String userId, String partnerId) {
		
		return null;
	}
	@Override
	public void createGagyebu(Gagyebu g, String userId) {
		String query = "";
		ResultSet rs = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public void updateGagyebu(Gagyebu g, String userId) {
		String query = "";
		ResultSet rs = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public void deleteGagyebu(Gagyebu g, String userId) {
		String query = "";
		ResultSet rs = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			
		}catch (SQLException e) {
			System.out.println(e);
		}
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
	public void updateCategory(String[] categories, String userId) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String DBCategory = String.join(",", categories);
		try {
			conn = getConnection();
			String query = "UPDATE category SET category_name = ? WHERE User_id = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, DBCategory);
			ps.setString(2, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			closeAll(ps, conn);
		}
	}
	
	// 단위테스트
	public static void main(String[] args) throws Exception {
	// emilyhong
		GagyebuDAO dao = GagyebuDAOImpl.getInstance();
	
		dao.expenseRatioByCategory();
	
		// believeme
		String[] category = {"데이트"};
		String[] category2 = {"식비"};
		String[] category3 = {"데이트", "식비"};
		GagyebuDAOImpl.getInstance().updateCategory(category3, "id1");
	}//main	
}
