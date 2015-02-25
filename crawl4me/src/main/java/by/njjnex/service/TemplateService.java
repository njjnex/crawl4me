package by.njjnex.service;

import by.njjnex.model.PageHTML;

public interface TemplateService {

	public void saveTemplate(PageHTML scanningTemplate);
	public PageHTML getTemplate(String id);
	public void removeTemplate(String id);
}
