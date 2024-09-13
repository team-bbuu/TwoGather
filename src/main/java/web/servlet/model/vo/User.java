package web.servlet.model.vo;

public class User {
	private String id;
	private String pass;
	private String nickname;
	private String mobile;
	private String birthdate;
	private String email;
	private String gender;
	private String address;
	private String matching;
	private String startDate;
	private String breakDate;
	private String imgsrc;
	private String partnerId;
	private String[] category;
	public User(String id, String pass, String nickname, String mobile, String birthdate, String email, String gender,
			String address) {
		this.id = id;
		this.pass = pass;
		this.nickname = nickname;
		this.mobile = mobile;
		this.birthdate = birthdate;
		this.email = email;
		this.gender = gender;
		this.address = address;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
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
	public String getImgsrc() {
		return imgsrc;
	}
	public void setImgsrc(String imgsrc) {
		this.imgsrc = imgsrc;
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
	
	
	
}
