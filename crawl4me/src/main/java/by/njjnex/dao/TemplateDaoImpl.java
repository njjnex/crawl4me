package by.njjnex.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import by.njjnex.model.PageHTML;

@Repository
public class TemplateDaoImpl implements TemplateDao {
	
	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void saveTemplate(PageHTML template) {
		sessionFactory.getCurrentSession().merge(template);

	}

	@Override
	public PageHTML getTemplate(String id) {
		return (PageHTML) sessionFactory.getCurrentSession().createQuery("FROM Page where id = :id").setString("id", id).uniqueResult();
		 
	}

	@Override
	public void removeTemplate(String id) {
		sessionFactory.getCurrentSession().createSQLQuery("delete from crawler.TEMPLATE where TEMPLATE_ID = :id").setString("id", id);

	}

}
