package by.njjnex.collector;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.njjnex.logic.ValueExtractor;
import by.njjnex.model.Output;
import by.njjnex.model.ScanningTemplate;
import cn.edu.hfut.dmic.webcollector.crawler.Crawler;
import cn.edu.hfut.dmic.webcollector.crawler.DeepCrawler;
import cn.edu.hfut.dmic.webcollector.model.Links;
import cn.edu.hfut.dmic.webcollector.model.Page;
import cn.edu.hfut.dmic.webcollector.util.RegexRule;

public class Launcher extends DeepCrawler{

	private final int MAXIMUM_RESULT = 45;
	private final int THREADS = 5;
	private final int SCANNING_DEEP = 3;
	
	private final String USER_AGENT = "Mozilla/5.0 (X11; Linux i686; rv:34.0) Gecko/20100101 Firefox/34.0";
	private final String REFERRER = "https://www.google.com/";
	
	private int resultCount = 0;
	private int resultFounded = 0;
	private boolean maximumReached = false;
		
	private RegexRule regexRule = new RegexRule();
	private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
	
	private Principal principal;
	private SimpMessagingTemplate messagingTemplate;
	private LinkedHashMap<String, String> resultPage = new LinkedHashMap<String, String>();
	private LinkedHashMap<String, String> domRules;
	private ScanningTemplate scanningTemplate;
	
	
	public Launcher(ScanningTemplate scanningTemplate, Principal principal, SimpMessagingTemplate messagingTemplate, String crawlPath) throws Exception{
		super(crawlPath);
		this.scanningTemplate = scanningTemplate;
		this.principal = principal;
		this.messagingTemplate = messagingTemplate;
		this.domRules = (LinkedHashMap<String, String>) scanningTemplate.getDomRules();
		regexRule.addRule(scanningTemplate.getRegex()); // positive rule
		
		settingCrawler(this, scanningTemplate.getUrl(), (LinkedHashMap<String, String>) domRules );
	}

	
	public Links visitAndGetNextLinks(Page page) {

		Document doc = null;

		try {
			doc = Jsoup.connect(page.getUrl()).userAgent(USER_AGENT).referrer(REFERRER).get();
		} catch (IOException e) {
			this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Cannot create connection...."));
			e.printStackTrace();
		}

		this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Found page: " + page.getUrl() + " proceed..."));

		String titleText = doc.select("title").text();
						
		if (!titleText.isEmpty()){
			resultPage = new ValueExtractor(scanningTemplate).extract(doc);
			resultCount++;
		}
			
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
			
			System.out.println("page count: " + resultCount);
			System.out.println("empty? " + emptyResult);
			if (!emptyResult) {
				resultFounded++;
				this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/result", resultPage);
			}
	
			resultPage.clear();
		}

		Links nextLinks = new Links();
		nextLinks.addAllFromDocument(doc, regexRule);

		if (resultFounded > MAXIMUM_RESULT) maximumReached = true;
		
		
		if(maximumReached){
			this.messagingTemplate.convertAndSendToUser(principal.getName(),
					"/topic/console", new Output("Maximum result limit per one scan REACHED: " + String.valueOf(MAXIMUM_RESULT+THREADS) + " stopping threads..."));
			
			super.stop();
		}
		return nextLinks;
	}

	public void settingCrawler(Crawler userCrawler, String urlToScan, LinkedHashMap<String, String> domRules) throws Exception {
		this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Started scanning: " + sdf.format(new Date())));
		userCrawler.addSeed(urlToScan);
		userCrawler.setThreads(THREADS);
		userCrawler.setResumable(false);
		userCrawler.start(SCANNING_DEEP);
		
	}
	
}
