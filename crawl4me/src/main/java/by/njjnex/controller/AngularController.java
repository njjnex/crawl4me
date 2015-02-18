package by.njjnex.controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import by.njjnex.logic.PageExplorer;
import by.njjnex.model.Page;

@RestController
public class AngularController {

	@RequestMapping(value="/urlTest")
	public Page howToPage(@RequestBody String url) {
			System.out.println(url);
		return new PageExplorer(url).explorePage();
	}
}
