package by.njjnex.service;

import by.njjnex.model.Page;
import by.njjnex.model.ScanningTemplate;

public interface TemplateService {

	public void saveTemplate(Page scanningTemplate);

	public ScanningTemplate getTemplate(String id);

	public void removeTemplate(String id);
}
