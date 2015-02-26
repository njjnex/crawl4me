package by.njjnex.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import by.njjnex.model.PageJS;

@Repository
public class TemplateDaoImpl implements TemplateDao {
	
	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void saveTemplate(PageJS template) {
		sessionFactory.getCurrentSession().merge(template);

	}

	@Override
	public PageJS getTemplate(String id) {
		return (PageJS) sessionFactory.getCurrentSession().createQuery("FROM PageJS where id = :id").setString("id", id).uniqueResult();
		 
	}

	@Override
	public void removeTemplate(String id) {
		sessionFactory.getCurrentSession().createSQLQuery("delete from crawler.TEMPLATE where TEMPLATE_ID = :id").setString("id", id);

	}

}
