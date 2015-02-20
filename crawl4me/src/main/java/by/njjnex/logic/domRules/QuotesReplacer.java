package by.njjnex.logic.domRules;

import java.util.List;

import by.njjnex.model.DomRule;

public class QuotesReplacer {

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
}
