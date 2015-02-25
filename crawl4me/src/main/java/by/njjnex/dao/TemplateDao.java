package by.njjnex.dao;

import by.njjnex.model.PageHTML;

public interface TemplateDao {

	void saveTemplate(PageHTML template);
	PageHTML getTemplate(String id);
	void removeTemplate(String id);

	
}
