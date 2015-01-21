package by.me2.dao;

import by.me2.model.ScanningTemplate;

public interface TemplateDao {

	void saveTemplate(ScanningTemplate template);

	ScanningTemplate getTemplate(String id);

	void removeTemplate(String id);

	
}
