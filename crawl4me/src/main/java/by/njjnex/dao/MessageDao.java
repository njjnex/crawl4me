package by.njjnex.dao;

import java.util.List;

import by.njjnex.model.Message;

public interface MessageDao {
	public void save(Message message);
	public List<Message> getMessages();
	public Message getMessage(long messageId);
	public void removeMessage(Message message);
}
