package by.njjnex.service;

import java.util.List;

import by.njjnex.model.User;

public interface UserService {

	public User getUserById(long id);
	public User getUser(String username);
	public void removeUser(User user);
	public void createUser(User user);
	public List<User> getAllUsers();
	public void updateUser(User user);
}
