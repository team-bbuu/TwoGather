package web.servlet.model.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import web.servlet.model.vo.Story;

public interface StoryDAO {
	Story getLatestStory (String userId, String partnerId) throws SQLException;// 최근 스토리 불러오는 기능
	ArrayList<Story> getAllStory (String userId,String partnerId) throws SQLException; // 전체 스토리 데이터 받아오는 메소드
	void createStory (Story story) throws SQLException;// 스토리 등록
	void updateStory (Story story) throws SQLException; // 스토리 수정
	void deleteStory (int storyId) throws SQLException; // 스토리 삭제
	void deleteStory(String userId) throws SQLException;
}
