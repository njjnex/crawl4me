package by.njjnex.logic;

import java.util.ArrayList;
import java.util.LinkedHashMap;

import org.jsoup.nodes.Document;

import by.njjnex.model.DomRule;
import by.njjnex.model.ScanningTemplate;

public class ValueExtractor {
	
	private ScanningTemplate scanningTemplate;
	private LinkedHashMap<String, String> resultPage = new LinkedHashMap<String, String>();
		
	public ValueExtractor(ScanningTemplate scanningTemplate) {
		super();
		this.scanningTemplate = scanningTemplate;
	}

	public LinkedHashMap<String, String> extract(Document doc){
		
		int domRuleNumber = 0;
		String value = null;
		String key = null;
		String selector = null;
		ArrayList<DomRule> domRules = (ArrayList<DomRule>) scanningTemplate.getDomRules();
		ArrayList<String> selectors = scanningTemplate.getSelectors();
		
		for (DomRule domRule : domRules){
			
			key = domRule.getKey();
			selector = selectors.get(domRuleNumber);
			
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
			domRuleNumber++;
		}
		return resultPage;
	}
}
