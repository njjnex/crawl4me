package by.njjnex.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import by.njjnex.model.Message;

@Repository
public class MessageDoaImpl implements MessageDao {
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(Message message) {
		sessionFactory.getCurrentSession().save(message);
	}

	
	@SuppressWarnings("unchecked")
	@Override
	public List<Message> getMessages() {
		return sessionFactory
				.getCurrentSession()
				.createQuery(
						"FROM Message message order by id desc")
				.list();
	}

	@Override
	public Message getMessage(long messageId) {
		return (Message) sessionFactory
				.getCurrentSession()
				.createQuery(
						"FROM Message message where message.id = :messageId")
				.setParameter("messageId", messageId).uniqueResult();
	}

	@Override
	public void removeMessage(Message message) {
		
		String query = "delete from crawler.MESSAGE where MESSAGE_ID = :message_id";
		Query q = sessionFactory.getCurrentSession().createSQLQuery(query);
		q.setLong("message_id", message.getId());
		q.executeUpdate();

	}

}
