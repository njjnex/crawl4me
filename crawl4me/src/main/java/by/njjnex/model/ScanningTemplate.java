package by.njjnex.model;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OrderColumn;
import javax.persistence.Table;

@Entity
@Table(name = "TEMPLATE")
public class ScanningTemplate {
	
	@Id
	@Column(name = "GENERATED_ID")
	private String id;
	@Column(name = "URL")
	private String url;
	@Column(name = "REGEX")
	private String regex;
	@ElementCollection(fetch= FetchType.EAGER)
	@OrderColumn
	private Map<String,String> domRules = new LinkedHashMap<String,String>();
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
	
	public Map<String, String> getDomRules() {
		return domRules;
	}
	public void setDomRules(Map<String, String> domRules) {
		this.domRules = domRules;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	
}
