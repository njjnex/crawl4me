package by.njjnex.logic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import by.njjnex.logic.domRules.DomRulesHandler;
import by.njjnex.model.Page;
import by.njjnex.model.PageLink;

public class PageExplorer {

	private final String USER_AGENT = "Mozilla/5.0 (X11; Linux i686; rv:34.0) Gecko/20100101 Firefox/34.0";
	private final String REFERRER = "https://www.google.com/";
	private boolean connected = false;

	private String url;
	private Document doc;
	private Page page = new Page();
	private String title;
	
	public PageExplorer(String url) {
		this.url = url;

		/*try {
			doc = Jsoup.connect(url).userAgent(USER_AGENT).referrer(REFERRER).get();
			title = doc.select("title").text();
			connected = true;
		} catch (IOException e) {
			e.printStackTrace();
			title = "Error: cannot connect to URL. Is entered URL valid?";
		}*/
	}

	public Page explorePage() {

		// set page title
		page.setTitle(title);

		if (connected) {
			// extract links from the page//
			ArrayList<PageLink> pageLinks = new ArrayList<PageLink>();
			ArrayList<String> linksArray = new ArrayList<String>();

			Elements links = doc.getElementsByTag("a");
						
			for (Element link : links) {
				String linkHref = link.attr("href");
				if (!StringUtils.substringAfterLast(linkHref, "/").isEmpty())
					linkHref = StringUtils.substringBeforeLast(linkHref, "/");
				linksArray.add(linkHref);
			}
			Set<String> uniqueLinks = removeDublicates(linksArray);

			for (String link : uniqueLinks) {
				PageLink pageLink = new PageLink();
				pageLink.setLinkHref(link);

				System.out.println("Link added: " + link);
				pageLinks.add(pageLink);
			}
			
			page.setLinks(createPageLinks(groupLinks(pageLinks)));
			page.setDomRules(new DomRulesHandler().setTemplateRules());
		}else{
			page.setLinks(new LinksHandler().setTemplateLinks(url));
			page.setDomRules(new DomRulesHandler().setTemplateRules());
		}

		return page;
	}

