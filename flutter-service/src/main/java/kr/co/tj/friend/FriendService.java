package kr.co.tj.friend;

import java.util.List;

public interface FriendService {

	FriendDTO AddFriend(FriendDTO dto);

	List<FriendDTO> findByUsername(String username);

	boolean isFriendDuplicate(String username, String friendname);

	FriendEntity FindByFriendName(String friendname);

	void DeleteFriend(FriendEntity entity);

}
