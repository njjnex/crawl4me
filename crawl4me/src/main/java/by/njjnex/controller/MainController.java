package by.njjnex.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import by.njjnex.collector.JSLauncher;
import by.njjnex.collector.Launcher;
import by.njjnex.logic.FileUtils;
import by.njjnex.logic.domRules.DomRuleConverter;
import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;
import by.njjnex.service.TemplateService;

@Controller
public class MainController {

	private SimpMessagingTemplate template;

	/*
	 * String saveDir = System.getenv("OPENSHIFT_DATA_DIR")+ "/" +
	 * principal.getName();
	 */
	/*private final String SAVE_DIR = "/tut/";*/
	private final String HTML_TEMPLATE_PREFIX = "z";
	private final String JS_TEMPLATE_PREFIX = "j";
	

	@Autowired
	public MainController(SimpMessagingTemplate template) {
		this.template = template;
	}

	@Autowired
	TemplateService templateService;
	
	private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");

	@RequestMapping(value = { "/", "/z{id}"})
	public String mainPage(Model model) {

		return "main";
	}
	
	@RequestMapping(value = {"/JavaScriptCrawler", "j{id}"})
	public String jsCrawler(Model model) {

		return "jsCrawler";
	}

	@RequestMapping("/howTo")
	public String howToPage(Model model) {

		return "howTo";
	}

	@RequestMapping(value = "/saveState/{id}", method = RequestMethod.POST)
	public @ResponseBody String saveTemplate(@PathVariable("id") String generatedId, @RequestBody PageJS pageCrawler, Principal principal) {
		
		String id = null;
		
		if (pageCrawler.getSearchPhrase() != null) {
			id = JS_TEMPLATE_PREFIX + generatedId;
		} else {
			id = HTML_TEMPLATE_PREFIX + generatedId;
		}
		
		pageCrawler.setId(id);
		List<DomRule> domRules = pageCrawler.getDomRules();
		pageCrawler.setDomRules(new DomRuleConverter(principal, template).replaceQuotes(domRules));
		templateService.saveTemplate(pageCrawler);

		return id;
	}

	@RequestMapping("template/z{id}")
	public @ResponseBody PageHTML getTemplate(@PathVariable("id") String generatedId, Model model) {

		String id = HTML_TEMPLATE_PREFIX + generatedId;
		System.out.println("get template with id: " + id);
	
		return templateService.getTemplate(id);
	}
	
	@RequestMapping("template/j{id}")
	public @ResponseBody PageJS getJSTemplate(@PathVariable("id") String generatedId, Model model) {

		String id = JS_TEMPLATE_PREFIX + generatedId;
		System.out.println("get template with id: " + id);
		
		return (PageJS) templateService.getTemplate(id);
	}

	@MessageMapping("/crawler")
	@SendTo("/topic/result")
	public void crawler(PageJS pageCrawler, Principal principal) throws Exception {

		String SAVE_DIR = System.getenv("OPENSHIFT_DATA_DIR")+ "/" + principal.getName();
		
		System.out.println(principal + " : " + principal.getName());
		if (principal.getName() != null) {

			DomRuleConverter converterDom = new DomRuleConverter(principal,template);
			pageCrawler.setDomRules(converterDom.replaceQuotes((pageCrawler.getDomRules())));
			pageCrawler = (PageJS) converterDom.convertTags(pageCrawler);

			if (pageCrawler.getSearchPhrase() != null) {
				JSLauncher jsLauncher = new JSLauncher(pageCrawler, principal, template, SAVE_DIR);
				jsLauncher.runCrawler();
			} else {
				Launcher crawler = new Launcher(pageCrawler, principal, template, SAVE_DIR);
				crawler.startHTMLCrawler();

				FileUtils.deleteDir(SAVE_DIR);
				this.template.convertAndSendToUser(principal.getName(), "/topic/console",
						new Output("FINISHED: " + sdf.format(new Date())));
			}
		} else {
			this.template.convertAndSend("/topic/console", new Output(
					"ERROR: Please reload crawler page and try again. " + sdf.format(new Date())));
		}
	}
}