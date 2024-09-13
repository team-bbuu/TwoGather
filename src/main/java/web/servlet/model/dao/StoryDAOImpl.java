package web.servlet.model.dao;

import java.util.ArrayList;

import web.servlet.model.vo.Story;

public class StoryDAOImpl implements StoryDAO {
	private StoryDAOImpl() {}
	private static StoryDAOImpl dao = new StoryDAOImpl();
	public static StoryDAOImpl getInstance() {
		return dao;
	}
	@Override
	public Story getLatestStory(String userId) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public ArrayList<Story> getAllStory(String userId) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void createStory(Story story, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void updateStory(Story story, String userId) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteStory(String storyId) {
		// TODO Auto-generated method stub
		
	}
}
