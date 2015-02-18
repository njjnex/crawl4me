package by.njjnex.model;

import java.util.LinkedHashSet;
import java.util.Set;

public class Page {

	private String url;
	private String title;
	
	private Set<PageLink> links = new LinkedHashSet<PageLink>();
	private Set<DomRule> domRules = new LinkedHashSet<DomRule>();
	
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
