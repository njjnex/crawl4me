package by.njjnex.dao;

import java.util.List;

import by.njjnex.model.User;

/**
 * @author njjnex
 *	Base interface for CRUD operations with user entity
 */
public interface UserDao {
	public User getUserById(long id);
	public User getUser(String username);
	public void removeUser(User user);
	public void createUser(User user);
	public List<User> getAllUsers();
	public void updateUser(User user);
}
