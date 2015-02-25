package by.njjnex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import by.njjnex.logic.PageExplorer;
import by.njjnex.model.PageHTML;
import by.njjnex.service.TemplateService;

@RestController
public class AngularController {
	
	@Autowired
	TemplateService templateService;
	
	@RequestMapping(value="/htmlDefault")
	public PageHTML defaultPage(@RequestBody String url) {
			System.out.println(url + " path ");
		return new PageExplorer(url).explorePage();
	}
	@RequestMapping(value="/jsDefault")
	public PageHTML defaultJSPage(@RequestBody String url) {
			System.out.println(url + " path ");
		return new PageExplorer(url).exploreJSPage();
	}
	
}
