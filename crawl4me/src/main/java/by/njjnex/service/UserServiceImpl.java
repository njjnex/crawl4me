package by.njjnex.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import by.njjnex.dao.UserDao;
import by.njjnex.model.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao userDao;
	
	@Override
	@Transactional
	public void removeUser(User user) {
		userDao.removeUser(user);
		
	}

	@Override
	@Transactional
	public void createUser(User user) {
		userDao.createUser(user);
		
	}

	@Override
	@Transactional
	public User getUserById(long id) {
		 return userDao.getUserById(id);
		
	}

	@Override
	@Transactional
	public User getUser(String username) {
		return userDao.getUser(username);
	}

	@Override
	@Transactional
	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}

	@Override
	@Transactional
	public void updateUser(User user) {
		userDao.updateUser(user);
		
	}
}
