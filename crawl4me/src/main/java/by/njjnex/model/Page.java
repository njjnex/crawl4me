package by.njjnex.model;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

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
	@Transient
	private Set<PageLink> links = new LinkedHashSet<PageLink>();
	@OneToMany(cascade = CascadeType.ALL, fetch=FetchType.EAGER)
	private Set<DomRule> domRules = new LinkedHashSet<DomRule>();
	

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

	public Set<PageLink> getLinks() {
		return links;
	}

	public void setLinks(Set<PageLink> links) {
		this.links = links;
	}

	public Set<DomRule> getDomRules() {
		return domRules;
	}

	public void setDomRules(Set<DomRule> domRules) {
		this.domRules = domRules;
	}
	
}
