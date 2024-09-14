package web.servlet.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import config.ServerInfo;
import web.servlet.model.vo.Story;

public class StoryDAOImpl implements StoryDAO {
	DataSource ds;
	private StoryDAOImpl() {
		/*
		try {
			InitialContext ic = new InitialContext();
			ds=	(DataSource)ic.lookup("java:comp/env/jdbc/mysql");
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
	private static StoryDAOImpl dao = new StoryDAOImpl();
	public static StoryDAOImpl getInstance() {
		return dao;
	}
	
	public Connection getConnection() throws SQLException{
		//return ds.getConnection();
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
	public Story getLatestStory(String userId, String partnerId) {
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
	public ArrayList<Story> getAllStory(String userId) {
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
	public void createStory(Story story, String userId) {
		String query = "insert into story(user_id,upload_date,img_src,title,content) values (?,?,?,?,?)";
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, story.getUserId());
			ps.setString(2, story.getUploadDate());
			ps.setString(3, story.getImgSrc());
			ps.setString(4, story.getTitle());
			ps.setString(5, story.getContent());
			ps.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public void updateStory(Story story, String userId) {
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
	public void deleteStory(String storyId) {
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
	public static void main(String[] args) {
		StoryDAOImpl dao = getInstance();
		Story story = new Story(0, "id01", "2024-09-14", "", "제목", "내용");
		dao.createStory(story, null);
	}
}
