package by.njjnex.collector;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map.Entry;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.me2.model.Output;
import cn.edu.hfut.dmic.webcollector.crawler.Crawler;
import cn.edu.hfut.dmic.webcollector.crawler.DeepCrawler;
import cn.edu.hfut.dmic.webcollector.model.Links;
import cn.edu.hfut.dmic.webcollector.model.Page;
import cn.edu.hfut.dmic.webcollector.net.Proxys;
import cn.edu.hfut.dmic.webcollector.util.RegexRule;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.ListMultimap;

public class Launcher extends DeepCrawler {

	RegexRule regexRule = new RegexRule();
	String crawlPath;
	private String urlRule;
	private SimpMessagingTemplate messagingTemplate;

	LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();

	public LinkedHashMap<String, String> getResult() {
		return result;
	}

	public void setResult(LinkedHashMap<String, String> result) {
		this.result = result;
	}

	public Launcher(String crawlPath, String rule,
			SimpMessagingTemplate messagingTemplate) {
		super(crawlPath);
		this.crawlPath = crawlPath;
		this.messagingTemplate = messagingTemplate;
		this.urlRule = rule;
		regexRule.addRule("^" + rule + "$"); // positive rule
	}

	public Links visitAndGetNextLinks(Page page,
			LinkedHashMap<String, String> domRules) {
		
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
		
		String details = page.getDoc().select("h1[class=primary-heading]")
				.text();
		System.out.println("URL:" + page.getUrl() + " Title: " + title);
		System.out.println("Details: " + details);
				
		String key = null;
		String value = null;
		
		if (!details.isEmpty()) {
			for (Entry<String, String> domRule : domRules.entrySet()) {

				key = domRule.getKey();
				value = page.getDoc().select(domRule.getValue()).text();

				System.out.println("***********dom : " + key + " : " + value);
				result.put(key, value);
			}
			this.messagingTemplate.convertAndSend("/topic/greetings", result);

			System.out.println(key + " : " + value);
			result.clear();
		}

		Links nextLinks = new Links();
		nextLinks.addAllFromDocument(doc, regexRule);

		return nextLinks;
	}

	public void run(Crawler crawler, String urlToScan,
			LinkedHashMap<String, String> domRules) throws Exception {

		crawler.addSeed(urlToScan);
		crawler.setDomRules(domRules);
		/* 2.x version directly support proxy randomly switching */
		Proxys proxys = new Proxys();
		crawler.setProxys(proxys);
		/* Set whether crawling breakpoints */

		crawler.setResumable(false);

		crawler.start(3);
	}

}
