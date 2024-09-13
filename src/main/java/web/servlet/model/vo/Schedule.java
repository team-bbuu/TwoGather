package web.servlet.model.vo;

public class Schedule {
	private int id;
	private String userId;
	private boolean isPersonal;
	private String startDate;
	private String endDate;
	private String title;
	private String description;
	
	public Schedule() {}
	public Schedule(int id, String userId, boolean isPersonal, String startDate, String endDate, String title,
			String description) {
		super();
		this.id = id;
		this.userId = userId;
		this.isPersonal = isPersonal;
		this.startDate = startDate;
		this.endDate = endDate;
		this.title = title;
		this.description = description;
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the isPersonal
	 */
	public boolean isPersonal() {
		return isPersonal;
	}
	/**
	 * @param isPersonal the isPersonal to set
	 */
	public void setPersonal(boolean isPersonal) {
		this.isPersonal = isPersonal;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Schedule [id=" + id + ", startDate=" + startDate + ", endDate=" + endDate + ", title=" + title
				+ ", description=" + description + ", isPersonal=" + isPersonal + "]";
	}
	
	
}
