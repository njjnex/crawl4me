package by.njjnex.logic;

import java.util.ArrayList;
import java.util.List;

import by.njjnex.model.PageLink;

/*
 * Creates default scanning template values.
 */
public class LinksHandler {

	public List<PageLink> setTemplateLinks(String url) {
		List<PageLink> pageLinks = new ArrayList<PageLink>();

		PageLink pageLinkDefault = new PageLink();
		pageLinkDefault.setLinkHref("-");
		pageLinkDefault.setLinkText("Only this page");
		pageLinkDefault.setIncluded(true);
		pageLinks.add(pageLinkDefault);

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

	public List<PageLink> setPaginator() {
		List<PageLink> paginator = new ArrayList<PageLink>();

		PageLink pageJS0 = new PageLink();
		pageJS0.setLinkHref("-");
		pageJS0.setLinkText("Only first page");
		pageJS0.setIncluded(true);
		paginator.add(pageJS0);
		
		PageLink pageJS1 = new PageLink();
		pageJS1.setLinkHref("<a class = \"gspr next\">");
		pageJS1.setLinkText("Use page switcher");
		pageJS1.setIncluded(false);
		paginator.add(pageJS1);

		return paginator;
	}
}
