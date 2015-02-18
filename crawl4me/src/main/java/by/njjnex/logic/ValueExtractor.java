package by.njjnex.logic;

import java.util.LinkedHashMap;
import java.util.LinkedHashSet;

import org.jsoup.nodes.Document;

import by.njjnex.model.DomRule;
import by.njjnex.model.Page;

public class ValueExtractor {
	
	private Page scanningTemplate;
	private LinkedHashMap<String, String> resultPage = new LinkedHashMap<String, String>();
		
	public ValueExtractor(Page scanningTemplate) {
		super();
		this.scanningTemplate = scanningTemplate;
	}

	public LinkedHashMap<String, String> extract(Document doc){
		
		String value = null;
		String key = null;
		String selector = null;
		LinkedHashSet<DomRule> domRules = (LinkedHashSet<DomRule>) scanningTemplate.getDomRules();
				
		for (DomRule domRule : domRules){
			
			key = domRule.getKey();
			selector = domRule.getSelector();
			
			if(!selector.equals("empty")){
				switch(selector){
				
					case "first": 	try{
										value = doc.select(domRule.getValue()).first().text(); break;
									}catch (NullPointerException e){
										System.out.println("No such selector");
										value = doc.select(domRule.getValue()).text(); break;
									}
					case "last":  	try{
										value = doc.select(domRule.getValue()).last().text(); break;
									}catch (NullPointerException e){
										System.out.println("No such selector");
										value = doc.select(domRule.getValue()).text(); break;
									}
				}
			}else{
				value = doc.select(domRule.getValue()).text();
			}
			
			resultPage.put(key, value);
		}
		return resultPage;
	}
}
