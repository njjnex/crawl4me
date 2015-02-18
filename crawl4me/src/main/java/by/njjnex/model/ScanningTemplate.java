package by.njjnex.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
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
	@ElementCollection
	private List<String> regex = new ArrayList<String>();
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.EAGER)
	private List<DomRule> domRules = new ArrayList<DomRule>();
		
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<String> getRegex() {
		return regex;
	}
	public void setRegex(List<String> regex) {
		this.regex = regex;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setDomRules(List<DomRule> domRules) {
		this.domRules = domRules;
	}
	public List<DomRule> getDomRules() {
		return domRules;
	}

}
