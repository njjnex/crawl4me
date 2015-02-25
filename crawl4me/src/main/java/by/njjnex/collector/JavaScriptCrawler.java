package by.njjnex.collector;

import by.njjnex.logic.domRules.ValueExtractor;
import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;
import by.njjnex.model.PageLink;
import by.njjnex.model.ScanningResult;
import cn.edu.hfut.dmic.webcollector.crawler.DeepCrawler;
import cn.edu.hfut.dmic.webcollector.model.Links;
import cn.edu.hfut.dmic.webcollector.model.Page;

import com.gargoylesoftware.htmlunit.BrowserVersion;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.springframework.messaging.simp.SimpMessagingTemplate;

public class JavaScriptCrawler {

	private PageJS pageJS;
	private Principal principal;
	private List<DomRule> domRules;
	private SimpMessagingTemplate messagingTemplate;
	private List<ScanningResult> resultPage = new ArrayList<ScanningResult>();
	private int pageCount = 0;
	private int resultFounded = 0;
	
	private final String USER_AGENT = "Mozilla/5.0 (X11; Linux i686; rv:34.0) Gecko/20100101 Firefox/34.0";
	private final String REFERRER = "https://www.google.com/";
	
	public JavaScriptCrawler(PageJS pageJS, Principal principal, SimpMessagingTemplate messagingTemplate) throws Exception {
				
		this.pageJS = pageJS;
		this.principal = principal;
		this.pageJS = pageJS;
		this.domRules = pageJS.getDomRules();
		this.messagingTemplate = messagingTemplate;
	}
	

	public void crawl() throws Exception {

		WebDriver driver = new HtmlUnitDriver();
		driver.get(pageJS.getUrl());

		// Find the text input element by its name
		WebElement elementSearch = driver.findElement(By.id("gh-ac"));

		// Enter something to search for
		elementSearch.sendKeys(pageJS.getSearchPhrase());

		// Now submit the form. WebDriver will find the form for us from the
		// element
		elementSearch.submit();
		if(!driver.getTitle().isEmpty()){
			pageCount++;
			this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Found page: "
					+ driver.getCurrentUrl() + " proceed..."));
			System.out.println(driver.getCurrentUrl() + " proceed");
			Document doc = new Document(driver.getCurrentUrl());
			String titleText = null;
			
			doc.html(driver.getPageSource());
			titleText = doc.select("title").text();
			resultPage = new ValueExtractor(pageJS).extract(doc);
			
			boolean emptyResult = true;

			if (pageCount == 0) {
				for (ScanningResult resultValue : resultPage) {
					if (resultValue.getValues().equals(""))
						emptyResult = true;
					System.out.println("empty? " + emptyResult);
				}
			} else {
				emptyResult = false;
				System.out.println("page count: " + pageCount);
				System.out.println("empty? " + emptyResult);
				if (!emptyResult) {
					resultFounded++;
					this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/result", resultPage);
				}

				resultPage.clear();
			}
			
			
		}else{
			this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
					"ERROR: Cannot create connection...."));
			System.out.println("Error proceed");
		}
		
			
		
		// Check the title of the page
		System.out.println("Page title is: " + driver.getTitle());
		System.out.println("Page url is: " + driver.getCurrentUrl());

		List<WebElement> divInfos = driver.findElements(By.cssSelector(".lvtitle"));
		int i = 0;
		for (WebElement divInfo : divInfos) {
			i++;
			System.out.println(i + " : " + divInfo.getText());
		}

		/*
		 * driver.findElement(By.linkText("2")).click();
		 * 
		 * // Check the title of the page System.out.println("Page 2 title is: "
		 * + driver.getTitle());
		 * 
		 * System.out.println("Page 2 url is: " + driver.getCurrentUrl());
		 * 
		 * divInfos=driver.findElements(By.cssSelector(".lvtitle"));
		 * for(WebElement divInfo:divInfos){ i++; System.out.println(i + " : " +
		 * divInfo.getText()); }
		 * 
		 * driver.findElement(By.linkText("3")).click();
		 * 
		 * // Check the title of the page System.out.println("Page 3 title is: "
		 * + driver.getTitle());
		 * 
		 * System.out.println("Page 3 url is: " + driver.getCurrentUrl());
		 * 
		 * divInfos=driver.findElements(By.cssSelector(".lvtitle"));
		 * for(WebElement divInfo:divInfos){ i++; System.out.println(i + " : " +
		 * divInfo.getText()); }
		 */

		driver.quit();
	}
}
