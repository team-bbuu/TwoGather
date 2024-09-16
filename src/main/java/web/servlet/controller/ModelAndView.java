package web.servlet.controller;

public class ModelAndView {
	private String path;
	private boolean isRedirect;
	public ModelAndView(String path, boolean isRedirect) {
		this.path = path;
		this.isRedirect = isRedirect;
	}
	public ModelAndView(String path) {
		this.path = path;
	}
	public String getPath() {
		return path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	@Override
	public String toString() {
		return "ModelAndView [path=" + path + ", isRedirect=" + isRedirect + "]";
	}
	
	
}
