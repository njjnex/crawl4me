package by.njjnex.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown=true)
public class PageLink {

	private int id;
	private int timesFounded;
	private String linkHref;
	private String linkText;
	private boolean included;
		
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTimesFounded() {
		return timesFounded;
	}
	public void setTimesFounded(int timesFounded) {
		this.timesFounded = timesFounded;
	}
	public String getLinkHref() {
		return linkHref;
	}
	public void setLinkHref(String linkHref) {
		this.linkHref = linkHref;
	}
		
	public String getLinkText() {
		return linkText;
	}
	public void setLinkText(String linkText) {
		this.linkText = linkText;
	}
	public boolean isIncluded() {
		return included;
	}
	public void setIncluded(boolean included) {
		this.included = included;
	}
	
	
}
