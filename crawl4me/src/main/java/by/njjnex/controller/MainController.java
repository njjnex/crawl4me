package by.njjnex.controller;

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

import by.me2.model.ScanningTemplate;
import by.me2.service.TemplateService;
import by.njjnex.collector.Launcher;

@Controller
public class MainController {

	private SimpMessagingTemplate template;

	@Autowired
	public MainController(SimpMessagingTemplate template) {
		this.template = template;
	}
	@Autowired
	TemplateService templateService;

	@RequestMapping(value = "/")
	public String mainPage(Model model) {
		return "main";
	}

	@RequestMapping("/saveState/{id}")
	public @ResponseBody String postMessage(
			@PathVariable ("id") String generatedId,
			@RequestBody ScanningTemplate scanningRequest) {
		
		scanningRequest.setId(generatedId);
		
		System.out.println("get id: " + generatedId + "url: " + scanningRequest.getUrl());
		

		return generatedId;
	}

	@MessageMapping("/hello")
	@SendTo("/topic/greetings")
	public void greeting(ScanningTemplate userInput) throws Exception {
		Thread.sleep(3000); // simulated delay

		Launcher crawler = new Launcher("/tut", userInput.getRegex(), template);
		crawler.run(crawler, userInput.getUrl(), userInput.getDomRules());

	}
}
