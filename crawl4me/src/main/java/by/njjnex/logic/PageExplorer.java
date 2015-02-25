package by.njjnex.logic;

import by.njjnex.logic.domRules.DomRulesHandler;
import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;

public class PageExplorer {

	private final String USER_AGENT = "Mozilla/5.0 (X11; Linux i686; rv:34.0) Gecko/20100101 Firefox/34.0";
	private final String REFERRER = "https://www.google.com/";
	private boolean connected = false;

	private String url;
	private PageHTML page = new PageHTML();
	private PageJS pageJS = new PageJS();

	public PageExplorer(String url) {
		this.url = url;
	}

	public PageHTML explorePage() {

		page.setUrl(url);
		page.setLinks(new LinksHandler().setTemplateLinks(url));
		page.setDomRules(new DomRulesHandler().setTemplateRules());

		return page;
	}

	public PageHTML exploreJSPage() {

		pageJS.setUrl(url);
		pageJS.setSearchPhrase("iphone 6 plus gold");
		pageJS.setLinks(new LinksHandler().setPaginator());
		pageJS.setDomRules(new DomRulesHandler().setTemplateJSRules());

		return pageJS;
	}

}
