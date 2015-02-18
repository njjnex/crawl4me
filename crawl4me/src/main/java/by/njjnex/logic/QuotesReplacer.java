package by.njjnex.logic;

import java.util.Set;

import by.njjnex.model.DomRule;

public class QuotesReplacer {

	public Set<DomRule> replaceQuotes(Set<DomRule> domRules){
		for(DomRule rule:domRules){
			String value =rule.getValue();
			String result = null;
						
			 if(value.contains("\'")){
				 result = value.replaceAll("\'", "\"");
			 	rule.setValue(result);
			 }
		}
		return domRules;
	}
}
