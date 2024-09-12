package web.servlet.model;

public class Schedule {
	private int id;
	private String startDate;
	private String endDate;
	private String title;
	private String description;
	private boolean isPersonal;
	
	private Schedule() {}
	public Schedule(int id, String startDate, String endDate, String title, String description, boolean isPersonal) {
		super();
		this.id = id;
		this.startDate = startDate;
		this.endDate = endDate;
		this.title = title;
		this.description = description;
		this.isPersonal = isPersonal;
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
	@Override
	public String toString() {
		return "Schedule [id=" + id + ", startDate=" + startDate + ", endDate=" + endDate + ", title=" + title
				+ ", description=" + description + ", isPersonal=" + isPersonal + "]";
	}
	
	
}