	public Set<String> groupLinks(ArrayList<PageLink> pageLinks) { // grouping
																	// href's by
																	// comparing
		Set<PageLink> exploredLinks = new LinkedHashSet<PageLink>();
		ArrayList<String> resultLinks = new ArrayList<String>();

		for (PageLink link : pageLinks) {

			String httpPrefix = null;
			String httpsPrefix = null;
			String siteStartUrl = null;
						
			Pattern pattern = Pattern.compile("http://.*[.].{2,3}/");
			Matcher matcher = pattern.matcher(url);
			if (matcher.find())
			{
			    System.out.println("matcher " + matcher.group(1));
			    siteStartUrl = matcher.group(1);
			}
			
			

			String linkHref = link.getLinkHref();
			if (!linkHref.isEmpty() && linkHref.length() > 5 ) {
				System.out.println("Compare: " + linkHref);

				if (linkHref.startsWith("http://")) {
					linkHref = StringUtils.substringAfter(linkHref, "http://");
					httpPrefix = "http:/";
					
				}
				if (linkHref.startsWith("https://")) {
					linkHref = StringUtils.substringAfter(linkHref, "https://");
					httpsPrefix = "https:/";
				}

				String[] arrayHref = linkHref.split("/");
				if (arrayHref.length > 1 && arrayHref[0] != null && arrayHref[0].equals("")) {
					List<String> list = new ArrayList<String>(Arrays.asList(arrayHref));
					list.remove(0);
					arrayHref = list.toArray(new String[list.size()]);
				}

				for (PageLink linkeds : pageLinks) {

					List<String> resultItem = new ArrayList<String>();

					String linksHref = linkeds.getLinkHref();

					if (!linksHref.isEmpty() && !linkHref.equals(linksHref)) {
						
						System.out.println("With: " + linksHref);
						if (linksHref.startsWith("http://"))
							linksHref = StringUtils.substringAfter(linksHref, "http://");

						if (linksHref.startsWith("https://"))
							linksHref = StringUtils.substringAfter(linksHref, "https://");

						String[] arrayHrefLinks = linksHref.split("/");

						if(arrayHrefLinks.length > 1 && arrayHrefLinks[0] != null && arrayHrefLinks[0].equals("")){
							List<String> list = new ArrayList<String>(Arrays.asList(arrayHrefLinks));
							list.remove(0);
							arrayHrefLinks = list.toArray(new String[list.size()]);
						}
			
						if (arrayHref.length >= arrayHrefLinks.length) {
							int i = 0;

							while (i < arrayHref.length) {
								if (arrayHrefLinks.length > i && arrayHrefLinks[i] != null) {
									System.out.println(" Comparing: - " + arrayHref[i] + " with: " + arrayHrefLinks[i]);
									if (arrayHrefLinks[i].equals(arrayHref[i])) {
										resultItem.add(arrayHref[i]);
										i++;
										System.out.println("Equals");
									} else {

										i = arrayHref.length;
										System.out.println("Not equals");
										System.out.println(resultItem.size() + " result size !!!! i: " + i);

										if (resultItem.size() > 0) {
											resultItem.add(".*");
											System.out.println("Got in if");
											
											if (httpPrefix != null)
												resultItem.add(0, httpPrefix);
											if (httpsPrefix != null)
												resultItem.add(0, httpsPrefix);
											if (!resultItem.get(0).startsWith("http://") || !resultItem.get(0).startsWith("https://")){
												resultItem.add(0, siteStartUrl);
											}

											String resultHref = Arrays.toString(resultItem.toArray());
											resultHref = resultHref.replaceAll(",", "/");
											resultHref = resultHref.replaceAll("\\s", "");
											resultHref = resultHref.substring(1, resultHref.length() - 1);

											resultLinks.add(resultHref);
																											
											resultItem.clear();
										}
									}
								}else{
									i = arrayHref.length;
									System.out.println("Not equals");
									System.out.println(resultItem.size() + " result size !!!! i: " + i);

									if (resultItem.size() > 0) {
										resultItem.add(".*");	
										System.out.println("Got in if");
										
										if (httpPrefix != null)
											resultItem.add(0, httpPrefix);
										if (httpsPrefix != null)
											resultItem.add(0, httpsPrefix);

										String resultHref = Arrays.toString(resultItem.toArray());
										resultHref = resultHref.replaceAll(",", "/");
										resultHref = resultHref.replaceAll("\\s", "");
										resultHref = resultHref.substring(1, resultHref.length() - 1);
																				
										resultLinks.add(resultHref);
																			
										resultItem.clear();
									}
								}

							}
						}
					}
				}
			}
		}
		Collections.sort(resultLinks);
		
		return removeDublicates(resultLinks);
	}

	public Set<String> removeDublicates(ArrayList<String> links) {
		Set<String> uniqueLinks = new LinkedHashSet<String>(links);
		return uniqueLinks;
	}
	
	public int timesFounded(Document doc, String link){
			int times = 0;
			Elements elements = doc.select("[href*=" + link + "]");
			for(Element element: elements){
				times++;
			}
		return times;
	}
	
	public Set<PageLink> createPageLinks(Set<String> links){
		
		Set<PageLink> pageLinks = new LinkedHashSet<PageLink>();
		int linksCounter = 0;
		
		for(String link: links){
			linksCounter++;
			PageLink pageLink = new PageLink();
			pageLink.setLinkHref(link);
			pageLink.setId(linksCounter);
			pageLink.setIncluded(false);
			pageLink.setTimesFounded(timesFounded(doc, StringUtils.substringBeforeLast(link, "/")));
					
			pageLinks.add(pageLink);
		}
				
		return pageLinks;
	}
	
	public Set<PageLink> createTemplateLinks(){
		Set<PageLink> pageLinks = new LinkedHashSet<PageLink>();
		
		PageLink pageLink = new PageLink();
		
		
		pageLinks.add(pageLink);
		
		return pageLinks;
		
	}
	
}
