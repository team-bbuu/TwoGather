package web.servlet.model.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import web.servlet.model.vo.Gagyebu;

public interface GagyebuDAO {
	Map<Integer,int[]> getYearTransaction (String year, String userId, String partnerId) throws SQLException ;// 해당년도 입금, 지출액 가져오는 메소드
	ArrayList<Gagyebu> getMonthGagyebu (String yearMonth, String userId, String partnerId) throws SQLException ;// 월 데이터 받아오기 메소드
	void createGagyebu (Gagyebu g) throws SQLException; // 가계부 등록
	void updateGagyebu (Gagyebu g) throws SQLException; // 가계부 수정
	void deleteGagyebu (int gagyebuId) throws SQLException; // 가계부 삭제
	void deleteGagyebu(String userId) throws SQLException;
	int getMonthDepositTotal(ArrayList<Gagyebu> gagyebus); // 한달 총 입금액 조회 메소드
	int getMonthExpenseTotal(ArrayList<Gagyebu> gagyebus); // 한달 총 지출액 조회 메소드
	Map<String,Integer> expenseRatioByCategory(ArrayList<Gagyebu> gagyebus); // 항목별 지출 비율 데이터 조회 메소드
//	Map<String,Integer> expenseRatioByCategory() throws SQLException; // 항목별 지출 비율 데이터 조회 메소드
	void updateCategory(String[] categories, String userId) throws SQLException; // 항목 수정 메소드
}
