package web.servlet.model.vo;

public class Story {
	private int id;
	private String userId;
	private String uploadDate;
	private String imgSrc;
	private String title;
	private String content;
	
	public Story() { }
	
	

	public Story(int id, String userId, String uploadDate, String imgSrc, String title, String content) {
		super();
		this.id = id;
		this.userId = userId;
		this.uploadDate = uploadDate;
		this.imgSrc = imgSrc;
		this.title = title;
		this.content = content;
	}



	public int getId() {
		return id;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public String getTitle() {
		return title;
	}

	public String getContent() {
		return content;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}

	@Override
	public String toString() {
		return "Story [id=" + id + ", imgSrc=" + imgSrc + ", title=" + title + ", content=" + content + ", uploadDate="
				+ uploadDate + "]";
	}
	
}
