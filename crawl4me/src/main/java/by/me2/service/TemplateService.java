package by.me2.service;

import by.me2.model.ScanningTemplate;

public interface TemplateService {

	public void saveTemplate(ScanningTemplate template);

	public ScanningTemplate getTemplate(String id);

	public void removeTemplate(String id);
}
