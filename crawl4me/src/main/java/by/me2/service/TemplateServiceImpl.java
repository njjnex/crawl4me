package by.me2.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import by.me2.dao.TemplateDao;
import by.me2.model.ScanningTemplate;

@Service
public class TemplateServiceImpl implements TemplateService {

	@Autowired
	TemplateDao templateDao;

	@Override
	@Transactional
	public void saveTemplate(ScanningTemplate template) {
		templateDao.saveTemplate(template);

	}

	@Override
	public ScanningTemplate getTemplate(String id) {
		return templateDao.getTemplate(id);
		
	}

	@Override
	public void removeTemplate(String id) {
		templateDao.removeTemplate(id);
		
	}
}
