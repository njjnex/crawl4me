package by.njjnex.logic.domRules;

import java.security.Principal;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.PageCrawler;
/*
 * Converting user input rules for element extraction
 * according CSS or xPAth rules. You can find more at jsop.org
 */
public class DomRuleConverter implements DomRuleConvert{
	
	private Principal principal;
	private SimpMessagingTemplate messagingTemplate;
	
	
	public DomRuleConverter(Principal principal, SimpMessagingTemplate messagingTemplate) {
		super();
		this.principal = principal;
		this.messagingTemplate = messagingTemplate;
	}

	public PageCrawler convertTags(PageCrawler page){
						
		try {
			for(DomRule rule: page.getDomRules()){
				String value = rule.getValue();
				String result = null;
						
				System.out.println("rule before:" + value);
				
				value = value.trim();
				
				if (value.contains("{")){
					String selector = StringUtils.substringBetween(value, "{","}");
					value = StringUtils.substringBefore(value, "{");
					rule.setSelector(selector);
					System.out.println("Selector extracted: " + selector);
				}else{
					rule.setSelector("empty");
					System.out.println("No selectors founded " + value);
				}
					
				 if(value.startsWith("<") && value.endsWith(">")){
					 result = value.replaceFirst(" ", "[");
					 result = result.replaceFirst("<", "");
					 if(result.contains("=")){
						 result = result.replaceAll(">", "]");
					 }else{
						 result = result.replaceAll(">", "");
					 }
					 
					 result = result.replaceAll("\"", "");
					 rule.setValue(result);
					 System.out.println("rule after:" + result);
				 }
				 
			}
		} catch (Exception e) {
			this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
					"Empty selector. Please enter correct rule for extract data! STOPPING CRAWLER... "));	
			e.printStackTrace();
			
		}
				
		return page;
	}
	
	public List<DomRule> replaceQuotes(List<DomRule> list){
		for(DomRule rule:list){
			try {
				String value =rule.getValue();
				String result = null;
							
				 if(value.contains("\'")){
					 result = value.replaceAll("\'", "\"");
				 	rule.setValue(result);
				 }
			} catch (NullPointerException e) {
				this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
						"Empty selector. Please enter correct rule for extract data! STOPPING CRAWLER... "));	
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public String xPathConverter(String href){
		
		System.out.println("before xPath: " + href);
		
		href = href.replace("<", "//");
		href = href.replaceFirst(" ", "[@");
		href = href.replace(">", "]");
		
		System.out.println("after xPath: " + href);
		
		return href;
	}

}	
