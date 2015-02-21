package by.njjnex.service;

import by.njjnex.model.Page;

public interface TemplateService {

	public void saveTemplate(Page scanningTemplate);
	public Page getTemplate(String id);
	public void removeTemplate(String id);
}
