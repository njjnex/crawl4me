package by.njjnex.logic;

import java.util.ArrayList;

import by.njjnex.model.DomRule;

public class QuotesReplacer {

	public ArrayList<DomRule> replaceQuotes(ArrayList<DomRule> domRules){
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
