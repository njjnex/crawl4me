package by.njjnex.model;

import java.util.List;

public interface PageCrawler {

	public String getId();

	public void setId(String id);

	public String getUrl();

	public void setUrl(String url);

	public String getTitle();

	public void setTitle(String title);

	public List<PageLink> getLinks();

	public void setLinks(List<PageLink> links);

	public List<DomRule> getDomRules();

	public void setDomRules(List<DomRule> domRules);
}
