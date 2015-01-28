package by.njjnex.logic;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

public class DomRuleConverter {
	
	public Map<String, String> convertTag(Map<String, String> domRules){
		for(Entry<String, String> rule:domRules.entrySet()){
			String value =rule.getValue();
			String result = null;
			System.out.println("rule before:" + value);
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
			 }else{
				System.out.println("Rule should be a tag wich starts with /'</' and ends with /'>/'"); 
			 }
		}
		return (LinkedHashMap<String, String>) domRules;
	}
	public String extractSelector(Map<String, String> domRules){
		for(Entry<String, String> rule:domRules.entrySet()){
			String value =rule.getValue();
	
		}
		return null;
	}
}	
