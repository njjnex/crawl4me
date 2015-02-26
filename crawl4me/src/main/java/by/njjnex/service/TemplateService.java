package by.njjnex.service;

import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;

public interface TemplateService {

	public void saveTemplate(PageJS scanningTemplate);
	public PageHTML getTemplate(String id);
	public void removeTemplate(String id);
}
