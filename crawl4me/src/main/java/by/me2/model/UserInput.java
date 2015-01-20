package by.me2.model;

import java.util.LinkedHashMap;

public class UserInput {
	
	private String url;
	private String regex;
	private LinkedHashMap<String,String> domRules;
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getRegex() {
		return regex;
	}
	public void setRegex(String regex) {
		this.regex = regex;
	}
	public LinkedHashMap<String, String> getDomRules() {
		return domRules;
	}
	public void setDomRules(LinkedHashMap<String, String> domRules) {
		this.domRules = domRules;
	}
	
	
	
}
