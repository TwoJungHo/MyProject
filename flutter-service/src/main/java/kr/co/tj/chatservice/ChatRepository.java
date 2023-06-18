package kr.co.tj.chatservice;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatRepository extends JpaRepository<ChatEntity, Long>{

	List<ChatEntity> findByRoomTitle(String title);

}
