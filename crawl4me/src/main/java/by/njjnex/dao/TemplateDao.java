package by.njjnex.dao;

import by.njjnex.model.ScanningTemplate;

public interface TemplateDao {

	void saveTemplate(ScanningTemplate template);

	ScanningTemplate getTemplate(String id);

	void removeTemplate(String id);

	
}
