package by.njjnex.logic;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

public class QuotesReplacer {

	public Map<String, String> replaceQuotes(Map<String, String> domRules){
		for(Entry<String, String> rule:domRules.entrySet()){
			String value =rule.getValue();
			String result = null;
						
			 if(value.contains("\'")){
				 result = value.replaceAll("\'", "\"");
			 	rule.setValue(result);
			 }
		}
		return (LinkedHashMap<String, String>) domRules;
	}
}
