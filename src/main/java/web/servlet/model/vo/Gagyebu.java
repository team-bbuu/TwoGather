package web.servlet.model.vo;

public class Gagyebu {
	private int id;
	private String userId; // 입금시 입금자명, 지출시 결제자 아이디
	private String transactionDate;
	private boolean isDeposit;
	private String category;
	private int price;
	private String title;
	private String paymentType;
	private String etc;
	
	public Gagyebu() {}
	
	

	public Gagyebu(int id, String userId, String transactionDate, boolean isDeposit, String category, int price,
			String title, String paymentType, String etc) {
		super();
		this.id = id;
		this.userId = userId;
		this.transactionDate = transactionDate;
		this.isDeposit = isDeposit;
		this.category = category;
		this.price = price;
		this.title = title;
		this.paymentType = paymentType;
		this.etc = etc;
	}



	// 입금
	public Gagyebu(int id, boolean isDeposit, String userId, int price, String title, String etc, String transactionDate) {
		super();
		this.id = id;
		this.isDeposit = isDeposit;
		this.userId = userId;
		this.price = price;
		this.title = title;
		this.etc = etc;
		this.transactionDate = transactionDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isDeposit() {
		return isDeposit;
	}

	public void setDeposite(boolean isDeposit) {
		this.isDeposit = isDeposit;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}

	@Override
	public String toString() {
		return "Gagyebu [id=" + id + ", isDeposit=" + isDeposit + ", category=" + category + ", userId=" + userId
				+ ", price=" + price + ", title=" + title + ", paymentType=" + paymentType + ", etc=" + etc
				+ ", transactionDate=" + transactionDate + "]";
	}	
}