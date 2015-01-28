package by.njjnex.controller;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import by.njjnex.collector.Launcher;
import by.njjnex.logic.DomRuleConverter;
import by.njjnex.model.Message;
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

	@RequestMapping("/")
	public String mainPage(Model model) {
		
		ScanningTemplate defaultScanningTemplate = new ScanningTemplate();
		defaultScanningTemplate.setUrl("http://localhost:8080/");
		defaultScanningTemplate.setRegex("http://localhost:8080/.*");
		Map<String,String> domRules = new LinkedHashMap<String, String>();
		domRules.put("Title", "title");
		domRules.put("Text", "p[class=copyright-area]");
		defaultScanningTemplate.setDomRules(domRules);
				
		model.addAttribute("template", defaultScanningTemplate);
		return "main";
	}

	@RequestMapping("/admin.html")
	public String adminPage(Model model) {
		System.out.println("admin page");
		return "main";
	}
	@RequestMapping("/login")
	public String loginPage(Model model) {
		
		return "loginForm";
	}
	
	@RequestMapping("/saveState/{id}")
	public @ResponseBody String saveTemplate(
			@PathVariable ("id") String generatedId,
			@RequestBody ScanningTemplate scanningTemplate) {
		
		scanningTemplate.setId("s"+generatedId);
		
		System.out.println("get id: " + "s"+generatedId + "url: " + scanningTemplate.getUrl());
		templateService.saveTemplate(scanningTemplate);

		return generatedId;
	}
	@RequestMapping("/s{id}")
	public String getTemplate(
			@PathVariable ("id") String generatedId, Model model) {
		
		String id = "s"+generatedId;		
		System.out.println("get template with id: " + id);
		ScanningTemplate template = templateService.getTemplate(id);

		model.addAttribute("template",template);
		
		return "main";
	}

	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public void greeting(ScanningTemplate userInput, Principal principal) throws Exception {
				
		System.out.println(principal + " : " + principal.getName());
		DomRuleConverter converter = new DomRuleConverter();
		userInput.setDomRules(converter.convertTag((userInput.getDomRules()))); //convert dom rules
		
		Launcher crawler = new Launcher("/tut", principal, userInput.getRegex(), template);
		crawler.run(crawler, userInput.getUrl(), (LinkedHashMap<String, String>) userInput.getDomRules());

	}
}
