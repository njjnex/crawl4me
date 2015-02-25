package by.njjnex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import by.njjnex.logic.PageExplorer;
import by.njjnex.model.Page;
import by.njjnex.service.TemplateService;

@RestController
public class AngularController {
	
	@Autowired
	TemplateService templateService;
	
	@RequestMapping(value="/urlTest")
	public Page defaultPage(@RequestBody String url) {
			System.out.println(url + " path ");
		return new PageExplorer(url).explorePage();
	}
	
	@RequestMapping(value="/urlTest/s{id}")
	public Page templatePage(@PathVariable() String generatedId, @RequestBody String url) {
			System.out.println(url + " path " + generatedId);
			String id = "s" + generatedId;
			
		return templateService.getTemplate(id);
	}
}
