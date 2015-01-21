package by.njjnex.service;

import by.njjnex.model.ScanningTemplate;

public interface TemplateService {

	public void saveTemplate(ScanningTemplate template);

	public ScanningTemplate getTemplate(String id);

	public void removeTemplate(String id);
}
