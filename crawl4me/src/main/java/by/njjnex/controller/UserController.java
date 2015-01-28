package by.njjnex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import by.njjnex.model.User;
import by.njjnex.service.UserService;

@Controller
public class UserController {
	@Autowired
	UserService userService;

	@RequestMapping("/register")
	public String newUser(
			@RequestParam("username") String username,
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			Model model) {

		User user = new User(username, email, password);
		String resultString = null;
		resultString = "Registration completed please Log In";
		
		if (userService.getUser(user.getUsername()) != null) {
			resultString = "Please choose another username!";
		}
		
		model.addAttribute("resultString", resultString);

		return "forward:/";
	}
	
	@RequestMapping("/error-login")
	public String errorLogin(Model model){
		model.addAttribute("resultString", "Incorrect login please try again.");
		return "forward:/";
	}
}
