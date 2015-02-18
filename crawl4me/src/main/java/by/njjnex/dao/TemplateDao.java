package by.njjnex.dao;

import by.njjnex.model.Page;
import by.njjnex.model.ScanningTemplate;

public interface TemplateDao {

	void saveTemplate(Page template);

	ScanningTemplate getTemplate(String id);

	void removeTemplate(String id);

	
}
