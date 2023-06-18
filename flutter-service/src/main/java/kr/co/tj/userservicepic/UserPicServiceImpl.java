package kr.co.tj.userservicepic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserPicServiceImpl implements UserPicService{

	@Autowired
	private UserPicRepository userPicRepository;

	@Override
	public String insertPic(UserPicDTO userPicDTO) {

	    String loginId = userPicDTO.getLoginId();
	    
	    // 데이터베이스에서 해당 loginId로 이미지 엔티티를 조회
	    UserPicEntity existEntity = userPicRepository.findByLoginId(loginId);
	    if (existEntity != null) {
	        // 이미지 엔티티가 존재하는 경우에만 업데이트 수행
	    	existEntity.setFilename(userPicDTO.getFilename());
	    	existEntity.setPicData(userPicDTO.getPicData());
	    	existEntity = userPicRepository.save(existEntity);
	        
	        loginId = existEntity.getLoginId();
	    } else {
	        // 이미지 엔티티가 존재하지 않는 경우에는 새로운 엔티티를 생성하여 저장
	        UserPicEntity entity = UserPicEntity.builder()
	                .loginId(loginId)
	                .filename(userPicDTO.getFilename())
	                .picData(userPicDTO.getPicData())
	                .build();
	        
	        entity = userPicRepository.save(entity);
	        
	        loginId = entity.getLoginId();
	    }
	    
	    return loginId;
	}

	@Override
	public UserPicDTO GetImageFile(String loginId) {
		
		UserPicEntity entity = userPicRepository.findByLoginId(loginId);
		
		if(entity==null) {
			return null;
		}
		UserPicDTO dto = new UserPicDTO(entity.getId(), entity.getLoginId(), entity.getFilename(), entity.getPicData());
		
		return dto;
	}


	
	
}
