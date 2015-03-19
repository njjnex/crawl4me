package by.njjnex.logic.domRules;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.messaging.simp.SimpMessagingTemplate;

import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.PageCrawler;
import by.njjnex.model.PageHTML;
import by.njjnex.model.ScanningResult;

public class ValueExtractor {

	private PageCrawler scanningTemplate;
	private Principal principal;
	private SimpMessagingTemplate messagingTemplate;

	/*
	 * Extract data from the page according user input.
	 * 
	 * @return list of Objects, each object contains rule and extracted elements
	 * according this rule.
	 */
	public ValueExtractor(PageHTML scanningTemplate, Principal principal, SimpMessagingTemplate messagingTemplate) {
		this.scanningTemplate = scanningTemplate;
		this.principal = principal;
		this.messagingTemplate = messagingTemplate;
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
					this.messagingTemplate.convertAndSendToUser(principal.getName(), "/topic/console", new Output(
							"Cannot extract data from selector: " + domRule.getValue()
									+ ". Is selector is valid? Stopping crawler... "));
					e.printStackTrace();
				}
			}

		}
		return resultList;
	}
}
