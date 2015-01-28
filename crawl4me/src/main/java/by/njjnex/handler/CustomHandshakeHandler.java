package by.njjnex.handler;

import java.security.Principal;
import java.util.Arrays;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

public class CustomHandshakeHandler extends DefaultHandshakeHandler {

	@Override
	protected Principal determineUser(ServerHttpRequest request,
			WebSocketHandler wsHandler, Map<String, Object> attributes) {
				
		HttpHeaders headers = request.getHeaders();
		Principal principal = request.getPrincipal();
		
		if(principal == null)
			principal = new UsernamePasswordAuthenticationToken(headers.getFirst("cookie"), "-", Arrays.asList(new SimpleGrantedAuthority("ANONYMOUS")));
					
		return principal;
	}

}
