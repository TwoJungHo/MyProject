package kr.co.tj.chatroomservice;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatRoomRepository extends JpaRepository<ChatRoomEntity, String>{

	Optional<ChatRoomEntity> findByTitle(String title);

	//List<ChatRoomEntity> findByUsername1ContainingOrUsername2Containing(String loginId, String loginId2);

	List<ChatRoomEntity> findByUsername1(String loginId);

}
