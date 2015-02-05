package by.njjnex.logic;

import java.util.ArrayList;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;

import by.njjnex.model.ScanningTemplate;

public class DomRuleConverter {
	
	
	public ScanningTemplate convertTags(ScanningTemplate scanningTemplate){
		
		ArrayList<String> selectors = new ArrayList<String>();
		
		for(Entry<String, String> rule: scanningTemplate.getDomRules().entrySet()){
			String value = rule.getValue();
			String result = null;
					
			System.out.println("rule before:" + value);
			
			if (value.contains("{")){
				String selector = StringUtils.substringBetween(value, "{","}");
				value = StringUtils.substringBefore(value, "{");
				selectors.add(selector);
				System.out.println("Selector extracted: " + selector);
			}else{
				selectors.add("empty");
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
		scanningTemplate.setSelectors(selectors);
		
		return scanningTemplate;
	}

}	
