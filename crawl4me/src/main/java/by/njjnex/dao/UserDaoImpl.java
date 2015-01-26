package by.njjnex.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import by.njjnex.model.User;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void removeUser(User user) {
		sessionFactory.getCurrentSession().delete(user);
	}

	@Override
	public void createUser(User user) {
		sessionFactory.getCurrentSession().save(user);
	}

	@Override
	public User getUserById(long id) {
		return (User) sessionFactory.getCurrentSession().get(User.class, id);
	}

	@Override
	public User getUser(String username) {
		User user = (User) sessionFactory
				.getCurrentSession()
				.createQuery(
						"select u from User u where u.username = :username")
				.setParameter("username", username).uniqueResult();
		return user;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getAllUsers() {
		return sessionFactory.getCurrentSession().createQuery("FROM User user")
				.list();
	}

	@Override
	public void updateUser(User user) {
		sessionFactory.getCurrentSession().merge(user);
	}
}
