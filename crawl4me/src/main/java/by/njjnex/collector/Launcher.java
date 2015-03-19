package by.njjnex.collector;

import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.njjnex.logic.domRules.DomRuleConverter;
import by.njjnex.logic.domRules.ValueExtractor;
import by.njjnex.model.Output;
import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;
import by.njjnex.model.PageLink;
import by.njjnex.model.ScanningResult;
import cn.edu.hfut.dmic.webcollector.crawler.DeepCrawler;
import cn.edu.hfut.dmic.webcollector.model.Links;
import cn.edu.hfut.dmic.webcollector.util.RegexRule;

public class Launcher extends DeepCrawler {

	private final int MAXIMUM_RESULT = 195; // MAXIMUM_RESULT + THREADS =
											// maximum result per one scan
	private final int THREADS = 5;
	private final int SCANNING_DEEP = 3;

	private final String USER_AGENT = "Mozilla/5.0 (X11; Linux i686; rv:34.0) Gecko/20100101 Firefox/34.0";
	private final String REFERRER = "https://www.google.com/";

	private int pageCount = 0;
	private int resultFounded = 0;
	private int resultLines = 0;
	private boolean maximumReached = false;

	private RegexRule regexRule = new RegexRule();
	private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");

	private Principal principal;
	private SimpMessagingTemplate messagingTemplate;
	private List<ScanningResult> resultPage = new ArrayList<ScanningResult>();
	private PageHTML scanningTemplate;
	private String paginatorRule;
	private WebDriver driver = new HtmlUnitDriver();

	/* Default HTML launcher constructor */
	public Launcher(PageHTML scanningTemplate, Principal principal, SimpMessagingTemplate messagingTemplate,
			String crawlPath) throws Exception {
		super(crawlPath);
		this.scanningTemplate = scanningTemplate;
		this.principal = principal;
		this.messagingTemplate = messagingTemplate;

		for (PageLink rule : scanningTemplate.getLinks()) {
			if (rule.isIncluded()) {
				regexRule.addRule(rule.getLinkHref());
			}
		}
	}

	/* Java Script launcher constructor */
	public Launcher(PageJS pageJS, Principal principal, SimpMessagingTemplate messageTemplate, String path,
			WebDriver driver) throws Exception {
		super(path);
		this.scanningTemplate = pageJS;
		this.principal = principal;
		this.messagingTemplate = messageTemplate;
		this.driver = driver;

		for (PageLink rule : scanningTemplate.getLinks()) {
			if (rule.isIncluded()) {
				if (rule.getLinkHref().startsWith("<")) {
					paginatorRule = new DomRuleConverter(principal, messageTemplate).xPathConverter(rule.getLinkHref());
				}
			}
		}
	}

	public Links visitAndGetNextLinks(cn.edu.hfut.dmic.webcollector.model.Page page) {

		Document doc = null;
		String titleText = null;

		if (!page.getHtml().isEmpty()) {
			doc = page.getDoc();
		} else {
			try {
				doc = Jsoup.connect(page.getUrl()).userAgent(USER_AGENT).referrer(REFERRER).get();
				titleText = doc.select("title").text();
				System.out.println("JSOP connect");
			} catch (IOException e) {
				this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
						"ERROR: Cannot create connection...."));
				e.printStackTrace();
			}
		}

		this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Found page: "
				+ page.getUrl() + " proceed..."));

		titleText = doc.select("title").text();

		if (!titleText.isEmpty()) {
			resultPage = new ValueExtractor(scanningTemplate, principal, messagingTemplate).extract(doc);
			pageCount++;
			resultLines = resultLines + resultPage.size();
		}

		boolean emptyResult = true;

		if (pageCount == 0) {
			for (ScanningResult resultValue : resultPage) {

				if (resultValue.getValues().equals(""))
					emptyResult = true;
				}
		} else {
			emptyResult = false;

			
			
			System.out.println("page count: " + pageCount);
			System.out.println("empty? " + emptyResult);
			System.out.println("resultLines " + resultLines);
			if (!emptyResult) {
				resultFounded++;
				this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/result", resultPage);
			}

			resultPage.clear();
		}

		Links nextLinks = new Links();

		if (paginatorRule != null) {

			nextLinks.add(paginator(driver));
			this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
					"Switching to the next page. "));
		} else
			nextLinks.addAllFromDocument(doc, regexRule);

		if (resultFounded > MAXIMUM_RESULT || pageCount > 200 || resultLines > 200)
			maximumReached = true;

		if (maximumReached) {
			this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
					"Maximum result limit per one scan REACHED: " + " stopping threads..."));

			super.stop();
		}
		return nextLinks;
	}

	public void startHTMLCrawler() throws Exception {
		this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
				"Started scanning: " + sdf.format(new Date())));

		this.addSeed(scanningTemplate.getUrl());
		this.setThreads(THREADS);
		this.setResumable(false);
		this.start(SCANNING_DEEP);

	}

	public void startJSCrawler() throws Exception {
		this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
				"Started scanning: " + sdf.format(new Date())));

		this.addSeed(scanningTemplate.getUrl());
		this.setThreads(THREADS);
		this.setResumable(false);
		this.start(5);

	}

	/*
	 * Pagination for Java Script crawler - switch to next page after scan this.
	 */
	private String paginator(WebDriver driverPage) {

		driverPage.findElement(By.xpath(paginatorRule)).click();
		String nextPage = driverPage.getCurrentUrl();
		System.out.println("switch to page : " + driverPage.getCurrentUrl());

		return nextPage;
	}

}
