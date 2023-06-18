package kr.co.tj.chatroomservice;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/chat-service")
public class ChatRoomController {
	
	@Autowired
	private ChatRoomService chatRoomService;
	
	@PostMapping("/enter")
	public ResponseEntity<?> InsertRoom(@RequestBody ChatRoomDTO dto){
		//username1, username2를 받아옴
		String username1 = dto.getUsername1();
		String username2 = dto.getUsername2();
		
		String[] users = {username1, username2};
		Arrays.sort(users);
		username1 = users[0];
		username2 = users[1];
		String title = username1 + "-" + username2;
		
		Map<String, Object> map = chatRoomService.enter(title);
		
		if(map==null) {
			Map<String, Object> responMap = new HashMap<>();
			ChatRoomDTO chatRoomDTO = ChatRoomDTO.builder()
					.title(title)
					.username1(username1)
					.username2(username2)
					.build();
			
			chatRoomDTO = chatRoomService.insertRoom(chatRoomDTO);
			
			responMap.put("isExist", false);
			responMap.put("roomInfo", chatRoomDTO);
			
			return ResponseEntity.ok().body(responMap);
		}
		ChatRoomDTO chatRoomDTO = (ChatRoomDTO) map.get("roomInfo");
		
		map.put("isExist", true);
		map.put("roomInfo", chatRoomDTO);
		
		return ResponseEntity.ok().body(map);
		
	}
	
	@GetMapping("/findchatrooms/{loginId}")
	public ResponseEntity<?> FindChatRooms(@PathVariable("loginId") String loginId){
		
		List<ChatRoomDTO> ChatList = chatRoomService.FindRoomByLoginid(loginId);
		
		List<Map<String, ChatRoomDTO>> ChatRoomDTOList = new ArrayList<>();
		
		for(ChatRoomDTO x : ChatList) {
			String friend;
			Map<String, ChatRoomDTO> roomMap = new HashMap<>();
			
			if(x.getUsername1().equals(loginId)) {
				friend = x.getUsername2();
			} else {
				friend = x.getUsername1();
			}
			
			ChatRoomDTO dto = ChatRoomDTO.builder()
					.id(x.getId())
					.title(x.getTitle())
					.username1(x.getUsername1())
					.username2(x.getUsername2())
					.build();
			
			roomMap.put(friend, dto);
			ChatRoomDTOList.add(roomMap);
		}
		
		return ResponseEntity.ok().body(ChatRoomDTOList);
	}
}
