package by.me2.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import by.me2.model.ScanningTemplate;

public class TemplateDaoImpl implements TemplateDao {
	
	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void saveTemplate(ScanningTemplate template) {
		sessionFactory.getCurrentSession().save(template);

	}

	@Override
	public ScanningTemplate getTemplate(String id) {
		sessionFactory.getCurrentSession().createQuery("FROM ScanningTemplate where id = :id").setString("id", id);
		return null;
	}

	@Override
	public void removeTemplate(String id) {
		sessionFactory.getCurrentSession().createSQLQuery("delete from crawler.TEMPLATE where TEMPLATE_ID = :id").setString("id", id);

	}

}
