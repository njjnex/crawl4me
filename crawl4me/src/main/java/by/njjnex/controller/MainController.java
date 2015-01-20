package by.njjnex.controller;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import by.me2.model.UserInput;
import by.njjnex.collector.Launcher;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.ListMultimap;

@Controller
public class MainController {

	private SimpMessagingTemplate template;

	@Autowired
	public MainController(SimpMessagingTemplate template) {
		this.template = template;
	}

	@RequestMapping(value = "/")
	public String mainPage(Model model) {
		return "main";
	}

	@RequestMapping("/postMessage")
	public @ResponseBody Map<String, Collection<String>> postMessage(
			@RequestParam("url") String urlToScan,
			@RequestParam("regex") String urlRegex,
			@RequestParam("domRuleName1") String domRuleName1,
			@RequestParam("domRuleName2") String domRuleName2,
			@RequestParam("domRuleValue1") String domRuleValue1,
			@RequestParam("domRuleValue2") String domRuleValue2, Model model) {

		/*
		 * System.out.println(domRuleName1 + "|" + domRuleValue1);
		 * System.out.println(domRuleName2 + "|" + domRuleValue2);
		 */

		LinkedHashMap<String, String> domRules = new LinkedHashMap<String, String>();
		domRules.put(domRuleName1, domRuleValue1);
		domRules.put(domRuleName2, domRuleValue2);

		/*
		 * Launcher crawler = new Launcher("/tutu1", urlRegex);
		 * crawler.setThreads(10); crawler.addSeed(urlToScan);
		 * crawler.setDomRules(domRules); Proxys proxys = new Proxys();
		 * crawler.setProxys(proxys); crawler.setResumable(false);
		 * 
		 * try { crawler.start(3); } catch (Exception e) { e.printStackTrace();
		 * }
		 */

		ListMultimap<String, String> result = ArrayListMultimap.create();
		/*
		 * result = crawler.getResult();
		 * 
		 * for (int i = 0; i <= (result.size() - 1) / 2; i++) { for (String key
		 * : result.keySet()) System.out.println(key + " : " +
		 * result.get(key).get(i));
		 * 
		 * }
		 */

		return result.asMap();
	}

	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public void greeting(UserInput userInput) throws Exception {
		Thread.sleep(3000); // simulated delay

		Launcher crawler = new Launcher("/tut", userInput.getRegex(), template);
		crawler.run(crawler, userInput.getUrl(), userInput.getDomRules());

	}
}
