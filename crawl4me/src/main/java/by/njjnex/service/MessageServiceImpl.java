package by.njjnex.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import by.njjnex.dao.MessageDao;
import by.njjnex.model.Message;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDao messageDao;

	@Override
	@Transactional
	public void save(Message message) {
		messageDao.save(message);
	}

	@Override
	@Transactional
	public List<Message> getMessages() {
		return messageDao.getMessages();
	}

	@Override
	@Transactional
	public Message getMessage(long messageId) {
				return messageDao.getMessage(messageId);
	}

	@Override
	@Transactional
	public void removeMessage(Message message) {
		messageDao.removeMessage(message);
		
	}
}
