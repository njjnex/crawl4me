package by.njjnex.logic.domRules;

import java.util.ArrayList;
import java.util.List;

import by.njjnex.model.DomRule;


public class DomRulesHandler {

	public List<DomRule> setTemplateRules(){
		
		List<DomRule> domRules = new ArrayList<DomRule>();
		
		DomRule domRule = new DomRule();
		domRule.setRuleNumber(1);
		domRule.setKey("Name");
		domRule.setValue("<a class=\"prod-name\">");
		domRule.setSelector("Placed first tag");
		domRules.add(domRule);
		
		DomRule domRule1 = new DomRule();
		domRule1.setRuleNumber(2);
		domRule1.setKey("Price");
		domRule1.setValue("<div class=\"prod-price\">");
		domRule1.setSelector("Placed last tag");
		domRules.add(domRule1);
		
		return domRules;
	}
	
	public List<DomRule> setTemplateJSRules() {
		
List<DomRule> domRules = new ArrayList<DomRule>();
		
		DomRule domRule = new DomRule();
		domRule.setRuleNumber(1);
		domRule.setKey("Name");
		domRule.setValue("<h3 class=\"lvtitle\">");
		domRule.setSelector("Placed first tag");
		domRules.add(domRule);
		
		DomRule domRule1 = new DomRule();
		domRule1.setRuleNumber(2);
		domRule1.setKey("Price");
		domRule1.setValue("<ul class=\"lvprices left space-zero\">");
		domRule1.setSelector("Placed last tag");
		domRules.add(domRule1);
		
		return domRules;
		
	}
}
