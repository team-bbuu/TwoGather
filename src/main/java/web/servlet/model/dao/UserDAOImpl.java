package web.servlet.model.dao;

import web.servlet.model.vo.User;

public class UserDAOImpl implements UserDAO {
	private UserDAOImpl() {}
	private static UserDAOImpl dao = new UserDAOImpl();
	public static UserDAOImpl getInstance() {
		return dao;
	}
	@Override
	public Boolean checkID(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Boolean checkEmail(String email) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Boolean checkMobile(String mobile) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public User register(User vo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public User login(String id, String password) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String findId(String email, String mobile) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String findPass(String id, String birthDate) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void breakPartner(String id) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteUser(String id) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void invitePartner(String id, String partnerId) {
		// TODO Auto-generated method stub
		
	}
}
