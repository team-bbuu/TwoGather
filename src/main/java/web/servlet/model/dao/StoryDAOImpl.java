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
		String query = "SELECT id,user_id,upload_date,img_src,title,content FROM story WHERE user_id IN (?,?) ORDER BY upload_date desc LIMIT 1";
		ResultSet rs = null;
		Story story = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, userId);
			ps.setString(2, partnerId);
			rs=ps.executeQuery();
			if(rs.next()) {
				story= new Story(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
			}
		}catch (SQLException e) {
			System.out.println(e);
		}
		return story;
	}
	@Override
	public ArrayList<Story> getAllStory(String userId, String partnerId) {
		String query = "SELECT id,user_id,upload_date,img_src,title,content FROM story WHERE user_id IN (?,?) ORDER BY upload_date desc";
		ResultSet rs = null;
		ArrayList<Story> list = new ArrayList<Story>();
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, userId);
			ps.setString(2, partnerId);
			rs= ps.executeQuery();
			while(rs.next()) {
				list.add(new Story(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)));
			}
		}catch (SQLException e) {
			System.out.println(e);
		}
		return list;
	}
	@Override
	public void createStory(Story story) {
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
	public void updateStory(Story story) {
		String query = "UPDATE story set user_id=?, upload_date=?,img_src=?,title=?,content=? WHERE id=?";
		ResultSet rs = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setString(1, story.getUserId());
			ps.setString(2, story.getUploadDate());
			ps.setString(3, story.getImgSrc());
			ps.setString(4, story.getTitle());
			ps.setString(5, story.getContent());
			ps.setInt(6, story.getId());
			ps.executeUpdate();
			
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	@Override
	public void deleteStory(int storyId) {
		String query = "DELETE FROM story WHERE id = ?";
		ResultSet rs = null;
		try(
			Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
				){
			ps.setInt(1, storyId);
			ps.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e);
		}
	}
	/*
	public static void main(String[] args) {
		StoryDAOImpl dao = getInstance();
		/*
		Story story = new Story(0, "id01", "2024-09-14", "", "제목", "내용");
		dao.createStory(story);
		
		/*
		Story story = new Story(21, "id01", "2024-09-18", "", "제목", "내용");
		dao.updateStory(story);
		
		/*
		dao.deleteStory(21);
		
		//System.out.println(dao.getLatestStory("id01", "id20")); 
		/*
		dao.getAllStory("id01", "id20").forEach((i)->{
			System.out.println(i);
		});
		
	}
	*/
}
