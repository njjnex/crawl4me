package by.njjnex.logic;

public class UserMessageConverter {

	public String convert(String message){
		String result = message.replace("<", "&lt");
		result = result.replace(">", "&gt");
		result.replaceAll("\"", " ");
		return result;
	}
}
