package by.njjnex.collector;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map.Entry;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.njjnex.model.Output;
import cn.edu.hfut.dmic.webcollector.crawler.Crawler;
import cn.edu.hfut.dmic.webcollector.crawler.DeepCrawler;
import cn.edu.hfut.dmic.webcollector.fetcher.Fetcher;
import cn.edu.hfut.dmic.webcollector.model.Links;
import cn.edu.hfut.dmic.webcollector.model.Page;
import cn.edu.hfut.dmic.webcollector.net.Proxys;
import cn.edu.hfut.dmic.webcollector.util.RegexRule;

public class Launcher extends DeepCrawler {

	private final int MAXIMUM_RESULT = 10;
	private int resultCount = 0;
	private int resultFounded = 0;
	
	private Principal principal;
	private RegexRule regexRule = new RegexRule();
	private String crawlPath;
	private String urlRule;
	private SimpMessagingTemplate messagingTemplate;
	private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");

	private LinkedHashMap<String, String> resultPage = new LinkedHashMap<String, String>();
	private LinkedHashMap<String, String> resultURL = new LinkedHashMap<String, String>();

	public Launcher(String crawlPath, Principal principal, String rule,
			SimpMessagingTemplate messagingTemplate) {
		super(crawlPath);
		this.principal = principal;
		this.crawlPath = crawlPath;
		this.messagingTemplate = messagingTemplate;
		this.urlRule = rule;
		regexRule.addRule(rule); // positive rule

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
			this.messagingTemplate.convertAndSendToUser(principal.getName(),
					"/topic/console", new Output(
							"Cannot create connection: Is URL is valid?"));
			e.printStackTrace();
		}

		this.messagingTemplate.convertAndSendToUser(principal.getName(),
				"/topic/console", new Output("Found page: " + page.getUrl()
						+ " proceed..."));

		String titleText = page.getDoc().select("title").text();

		String key = null;
		String value = null;

		

		if (!titleText.isEmpty()) {
			for (Entry<String, String> domRule : domRules.entrySet()) {

				key = domRule.getKey();
				value = page.getDoc().select(domRule.getValue()).text();

				resultPage.put(key, value);
			}
			
			resultCount++;
			boolean emptyResult = true;

			if (resultCount == 0) {
				for (String resultValue : resultPage.values()) {
					if (resultValue.equals(""))
						emptyResult = true;
					}
			} else {
				for (String resultValue : resultPage.values()) {
					if (!resultValue.equals(""))
						emptyResult = false;
					}
			}
			System.out.println("page count: " + resultCount);
			System.out.println("empty? " + emptyResult);
			if (!emptyResult) {
				resultFounded++;
				this.messagingTemplate.convertAndSendToUser(
						principal.getName(), "/topic/result", resultPage);
			}

			System.out.println(key + " : " + value);
			resultPage.clear();
		}

		Links nextLinks = new Links();
		nextLinks.addAllFromDocument(doc, regexRule);

		if (resultFounded > MAXIMUM_RESULT) {
			this.messagingTemplate.convertAndSendToUser(principal.getName(),
					"/topic/console", new Output("Maximum result limit per one scan reached: " + MAXIMUM_RESULT + " stopping thread..."));
			new Fetcher().stop();
					
		}
		return nextLinks;
	}

	public void run(Crawler crawler, String urlToScan,
			LinkedHashMap<String, String> domRules) throws Exception {

		this.messagingTemplate.convertAndSendToUser(principal.getName(),
				"/topic/console",
				new Output("Started scanning: " + sdf.format(new Date())));
		crawler.addSeed(urlToScan);
		crawler.setDomRules(domRules);
		/* 2.x version directly support proxy randomly switching */
		Proxys proxys = new Proxys();
		crawler.setProxys(proxys);
		/* Set whether crawling breakpoints */
		
		crawler.setThreads(5);
		crawler.setResumable(false);

		crawler.start(3);
	}

}
