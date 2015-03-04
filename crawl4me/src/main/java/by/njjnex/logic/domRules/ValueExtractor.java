package by.njjnex.logic.domRules;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;

import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.PageCrawler;
import by.njjnex.model.PageHTML;
import by.njjnex.model.ScanningResult;
import by.njjnex.service.MessageService;

public class ValueExtractor {
	
	@Autowired
	MessageService messageService;

	private PageCrawler scanningTemplate;
	private LinkedHashMap<String, String> resultPage = new LinkedHashMap<String, String>();

	public ValueExtractor(PageHTML scanningTemplate) {
		super();
		this.scanningTemplate = scanningTemplate;
	}

	public List<ScanningResult> extract(Document doc) {

		String value = null;
		String key = null;
		String selector = null;
		List<ScanningResult> resultList = new ArrayList<ScanningResult>();

		List<DomRule> domRules = scanningTemplate.getDomRules();

		for (DomRule domRule : domRules) {

			key = domRule.getKey();
			selector = domRule.getSelector();
			System.out.println("KEy " + key + " value " + domRule.getValue());

			if (!selector.equals("empty")) {
				switch (selector) {
				case "first":
					try {
						value = doc.select(domRule.getValue()).first().text();
						break;
					} catch (NullPointerException e) {
						System.out.println("No such selector");
						value = doc.select(domRule.getValue()).text();
						break;
					}
				case "last":
					try {
						value = doc.select(domRule.getValue()).last().text();
						break;
					} catch (NullPointerException e) {
						System.out.println("No such selector");
						value = doc.select(domRule.getValue()).text();
						break;
					}
				}
			} else {

				ScanningResult result;
				ArrayList<String> values;
				try {
					Elements elem = doc.select(domRule.getValue());
					int position = 0;
					result = new ScanningResult();

					values = new ArrayList<String>();

					for (Element el : elem) {
						position++;
						values.add(el.text());
						System.out.println(position + " key " + key + " value adding: " + el.text());
					}

					result.setKey(key);
					result.setValues(values);
					resultList.add(result);

				} catch (Exception e) {
					this.messageService.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
							"Switching to the next page. "));	
					e.printStackTrace();
				}
			}

		}
		return resultList;
	}
}
