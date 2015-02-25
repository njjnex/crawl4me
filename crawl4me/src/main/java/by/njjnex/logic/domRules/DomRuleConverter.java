package by.njjnex.logic.domRules;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.openqa.selenium.By;

import by.njjnex.model.DomRule;
import by.njjnex.model.PageCrawler;
import by.njjnex.model.PageHTML;

public class DomRuleConverter implements DomRuleConvert{
	
	
	public PageCrawler convertTags(PageCrawler page){
						
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
				
		return page;
	}
	
	public List<DomRule> replaceQuotes(List<DomRule> list){
		for(DomRule rule:list){
			String value =rule.getValue();
			String result = null;
						
			 if(value.contains("\'")){
				 result = value.replaceAll("\'", "\"");
			 	rule.setValue(result);
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
