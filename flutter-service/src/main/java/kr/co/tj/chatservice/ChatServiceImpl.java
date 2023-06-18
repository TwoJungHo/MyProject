package kr.co.tj.chatservice;

import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Service;

@Service
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	private ChatRepository chatRepository;
	
	@Autowired
	private SimpMessageSendingOperations messagingTemplate;

	@Override
	@Transactional
	public void saveAndSendMessage(ChatDTO dto) {
		
		Date date = new Date();
		
		ChatEntity entity = ChatEntity.builder()
				.roomTitle(dto.getRoomTitle())
				.sendAt(date)
				.sender(dto.getSender())
				.receiver(dto.getReceiver())
				.message(dto.getMessage())
				.build();
		
		entity = chatRepository.save(entity);
		
		dto.setSendAt(entity.getSendAt());

		messagingTemplate.convertAndSend("/sub/chatroom/"+ dto.getRoomTitle(), dto);
	}

}
