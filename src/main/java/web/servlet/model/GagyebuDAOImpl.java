package web.servlet.model;

import java.util.ArrayList;
import java.util.Map;

public class GagyebuDAOImpl implements GagyebuDAO {
	private GagyebuDAOImpl() {}
	private static GagyebuDAOImpl dao = new GagyebuDAOImpl();
	public static GagyebuDAOImpl getInstance() {
		return dao;
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
