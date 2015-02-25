package by.njjnex.collector;

import java.security.Principal;
import java.util.List;

import org.jsoup.nodes.Document;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import cn.edu.hfut.dmic.webcollector.model.Page;
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


	public void runCrawler() throws Exception{
		
		WebDriver driver = new HtmlUnitDriver();
		
		driver.get(pageJS.getUrl());

		// Find the text input element by its name
		/*WebElement elementSearch = driver.findElement(By.id("gh-ac"));*/
		WebElement elementSearch = null;
		
		//Autodetect search field 
		List<WebElement> allFormChildElements = driver.findElements(By.xpath("//form//*"));
		System.out.println("founded form: " +allFormChildElements.size());
			for(WebElement item : allFormChildElements ){
				System.out.println("Item " + item.getTagName());
				
			    if(item.getTagName().equals("input")) {
			    	System.out.println("Found input " + item.getAttribute("type") + " attr ");
			    	
			        if(item.getAttribute("type").equals("text")) {
			        	elementSearch = item;
			        	
			            
			            System.out.println("fount text input");
			        }
			    }   
			}
		if(elementSearch != null){
			this.messageTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Search field detected "
    				+ elementSearch.getTagName() + " . Inserting search text."));
		}else{
			this.messageTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output("Canot detect search field on this page... "
    				));
		}

		// Enter something to search for
		elementSearch.sendKeys(pageJS.getSearchPhrase());

		// Now submit the form. WebDriver will find the form for us from the
		// element
		elementSearch.submit();
		
		pageJS.setUrl(driver.getCurrentUrl());
		Launcher launcherJS = new Launcher(pageJS, principal, messageTemplate, path, driver);
		launcherJS.startJSCrawler();
		
		
		
		
	}
	
}
