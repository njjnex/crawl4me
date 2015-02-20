package by.njjnex.logic.domRules;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.jsoup.nodes.Attribute;
import org.jsoup.nodes.Attributes;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import by.njjnex.logic.CountArrayList;
import by.njjnex.model.DomRule;


public class DomRulesHandler {

	public List<DomRule> setTemplateRules(){
		
		List<DomRule> domRules = new ArrayList<DomRule>();
		
		DomRule domRule = new DomRule();
		domRule.setRuleNumber(1);
		domRule.setKey("Name");
		domRule.setValue("<div class=\"rubrika\">");
		domRule.setSelector("Placed first tag");
		domRules.add(domRule);
		
		DomRule domRule1 = new DomRule();
		domRule1.setRuleNumber(2);
		domRule1.setKey("Price");
		domRule1.setValue("<div class=\"zagol\">");
		domRule1.setSelector("Placed last tag");
		domRules.add(domRule1);
		
		return domRules;
	}
	
	public Set<DomRule> autodetectRules(Document doc){
		CountArrayList<String> countList = new CountArrayList<String>();
		Map<String, Integer> elementsMap = new HashMap<String, Integer>();
		Elements elements =	doc.select("a[href]");
		for(Element el: elements){
			
			
			System.out.println("own text " + el.ownText());
			System.out.println("el data  " + el.data());
			System.out.println("el html  " + el.html());
			System.out.println("el outer html  " + el.outerHtml());
			System.out.println("el value  " + el.val());
			System.out.println("el outer html  " + el.attributes());
			Attributes attrub = el.attributes();
			for(Attribute att: attrub){
				System.out.println("attr! " + att);
				System.out.println(" key 1 " +att.getKey());
				System.out.println(" value 1 " + att.getValue());
				System.out.println("result " + att.getKey() + att.getValue());
				countList.add(att.getKey() + "=\"" + att.getValue() + "\"" );
				
			}
		}
				elementsMap = countList.createCountMap();
				
				Map.Entry<String, Integer> maxEntry = null;
				for (Entry entry: elementsMap.entrySet()){
					if (maxEntry == null || ((Integer) entry.getValue()).compareTo(maxEntry.getValue()) > 0)
				    {
				        maxEntry = entry;
				        System.out.println("times: " + entry.getValue() + " value: " + entry.getKey());

				    }
					
					
				}
				System.											out.println(maxEntry.getKey());
		
		return null;
	}
}
