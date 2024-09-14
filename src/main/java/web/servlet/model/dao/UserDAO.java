package web.servlet.model.dao;

import java.sql.SQLException;

import web.servlet.model.vo.User;

public interface UserDAO {
	/* RE */
	User FindUser (String id) throws SQLException; // 아이디 중복체크 메소드
	Boolean checkEmail (String email) throws SQLException;// email 중복체크 메소드
	Boolean checkMobile (String mobile) throws SQLException; // mobile 중복체크 메소드
	void register (User vo) throws SQLException; // 회원가입 메소드
	/* LO */ 
	User login (String id, String password);  // 로그인 메소드
	String findId (String email, String mobile); // 아이디 찾기
	String findPass (String id, String birthDate); // 비밀번호 찾기
	/* MY */
	void updateUser (User user); // 회원정보수정
	void deleteUser (String id) ; // 회원탈퇴
}
