package kr.co.tj.chatservice;


import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
	@MessageMapping("/sendmessage")
	public void message(ChatDTO dto) {
		
		chatService.saveAndSendMessage(dto);
	}
	
	
	/*
	  private String roomTitle;
	  private Date sendAt;
	  private String sender;
	  private String receiver; 
	  private String message;
	 */
}
