package by.njjnex.collector;

import java.security.Principal;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.njjnex.model.Output;
import by.njjnex.model.PageJS;

public class JSLauncher {

	private PageJS pageJS;
	private Principal principal;
	private SimpMessagingTemplate messageTemplate;
	private String path;

	public JSLauncher(PageJS pageCrawler, Principal principal, SimpMessagingTemplate template, String sAVE_DIR) {
		this.pageJS = pageCrawler;
		this.principal = principal;
		this.messageTemplate = template;
		this.path = sAVE_DIR;

	}

	public void runCrawler() throws Exception {

		WebDriver driver = new HtmlUnitDriver();
		driver.get(pageJS.getUrl());

		WebElement elementSearch = null;
		WebElement elementSubmit = null;

		/*
		 * Trying to auto detect search field in the page by searching <form>
		 * tag. Then in the <form> tag looking for <input type="text"> by
		 * checking all children elements.
		 */
		List<WebElement> allFormChildElements = driver.findElements(By.xpath("//form//*"));
		System.out.println("founded form: " + allFormChildElements.size());
		for (WebElement item : allFormChildElements) {

			if (item.getTagName().equals("input")) {

				if (item.getAttribute("type").equals("text")) {
					elementSearch = item;
					System.out.println("fount text input");
					break;
				}

				if (item.getAttribute("type").equals("submit")) {
					elementSubmit = item;
				}
			}
		}
		if (elementSearch != null) {
			this.messageTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
					"Search field detected " + elementSearch.getTagName() + " . Inserting search text."));

			elementSearch.sendKeys(pageJS.getSearchPhrase()); // send text to
																// search

			if ((pageJS.getUrl() + "/").equals(driver.getCurrentUrl()))
				elementSearch.submit();

			if ((pageJS.getUrl() + "/").equals(driver.getCurrentUrl())) {
				if (elementSubmit != null) {
					elementSubmit.click();
				}
			}

			System.out.println("Get page " + driver.getCurrentUrl());

			if (!(pageJS.getUrl() + "/").equals(driver.getCurrentUrl())) {
				pageJS.setUrl(driver.getCurrentUrl()); // send result page to
														// the
														// Launcher
				Launcher launcherJS = new Launcher(pageJS, principal, messageTemplate, path, driver);
				launcherJS.startJSCrawler();
			} else {
				this.messageTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
						"ERROR: Cannot receive dynamic page... "));
			}
		} else {
			this.messageTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
					"Cannot detect search field on this page... "));
		}

		driver.quit();

	}

}
