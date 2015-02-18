package by.njjnex.logic;

import org.apache.commons.lang3.StringUtils;

import by.njjnex.model.DomRule;
import by.njjnex.model.Page;

public class DomRuleConverter {
	
	
	public Page convertTags(Page page){
						
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

}	
