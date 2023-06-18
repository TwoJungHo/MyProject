package kr.co.tj.friend;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FriendServiceImpl implements FriendService {

	@Autowired
	private FriendRepository friendRepository;

	@Override
	public FriendDTO AddFriend(FriendDTO dto) {

		FriendEntity entity = FriendEntity.builder().username(dto.getUsername()).friendname(dto.getFriendname())
				.build();

		entity = friendRepository.save(entity);

		dto = FriendDTO.builder().username(entity.getUsername()).friendname(entity.getFriendname()).build();
		return dto;
	}

	@Override
	public List<FriendDTO> findByUsername(String username) {

		List<FriendEntity> list = friendRepository.findByUsername(username);
		List<FriendDTO> list_dto = new ArrayList<>();

		for (FriendEntity x : list) {
			list_dto.add(FriendDTO.builder().username(x.getUsername()).friendname(x.getFriendname()).build());
		}
		return list_dto;
	}

	@Override
	public boolean isFriendDuplicate(String username, String friendname) {

		return friendRepository.existsByUsernameAndFriendname(username, friendname);
	}

	@Override
	public FriendEntity FindByFriendName(String friendname) {
		FriendEntity entity = friendRepository.findByFriendname(friendname);

		if (entity == null) {
			return null;
		}
		return entity;
	}

	@Override
	public void DeleteFriend(FriendEntity entity) {
		friendRepository.delete(entity);
		
	}

}
