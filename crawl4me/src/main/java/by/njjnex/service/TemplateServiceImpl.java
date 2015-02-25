package by.njjnex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import by.njjnex.dao.TemplateDao;
import by.njjnex.model.Page;

@Service
public class TemplateServiceImpl implements TemplateService {

	@Autowired
	TemplateDao templateDao;

	@Override
	@Transactional
	public void saveTemplate(Page template) {
		templateDao.saveTemplate(template);

	}

	@Override
	@Transactional
	public Page getTemplate(String id) {
		return templateDao.getTemplate(id);
		
	}

	@Override
	@Transactional
	public void removeTemplate(String id) {
		templateDao.removeTemplate(id);
		
	}
}
