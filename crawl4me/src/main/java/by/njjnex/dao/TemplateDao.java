package by.njjnex.dao;

import by.njjnex.model.PageHTML;
import by.njjnex.model.PageJS;

public interface TemplateDao {

	void saveTemplate(PageJS template);
	PageHTML getTemplate(String id);
	void removeTemplate(String id);
	

	
}
