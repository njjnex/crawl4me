package by.njjnex.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

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
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.EAGER)
	private List<DomRule> domRules = new ArrayList<DomRule>();
	@Transient
	private ArrayList<String> selectors = new ArrayList<String>();
	
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
		
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public ArrayList<String> getSelectors() {
		return selectors;
	}
	public void setSelectors(ArrayList<String> selectors) {
		this.selectors = selectors;
	}
	public void setDomRules(List<DomRule> domRules) {
		this.domRules = domRules;
	}
	public List<DomRule> getDomRules() {
		return domRules;
	}
	
	
	
	
}
