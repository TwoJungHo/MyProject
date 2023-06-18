package kr.co.tj.userservice;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	@Override
	public UserDTO createUser(UserDTO dto) {
		
		UserEntity entity = UserEntity.builder()
		.loginId(dto.getLoginId())
		.nickname(dto.getNickname())
		.password(dto.getPassword())
		.phoneNumber(dto.getPhoneNumber())
		.statusMSG(dto.getStatusMSG())
		.build();
		
		entity = userRepository.save(entity);
		
		dto = UserDTO.builder()
		.id(entity.getId())
		.loginId(entity.getLoginId())
		.nickname(entity.getNickname())
		.password(null)
		.phoneNumber(entity.getPhoneNumber())
		.statusMSG(entity.getStatusMSG())
		.build();
		
		return dto;
	}

	@Override
	public UserDTO findById(String id) {
		
		if(userRepository.findById(id).isEmpty()) {
			return null;
		}
		Optional<UserEntity> optional = userRepository.findById(id);

		UserEntity entity = optional.get();
		
		UserDTO dto = UserDTO.builder()
				.id(entity.getId())
				.loginId(entity.getLoginId())
				.nickname(entity.getNickname())
				.password(entity.getPassword())
				.phoneNumber(entity.getPhoneNumber())
				.statusMSG(entity.getStatusMSG())
				.build();
		return dto;
	}

	@Override
	public UserDTO DeleteUser(UserDTO dto) {
		
		if(userRepository.findById(dto.getId()).isEmpty()) {
			return null;
		}
		
		userRepository.deleteById(dto.getId());
		return dto;
	}

	@Override
	public UserDTO UpdateUserInfo(UserDTO dto) {
		
		UserEntity entity = userRepository.findByLoginId(dto.getLoginId());
		
		 // 변경하고자 하는 필드에 대한 값만 설정한다.
	    if (dto.getNickname() != null) {
	        entity.setNickname(dto.getNickname());
	    }
	    if (dto.getPhoneNumber() != null) {
	        entity.setPhoneNumber(dto.getPhoneNumber());
	    }
	    if (dto.getPassword() != null) {
	        entity.setPassword(dto.getPassword());
	    }
	    if (dto.getStatusMSG() != null) {
	        entity.setStatusMSG(dto.getStatusMSG());
	    }

	    entity = userRepository.save(entity);
	    
	    dto = UserDTO.builder()
	    .id(entity.getId())
	    .loginId(entity.getLoginId())
        .nickname(entity.getNickname())
        .phoneNumber(entity.getPhoneNumber())
        .password(entity.getPassword())
        .statusMSG(entity.getStatusMSG())
	    .build();
		
		
		return dto;
	}

	
	
}
