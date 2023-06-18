package kr.co.tj.friend;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface FriendRepository extends JpaRepository<FriendEntity, String>{

	List<FriendEntity> findByUsername(String username);

	boolean existsByUsernameAndFriendname(String username, String friendname);

	FriendEntity findByFriendname(String friendname);

}
