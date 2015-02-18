package by.njjnex.logic;

import java.util.LinkedHashSet;
import java.util.Set;

import by.njjnex.model.DomRule;


public class DomRulesHandler {

	public Set<DomRule> setTemplateRules(){
		
		Set<DomRule> domRules = new LinkedHashSet<DomRule>();
		
		DomRule domRule = new DomRule();
		domRule.setRuleNumber(1);
		domRule.setKey("Name");
		domRule.setValue("<div id=\"name\">");
		domRule.setSelector("Placed first tag");
		domRules.add(domRule);
		
		DomRule domRule1 = new DomRule();
		domRule1.setRuleNumber(2);
		domRule1.setKey("Price");
		domRule1.setValue("<div id=\"price\">");
		domRule1.setSelector("Placed last tag");
		domRules.add(domRule1);
		
		return domRules;
	}
}
