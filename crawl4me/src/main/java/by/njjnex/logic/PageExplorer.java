package by.njjnex.logic;

import by.njjnex.logic.domRules.DomRulesHandler;
import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;

public class PageExplorer {

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
