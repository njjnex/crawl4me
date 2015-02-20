package by.njjnex.logic;

import java.util.ArrayList;
import java.util.List;

import by.njjnex.model.PageLink;

public class LinksHandler {

	public List<PageLink> setTemplateLinks(String url) {
		List<PageLink> pageLinks = new ArrayList<PageLink>();
		
		PageLink pageLinkDefaul = new PageLink();
		pageLinkDefaul.setLinkHref("-");
		pageLinkDefaul.setLinkText("Only this page");
		pageLinkDefaul.setIncluded(true);
		pageLinks.add(pageLinkDefaul);
				
		PageLink pageLink0 = new PageLink();
		pageLink0.setLinkHref(url + "/.*");
		pageLink0.setLinkText("This page and all subpages");
		pageLink0.setIncluded(false);
		pageLinks.add(pageLink0);
		
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
