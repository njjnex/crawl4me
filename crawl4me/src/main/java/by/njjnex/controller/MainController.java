package by.njjnex.controller;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.ListMultimap;

import by.njjnex.collector.Launcher;
import cn.edu.hfut.dmic.webcollector.net.Proxys;

@Controller
public class MainController {

	@RequestMapping(value = "/")
	public String mainPage(Model model) {
		return "main";
	}

	@RequestMapping("/postMessage")
	public @ResponseBody ListMultimap<String, String> postMessage(@RequestParam("url") String urlToScan,
			@RequestParam("regex") String urlRegex,
			@RequestParam("domRuleName1") String domRuleName1,
			@RequestParam("domRuleName2") String domRuleName2,
			@RequestParam("domRuleValue1") String domRuleValue1,
			@RequestParam("domRuleValue2") String domRuleValue2,
			Model model
			) {

		System.out.println(domRuleName1 + "|" + domRuleValue1);
		System.out.println(domRuleName2 + "|" + domRuleValue2);
		
		
		LinkedHashMap<String, String> domRules = new LinkedHashMap<String, String>();
		domRules.put(domRuleName1,domRuleValue1);
		domRules.put(domRuleName2,domRuleValue2);
		
		Launcher crawler = new Launcher("/tutu1", urlRegex);
		crawler.setThreads(10);
		crawler.addSeed(urlToScan);
		crawler.setDomRules(domRules);
		Proxys proxys = new Proxys();
		crawler.setProxys(proxys);
		crawler.setResumable(false);
		
		try {
			crawler.start(3);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ListMultimap<String, String> result = ArrayListMultimap.create();
			result = crawler.getResult();
			
			System.out.println("Found: " +result.size());
			for(String value: result.values()){
				System.out.println("All values" + value);
			}
			
			
			Map<String, Collection<String>> mapresult = result.asMap();
			for(Entry entry: mapresult.entrySet()){
				System.out.println("As map key: " +entry.getKey());
				System.out.println("As map value: " +entry.getValue());
			}
			
			for(String key: result.keySet())
				System.out.println("Key results : key - " + key+" result " + result.get(key));
			
			
		return result;
	}

}
