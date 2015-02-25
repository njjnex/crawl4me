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

@Entity 
@Table(name= "SCANNING_PAGE")

public class Page {

	@Id
	@Column(name = "GENERATED_ID")
	private String id;
	@Column(name = "URL")
	private String url;
	@Column(name = "TITLE")
	private String title;
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.EAGER)
	private List<PageLink> links = new ArrayList<PageLink>();
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.EAGER)
	private List<DomRule> domRules = new ArrayList<DomRule>();
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<PageLink> getLinks() {
		return links;
	}

	public void setLinks(List<PageLink> links) {
		this.links = links;
	}

	public List<DomRule> getDomRules() {
		return domRules;
	}

	public void setDomRules(List<DomRule> domRules) {
		this.domRules = domRules;
	}

	
}
