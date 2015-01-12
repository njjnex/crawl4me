package by.njjnex.collector;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map.Entry;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import cn.edu.hfut.dmic.webcollector.crawler.DeepCrawler;
import cn.edu.hfut.dmic.webcollector.model.Links;
import cn.edu.hfut.dmic.webcollector.model.Page;
import cn.edu.hfut.dmic.webcollector.net.Proxys;
import cn.edu.hfut.dmic.webcollector.util.RegexRule;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.ListMultimap;

public class Launcher extends DeepCrawler {

	RegexRule regexRule = new RegexRule();
	private String urlToScan;
	private String urlRegex;
	private String documentRule;
	
	ListMultimap<String, String> result = ArrayListMultimap.create();
		
	
	public ListMultimap<String, String> getResult() {
		return result;
	}
	public void setResult(ListMultimap<String, String> result) {
		this.result = result;
	}
	public Launcher(String crawlPath, String rule) {
		super(crawlPath);

		regexRule.addRule("^" + rule + "$"); // positive rule

		/*
		 * regexRule.addRule("-.*jpg.*"); // negative rule
		 */
	}
	public Launcher(String crawlPath, String urlToScan, String urlRegex, String documentRule){
		super(crawlPath);
		this.urlToScan = urlToScan;
		this.urlRegex = urlRegex;
		this.documentRule = documentRule;
		
		regexRule.addRule(urlRegex);
		
	}
	
	public Links visitAndGetNextLinks(Page page, LinkedHashMap<String, String> domRules) {
		/*Document doc1 = page.getDoc();*/

		Document doc = null;
		try {
			doc = Jsoup
					.connect(page.getUrl())
					.userAgent(
							"Mozilla/5.0 (X11; Linux i686; rv:34.0) Gecko/20100101 Firefox/34.0")
					.referrer("https://www.google.com/").get();
		} catch (IOException e) {
			System.out
					.println("Cannot create connection: " + e.getStackTrace());
			e.printStackTrace();
		}

		String title = doc.title();
		System.out.println("<-------------------------------------------------------->");
		System.out.println("URL:" + page.getUrl() + " Title: " + title);
		String details = page.getDoc().select("div[class=content__header]")
				.text();
		String price = page.getDoc().select("span[itemprop=price]").text();
		System.out.println(details + " price: " + price);
		System.out.println("<-------------------------------------------------------->");
		
		for(Entry<String, String> domRule: domRules.entrySet()){
		
			String key = domRule.getKey();		
			String value = page.getDoc().select(domRule.getValue()).text();
			System.out.println("***********dom : " + key + " : " + value);
			result.put(key, value);
			System.out.println("Founded:" + result.size());
		}
		
		/*
		 * Here is the 2.0 version of the newly added content   Extracts page
		 * link in return, these links are passed to crawling on the next round.
		 *   Do not worry URL crawler will automatically filter duplicate URL.
		 */
		Links nextLinks = new Links();

		/*
		 * Pass our crawling rules for extracted links， Links.addAllFromDocument
		 * provide this function
		 */
		// nextLinks.addAllFromDocument(page.getDoc(), "h3>a[id^=uigs]");
		nextLinks.addAllFromDocument(doc, regexRule);

		/*
		 * Links class inherits ArrayList <String>, you can use the add, addAll
		 * and other methods to add own URL. If you want to crawl only current
		 * page, there is no need to other links, you can return null For
		 * example, if your task is simply crawling list of all the links, this
		 * method should return null          
		 */
		return nextLinks;
	}

	public static void main(String[] args) throws Exception {
		/*
		 * Constructor string, a crawler crawlPath, crawler saving information
		 * in exists crawlPath folder, Different crawlers can use a different
		 * crawlPath*/
		 
		Launcher crawler = new Launcher("/tut", "http://www.21vek.by/mobile/.*.html");
		crawler.setThreads(50);
		crawler.addSeed("http://www.21vek.by/mobile/");
		LinkedHashMap<String,String> domRules = new LinkedHashMap<String,String>();
		domRules.put("Name","div[class=content__header]");
		domRules.put("Price","span[itemprop=price]");
		crawler.setDomRules(domRules);
		 /*2.x version directly support proxy randomly switching */
		 Proxys proxys = new Proxys(); 
		
		/* * Available Agents can add agents to obtain
		 * http://www.brieftools.info/proxy/ way: 1) ip and port Proxys.add
		 * ("123.123.123.123", 8080); 2) file proxys.addAllFromFile (new File
		 * ("xxx.txt")); similar to the contents of the file: 123.123.123.123:90
		 * 234.234.324.234:8080 A proxy per line*/
		 

		 crawler.setProxys(proxys); 

		/* Set whether crawling breakpoints */
		crawler.setResumable(false);

		crawler.start(3);
	}

}
