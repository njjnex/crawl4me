package by.njjnex.logic;

import java.util.LinkedHashSet;
import java.util.Set;

import by.njjnex.model.PageLink;

public class LinksHandler {

	public Set<PageLink> setTemplateLinks(String url) {
		Set<PageLink> pageLinks = new LinkedHashSet<PageLink>();
		
		PageLink pageLink = new PageLink();
		pageLink.setLinkHref(url + "/.*");
		pageLink.setLinkText("This page and all subpages");
		pageLink.setIncluded(true);
		pageLinks.add(pageLink);
		
		PageLink pageLink1 = new PageLink();
		pageLink1.setLinkHref(url + "/.*.html");
		pageLink1.setLinkText("Only pages that ends with .html");
		pageLink1.setIncluded(false);
		pageLinks.add(pageLink1);
		
		PageLink pageLink2 = new PageLink();
		pageLink2.setLinkHref(url + "/.{5}[a-z]?\\w=\\d.html");
		pageLink2.setLinkText("Any format according Regex expression");
		pageLink2.setIncluded(false);
		pageLinks.add(pageLink2);
		
		
		return pageLinks;
	}
	
}
