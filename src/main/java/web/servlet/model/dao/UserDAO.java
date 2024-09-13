package web.servlet.model.dao;

import web.servlet.model.vo.User;

public interface UserDAO {
	/* RE */
	Boolean checkID (String id); // 아이디 중복체크 메소드
	Boolean checkEmail (String email);// email 중복체크 메소드
	Boolean checkMobile (String mobile); // mobile 중복체크 메소드
	User register (User vo); // 회원가입 메소드
	/* LO */ 
	User login (String id, String password);  // 로그인 메소드
	String findId (String email, String mobile); // 아이디 찾기
	String findPass (String id, String birthDate); // 비밀번호 찾기
	/* MY */
	void updateUser (User user); // 회원정보수정
	void breakPartner (String id); // 헤어지기
	void deleteUser (String id) ; // 회원탈퇴
	void invitePartner (String id, String partnerId); // 파트너 초대하기
}
