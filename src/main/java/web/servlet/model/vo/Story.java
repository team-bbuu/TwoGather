package web.servlet.model.vo;

public class Story {
	private int id;
	private String imgSrc;
	private String title;
	private String content;
	private String uploadDate;
	
	public Story() { }
	
	public Story(String imgSrc, String title, String uploadDate) {
		this.imgSrc = imgSrc;
		this.title = title;
		this.uploadDate = uploadDate;
	}

	public Story(String imgSrc, String title, String content, String uploadDate) {
		this(imgSrc, title, uploadDate);
		this.content = content;
	}

	public Story(int id, String imgSrc, String title, String content, String uploadDate) {
		this(imgSrc, title, content, uploadDate);
		this.id = id;
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
