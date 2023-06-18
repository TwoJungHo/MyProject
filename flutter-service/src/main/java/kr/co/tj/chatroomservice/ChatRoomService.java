package kr.co.tj.chatroomservice;

import java.util.List;
import java.util.Map;

public interface ChatRoomService {

	Map<String, Object> enter(String title);

	ChatRoomDTO insertRoom(ChatRoomDTO chatRoomDTO);

	List<ChatRoomDTO> FindRoomByLoginid(String loginId);

}
