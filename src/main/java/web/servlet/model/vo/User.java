package web.servlet.model.vo;

import java.util.Arrays;

public class User {
	private String id;
	private String partnerId;
	private String imgSrc;
	private String password;
	private String nickname;
	private String mobile;
	private String birthdate;
	private String email;
	private String gender;
	private String address;
	private String matching;
	private String startDate;
	private String breakDate;
	private String[] category;
	public User() {}
	
	public User(String id, String partnerId, String imgSrc, String password, String nickname, String mobile,
			String birthdate, String email, String gender, String address, String matching, String startDate,
			String breakDate, String[] category) {
		super();
		this.id = id;
		this.partnerId = partnerId;
		this.imgSrc = imgSrc;
		this.password = password;
		this.nickname = nickname;
		this.mobile = mobile;
		this.birthdate = birthdate;
		this.email = email;
		this.gender = gender;
		this.address = address;
		this.matching = matching;
		this.startDate = startDate;
		this.breakDate = breakDate;
		this.category = category;
	}
	

	public User(String id, String password, String nickname, String mobile, String birthdate, String email,
			String gender, String address, String matching) {
		super();
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.mobile = mobile;
		this.birthdate = birthdate;
		this.email = email;
		this.gender = gender;
		this.address = address;
		this.matching = matching;
	}

	public String getpassword() {
		return password;
	}
	public void setpassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMatching() {
		return matching;
	}
	public void setMatching(String matching) {
		this.matching = matching;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getBreakDate() {
		return breakDate;
	}
	public void setBreakDate(String breakDate) {
		this.breakDate = breakDate;
	}
	public String getimgSrc() {
		return imgSrc;
	}
	public void setimgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}
	public String getPartnerId() {
		return partnerId;
	}
	public void setPartnerId(String partnerId) {
		this.partnerId = partnerId;
	}
	public String[] getCategory() {
		return category;
	}
	public void setCategory(String[] category) {
		this.category = category;
	}
	public String getId() {
		return id;
	}
	public String getGender() {
		return gender;
	}
	
	public String getImgSrc() {
		return imgSrc;
	}

	public String getPassword() {
		return password;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", partnerId=" + partnerId + ", imgSrc=" + imgSrc + ", password=" + password
				+ ", nickname=" + nickname + ", mobile=" + mobile + ", birthdate=" + birthdate + ", email=" + email
				+ ", gender=" + gender + ", address=" + address + ", matching=" + matching + ", startDate=" + startDate
				+ ", breakDate=" + breakDate + ", category=" + Arrays.toString(category) + "]";
	}
	
	
	
}
