package kr.co.tj.chatroomservice;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.tj.chatservice.ChatDTO;
import kr.co.tj.chatservice.ChatEntity;
import kr.co.tj.chatservice.ChatRepository;

@Service
public class ChatRoomServiceImpl implements ChatRoomService{

	@Autowired
	private ChatRoomRepository chatRoomRepository;
	
	@Autowired
	private ChatRepository chatRepository;
	
	@Override
	public Map<String, Object> enter(String title) {
		Optional<ChatRoomEntity> optional = chatRoomRepository.findByTitle(title);
		
		// chatRoom에 title이 없을경우 null을 리턴보냄
		if(!optional.isPresent()) {
			return null;
		}
		
		ChatRoomEntity entity = optional.get();
		
		ChatRoomDTO dto =  ChatRoomDTO.builder()
		.id(entity.getId())
		.title(entity.getTitle())
		.username1(entity.getUsername1())
		.username2(entity.getUsername2())
		.build();
		
		// 대화내용 list로 뽑아서 넣기
		List<ChatEntity> list = chatRepository.findByRoomTitle(entity.getTitle());
		List<ChatDTO> dtoList = new ArrayList<>();
		for(ChatEntity x : list) {
			ChatDTO resDTO = ChatDTO.builder()
			.roomTitle(x.getRoomTitle())
			.sendAt(x.getSendAt())
			.sender(x.getSender())
			.receiver(x.getReceiver())
			.message(x.getMessage())
			.build();
			
			dtoList.add(resDTO);
		}
		
		// 자료형을 list로 정렬하기위해 Comparator 인터페이스를 구현하는 객체 생성
		// 메시지 발송시간으로 비교 정렬함
		Comparator<ChatDTO> comparator = new Comparator<ChatDTO>() {

			@Override
			public int compare(ChatDTO dto1, ChatDTO dto2) {
				return dto1.getSendAt().compareTo(dto2.getSendAt());
			}
		};
		
		Collections.sort(dtoList, comparator);
		
		Map<String, Object> map = new HashMap<>();
		map.put("roomInfo", dto);
		map.put("messageList", dtoList);
		return map;
	}

	@Override
	public ChatRoomDTO insertRoom(ChatRoomDTO chatRoomDTO) {

		ChatRoomEntity entity = ChatRoomEntity.builder()
				.title(chatRoomDTO.getTitle())
				.username1(chatRoomDTO.getUsername1())
				.username2(chatRoomDTO.getUsername2())
				.build();
		
		entity = chatRoomRepository.save(entity);
		
		chatRoomDTO.setId(entity.getId());
		return chatRoomDTO;
	}

	@Override
	public List<ChatRoomDTO> FindRoomByLoginid(String loginId) {
		
		List<ChatRoomDTO> chatRoomDTOList = new ArrayList<>();
		List<ChatRoomEntity> chatRoomEntityList = chatRoomRepository.findByUsername1(loginId);
		
		for(ChatRoomEntity x : chatRoomEntityList) {
			
			ChatRoomDTO chatRoomDTO = ChatRoomDTO.builder()
			.id(x.getId())
			.title(x.getTitle())
			.username1(x.getUsername1())
			.username2(x.getUsername2())
			.build();
		chatRoomDTOList.add(chatRoomDTO);
		}
		return chatRoomDTOList;
	}

}
