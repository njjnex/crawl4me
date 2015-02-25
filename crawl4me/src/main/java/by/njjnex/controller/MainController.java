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
import by.njjnex.collector.JavaScriptCrawler;
import by.njjnex.collector.Launcher;
import by.njjnex.logic.FileUtils;
import by.njjnex.logic.domRules.DomRuleConverter;
import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.PageCrawler;
import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;
import by.njjnex.service.MessageService;
import by.njjnex.service.TemplateService;

@Controller
public class MainController {

	private SimpMessagingTemplate template;

	/*
	 * String saveDir = System.getenv("OPENSHIFT_DATA_DIR")+ "/" +
	 * principal.getName();
	 */
	private final String SAVE_DIR = "/tut/";

	@Autowired
	public MainController(SimpMessagingTemplate template) {
		this.template = template;
	}

	@Autowired
	TemplateService templateService;

	@Autowired
	MessageService messageService;

	private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");

	@RequestMapping(value = { "/", "/s{id}" })
	public String mainPage(Model model) {

		return "main";
	}

	@RequestMapping("/login")
	public String loginPage(Model model) {

		return "loginForm";
	}

	@RequestMapping("/howTo")
	public String howToPage(Model model) {

		return "howTo";
	}

	@RequestMapping(value = "/saveState/{id}", method = RequestMethod.POST)
	public @ResponseBody String saveTemplate(@PathVariable("id") String generatedId,
			@RequestBody PageHTML scanningTemplate) {

		List<DomRule> domRules = scanningTemplate.getDomRules();
		System.out.println(scanningTemplate.getLinks().size());
		scanningTemplate.setId("s" + generatedId);
		scanningTemplate.setDomRules(new DomRuleConverter().replaceQuotes(domRules));

		templateService.saveTemplate(scanningTemplate);

		return generatedId;
	}

	@RequestMapping("template/s{id}")
	public @ResponseBody PageHTML getTemplate(@PathVariable("id") String generatedId, Model model) {

		String id = "s" + generatedId;
		System.out.println("get template with id: " + id);
		PageHTML template = templateService.getTemplate(id);

		return template;
	}

	@RequestMapping("/JavaScriptCrawler")
	public String jsCrawler(Model model) {

		return "jsCrawler";
	}

	@MessageMapping("/crawler")
	@SendTo("/topic/result")
	public void greeting(PageJS pageCrawler, Principal principal) throws Exception {

		
			System.out.println(principal + " : " + principal.getName());
			if (principal.getName() != null) {

				DomRuleConverter converterDom = new DomRuleConverter();
				pageCrawler.setDomRules(converterDom.replaceQuotes((pageCrawler.getDomRules())));
				pageCrawler = (PageJS) converterDom.convertTags(pageCrawler);
				
				
				if (pageCrawler.getSearchPhrase() != null) {
					System.out.println("PAGEJS");
					/*JavaScriptCrawler jsCrawler = new JavaScriptCrawler(pageCrawler, principal, template);
					jsCrawler.crawl();*/
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