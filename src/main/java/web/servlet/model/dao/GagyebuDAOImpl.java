package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
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
	}
	private static GagyebuDAOImpl dao = new GagyebuDAOImpl();
	public static GagyebuDAOImpl getInstance() {
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
	public Map<Integer, int[]> getYearTransaction(String year, String userId, String partnerId) throws SQLException{
		String query = "SELECT\n"
				+ "    DATE_FORMAT(transaction_date, '%m') 연월,\n"
				+ "    SUM(CASE WHEN is_deposit = 'true' THEN price ELSE 0 END) 월별입금액,\n"
				+ "    SUM(CASE WHEN is_deposit = 'false' THEN price ELSE 0 END) 월별지출액\n"
				+ "FROM\n"
				+ "    gagyebu\n"
				+ "WHERE\n"
				+ "	transaction_date LIKE ?\n"
				+ "GROUP BY\n"
				+ "    DATE_FORMAT(transaction_date, '%m')\n"
				+ "ORDER BY\n"
				+ "    연월;";
		ResultSet rs = null;
		Map<Integer, int[]> map = new HashMap<>();
	
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, year + "%");
			rs = ps.executeQuery();
			while(rs.next()) {
				map.put(rs.getInt("연월"), new int[] {rs.getInt("월별입금액"), rs.getInt("월별지출액")});
			}
		}
		return map;
	}
	@Override
	public ArrayList<Gagyebu> getMonthGagyebu(String yearMonth, String userId, String partnerId) throws SQLException {
		// 커플의 각 아이디로 월별 가계부 데이터 조회 
		ArrayList<Gagyebu> gagyebus = new ArrayList<Gagyebu>();
	    Connection conn = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    
	    try {
	    	conn = getConnection();
	    	
	    	String query = "select id, user_id, transaction_date, is_deposit, category, price, title, "
	    			+ "payment_type, etc from gagyebu where transaction_date like ? and (user_id=? or user_id=?);";
	    	ps = conn.prepareStatement(query);
	    	ps.setString(1, yearMonth+"%"); // "2024-09%"
	    	ps.setString(2, userId);
	    	ps.setString(3, partnerId);
	    	
	    	rs = ps.executeQuery();
	    	
			// 리스트에 추가
			while(rs.next()) {				
				Gagyebu gagyebu = new Gagyebu();
				
			    gagyebu.setId(rs.getInt("id"));
			    gagyebu.setUserId(rs.getString("user_id"));
			    gagyebu.setTransactionDate(rs.getString("transaction_date"));
			    gagyebu.setDeposite(rs.getBoolean("is_deposit"));
			    gagyebu.setCategory(rs.getString("category"));
			    gagyebu.setPrice(rs.getInt("price"));
			    gagyebu.setTitle(rs.getString("title"));
			    gagyebu.setPaymentType(rs.getString("payment_type"));
			    gagyebu.setEtc(rs.getString("etc"));
				
				gagyebus.add(gagyebu);
			}
	    	
	    }catch (Exception e) {
			System.out.println("getMonthGagyebu err : " + e);
		}finally {
			closeAll(rs, ps, conn);
		}
		
		return gagyebus;
	}
	@Override
	public void createGagyebu(Gagyebu gagyebu)  throws SQLException{
		String query = "INSERT INTO gagyebu (user_id,transaction_date,is_deposit,category,price,title,payment_type,etc) "
				+ " VALUES (?,?,?,?,?,?,?,?);";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, gagyebu.getUserId());
			ps.setString(2, gagyebu.getTransactionDate());
			ps.setString(3, String.valueOf(gagyebu.getIsDeposit()));
			ps.setString(4, gagyebu.getCategory());
			ps.setInt(5, gagyebu.getPrice());
			ps.setString(6, gagyebu.getTitle());
			ps.setString(7, gagyebu.getPaymentType());
			ps.setString(8, gagyebu.getEtc());
			ps.executeUpdate();
		}
	}
	@Override
	public void updateGagyebu(Gagyebu gagyebu)  throws SQLException{
		String query = "UPDATE gagyebu SET user_id=?,transaction_date=?,is_deposit=?,category=?,price=?,title=?,payment_type=?,etc=? WHERE id=?;";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, gagyebu.getUserId());
			ps.setString(2, gagyebu.getTransactionDate());
			ps.setString(3, String.valueOf(gagyebu.getIsDeposit()));
			ps.setString(4, gagyebu.getCategory());
			ps.setInt(5, gagyebu.getPrice());
			ps.setString(6, gagyebu.getTitle());
			ps.setString(7, gagyebu.getPaymentType());
			ps.setString(8, gagyebu.getEtc());
			ps.setInt(9, gagyebu.getId());
			ps.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public void deleteGagyebu(int GagyebuId)  throws SQLException{
		String query = "DELETE FROM gagyebu WHERE id = ?";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setInt(1, GagyebuId);
			ps.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public void deleteGagyebu(String userId)  throws SQLException{
		String query = "DELETE FROM gagyebu WHERE user_id = ?";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, userId);
			ps.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public int getMonthDepositTotal(ArrayList<Gagyebu> gagyebus) {
		int depositTotal = 0;
		for(Gagyebu gagyebu : gagyebus) {
			if(gagyebu.getIsDeposit())	depositTotal += gagyebu.getPrice();
		}
		return depositTotal;
	}
	@Override
	public int getMonthExpenseTotal(ArrayList<Gagyebu> gagyebus) {
		int expenseTotal = 0;
		for(Gagyebu gagyebu : gagyebus) {
			if(!gagyebu.getIsDeposit())	expenseTotal += gagyebu.getPrice();
		}
		return expenseTotal;
	}
	
	// 가계부 리스트 생성 테스트 메소드
	/*
	 * public ArrayList<Gagyebu> gagyebuList(String userId) throws SQLException {
	 * ArrayList<Gagyebu> gagyebus = new ArrayList<Gagyebu>();
	 * 
	 * Connection conn = null; PreparedStatement ps = null; ResultSet rs = null;
	 * 
	 * try { conn = getConnection(); String query =
	 * "SELECT category, price FROM Gagyebu WHERE User_id=?"; ps =
	 * conn.prepareStatement(query); ps.setString(1, userId);
	 * 
	 * rs = ps.executeQuery();
	 * 
	 * // 리스트에 추가 while(rs.next()) { String category = rs.getString("category"); int
	 * price = rs.getInt("price");
	 * 
	 * Gagyebu gagyebu = new Gagyebu(); gagyebu.setCategory(category);
	 * gagyebu.setPrice(price);
	 * 
	 * gagyebus.add(gagyebu); }
	 * 
	 * }catch (Exception e) { System.out.println("가계부 리스트 만들기 e : " + e); }finally {
	 * closeAll(ps, conn); }
	 * 
	 * return gagyebus; }
	 */
	
	/* 항목별 지출 비율 데이터 조회 메소드 */
	@Override
	public Map<String, Integer> expenseRatioByCategory(ArrayList<Gagyebu> gagyebus) {
//	public Map<String, Integer> expenseRatioByCategory() throws SQLException {
		//ArrayList<Gagyebu> gagyebus = new ArrayList<Gagyebu>();
		Map<String, Integer> categoriesMap = new HashMap<String, Integer>();
		
		//gagyebus = gagyebuList("id01"); // 테스트
		
	    //Connection conn = null;
	    //PreparedStatement ps = null;
	    
	    //System.out.println("gagyebu list : " + gagyebus);
		
	    // 각 항목별 금액 집계
	    for(Gagyebu gagyebu : gagyebus) {
	    	String category = gagyebu.getCategory();
	    	int amount = gagyebu.getPrice();
	    	if(category == null) continue;
	    	// 해당 카테고리에 금액을 더해나감
	    	categoriesMap.put(category, categoriesMap.getOrDefault(category, 0) + amount);
	    }
	    System.out.println("expenseRatioByCategory : " + categoriesMap);
		/*
		 * try { conn = getConnection();
		 * 
		 * 
		 * 
		 * }catch (Exception e) { System.out.println("expenseRatioByCategory e : " + e);
		 * }finally { closeAll(ps, conn); }
		 */
		
		return categoriesMap;
	}
	
	@Override
	public void updateCategory(String[] categories, String userId) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		String DBCategory = String.join(",", categories);
		try {
			conn = getConnection();
			String query = "UPDATE category SET category_name = ? WHERE user_id = ?";
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
	/*
	public static void main(String[] args) throws Exception {

	// emilyhong
		GagyebuDAO dao = GagyebuDAOImpl.getInstance();
		Gagyebu gagyebu = null;
	/*
		dao.expenseRatioByCategory();
		// believeme
		String[] category = {"데이트"};
		String[] category2 = {"식비"};
		String[] category3 = {"데이트", "식비"};
		GagyebuDAOImpl.getInstance().updateCategory(category3, "id1");
		
		/*
		gagyebu = new Gagyebu(0, "id01", "2024-09-16", false, "식비", 30000, "제목", "카드", "기타");
		dao.createGagyebu(gagyebu);
		
		/*
		gagyebu = new Gagyebu(193, "id20", "2024-09-16", false, "식비", 90000, "제목", "카드", "기타");
		dao.updateGagyebu(gagyebu);
		
		//dao.deleteGagyebu(193);
		

		// 현정 
//		GagyebuDAO dao = GagyebuDAOImpl.getInstance();	
//		dao.expenseRatioByCategory();
//		dao.getMonthGagyebu("2024-09", "id01", "id20");
		
		// 믿음
//		Map<Integer, int[]> map = new HashMap<>();
//		map = dao.getYearTransaction("2024", "id01", "id20");
//		for (Map.Entry<Integer, int[]> m : map.entrySet()) {
//            Integer month = m.getKey();
//            int[] values = m.getValue();
//            System.out.println("월 :: " + month + ", 입금, 지출 :: " + Arrays.toString(values));
//        }

	}//main	
	*/
}
