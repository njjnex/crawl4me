package by.njjnex.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

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

import by.njjnex.collector.Launcher;
import by.njjnex.logic.DomRuleConverter;
import by.njjnex.logic.FileUtils;
import by.njjnex.logic.QuotesReplacer;
import by.njjnex.model.DomRule;
import by.njjnex.model.Output;
import by.njjnex.model.Page;
import by.njjnex.model.ScanningTemplate;
import by.njjnex.service.MessageService;
import by.njjnex.service.TemplateService;

@Controller
public class MainController {

	private SimpMessagingTemplate template;

	@Autowired
	public MainController(SimpMessagingTemplate template) {
		this.template = template;
	}

	@Autowired
	TemplateService templateService;

	@Autowired
	MessageService messageService;

	private SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");

	@RequestMapping("/")
	public String mainPage(Model model) {

		ScanningTemplate defaultScanningTemplate = new ScanningTemplate();

		ArrayList<DomRule> domRules = (ArrayList<DomRule>) defaultScanningTemplate.getDomRules();
		DomRule domRule1 = new DomRule();
		DomRule domRule2 = new DomRule();
		domRule1.setKey("Product");
		domRule1.setValue("<span id=\"vi-lkhdr-itmTitl\">");

		domRule2.setKey("Price");
		domRule2.setValue("<span id=\"prcIsum\">");

		domRules.add(domRule1);
		domRules.add(domRule2);

		defaultScanningTemplate.setDomRules(domRules);

		model.addAttribute("template", defaultScanningTemplate);
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
			@RequestBody Page scanningTemplate) {

		Set<DomRule> domRules = scanningTemplate.getDomRules();
		scanningTemplate.setId("s" + generatedId);
		scanningTemplate.setDomRules(new QuotesReplacer().replaceQuotes(domRules));
		
		templateService.saveTemplate(scanningTemplate);

		return generatedId;
	}

	@RequestMapping("/s{id}")
	public String getTemplate(@PathVariable("id") String generatedId, Model model) {

		String id = "s" + generatedId;
		System.out.println("get template with id: " + id);
		ScanningTemplate template = templateService.getTemplate(id);

		model.addAttribute("template", template);

		return "main";
	}

	@MessageMapping("/crawler")
	@SendTo("/topic/result")
	public void greeting(Page userInput, Principal principal) throws Exception {

		System.out.println(principal + " : " + principal.getName());
		if (principal.getName() != null) {

			DomRuleConverter converterDom = new DomRuleConverter();
			QuotesReplacer replacerQuote = new QuotesReplacer();
			userInput.setDomRules(replacerQuote.replaceQuotes((userInput.getDomRules())));

			userInput = converterDom.convertTags(userInput);

			/*
			 * String saveDir = System.getenv("OPENSHIFT_DATA_DIR")+ "/" +
			 * principal.getName();
			 */
			String saveDir = "/tut/";

			Launcher crawler = new Launcher(userInput, principal, template, saveDir);

			FileUtils.deleteDir(saveDir);
			this.template.convertAndSendToUser(principal.getName(), "/topic/console",
					new Output("FINISHED: " + sdf.format(new Date())));
		} else {
			this.template.convertAndSend("/topic/console", new Output(
					"ERROR: Please reload crawler page and try again. " + sdf.format(new Date())));
		}
	}
}
