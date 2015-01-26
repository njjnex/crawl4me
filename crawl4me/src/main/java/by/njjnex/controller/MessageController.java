package by.njjnex.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import by.njjnex.logic.UserMessageConverter;
import by.njjnex.model.Message;
import by.njjnex.service.MessageService;

@Controller
public class MessageController {

	@Autowired
	MessageService messageService;

	@RequestMapping(value = "/postMessage")
	public @ResponseBody List<Message> postMessage(@RequestBody String text,
			Model model, Principal principal) {
		// User post message
		if (!(text == null || text.equals("\"\"")) ) {

			String date = new SimpleDateFormat("dd-MM-yyyy' at 'HH:mm")
					.format(new Date());
			Message message = new Message();
			message.setAuthor(principal.getName());
			message.setDate(date);
			message.setText(new UserMessageConverter().convert(text));
			messageService.save(message);
		} 
		List<Message> messageList = messageService.getMessages();
		
		return messageList;
	}

	@RequestMapping(value = "/deleteMessage{messageId}")
	public String deleteMessage(@PathVariable("messageId") long messageId,
			Model model, Principal principal) {

		Message message = messageService.getMessage(messageId);
		if (principal.getName().equals(message.getAuthor())
				|| principal.getName().equals("Admin")) {
			messageService.removeMessage(message);
		}
		List<Message> messageList = messageService.getMessages();

		model.addAttribute("messages", messageList);
		return "redirect:/events/{eventId}";
	}
}
