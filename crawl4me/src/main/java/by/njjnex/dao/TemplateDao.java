package by.njjnex.dao;

import by.njjnex.model.Page;

public interface TemplateDao {

	void saveTemplate(Page template);
	Page getTemplate(String id);
	void removeTemplate(String id);

	
}
