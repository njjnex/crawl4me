package by.njjnex.logic;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;

public class DomRuleConverter {
	
	private List<String> selectors = new ArrayList<String>();
	
	public Map<String, String> convertTag(Map<String, String> domRules){
		for(Entry<String, String> rule:domRules.entrySet()){
			String value =rule.getValue();
			String result = null;
			System.out.println("rule before:" + value);
			
			if (value.contains("{")){
				String selector = StringUtils.substringBetween(value, "{","}");
				selectors.add(selector);
				
				value = StringUtils.substringBefore(value, "{");
				System.out.println("value substring " + value);
			}else{
				selectors.add("0");
				System.out.println("no selectors founded " + value);
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
		
		
		return (LinkedHashMap<String, String>) domRules;
	}
}	
