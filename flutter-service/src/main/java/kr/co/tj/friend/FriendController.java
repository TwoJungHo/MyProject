package kr.co.tj.friend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.tj.userservice.UserEntity;
import kr.co.tj.userservice.UserRepository;

@RestController
@RequestMapping("/friend")
public class FriendController {
	
	@Autowired
	private FriendService friendService;
	
	@Autowired
	private UserRepository userRepository;
	
	@PostMapping("/add")
	public ResponseEntity<?> AddFriend(@RequestBody FriendDTO dto){
		Map<String, Object> map = new HashMap<>();
		
		UserEntity entity = userRepository.findByLoginId(dto.getUsername());
		if(!entity.getLoginId().equals(dto.getUsername())) {
			return ResponseEntity.badRequest().body("현재 로그인되어있는 정보와 다릅니다");
		}
		
		// 친구추가하려는 정보가 있는지 확인
		UserEntity friendEntity = userRepository.findByLoginId(dto.getFriendname());
		if(friendEntity==null) {
			return ResponseEntity.badRequest().body("친구의 정보가 없습니다");
		}
		
		// 중복된 친구 추가인지 확인
	    boolean isDuplicate = friendService.isFriendDuplicate(dto.getUsername(), dto.getFriendname());
	    if (isDuplicate) {
	        return ResponseEntity.badRequest().body("이미 친구로 등록된 사용자입니다");
	    }
		
		try {
			dto = friendService.AddFriend(dto);
			map.put("result", dto);
			return ResponseEntity.ok().body(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", e.getMessage());
			return ResponseEntity.badRequest().body(map);
		}
	}
	
	@GetMapping("/{username}")
	public ResponseEntity<?> FindByUsername(@PathVariable("username") String username){
		
		Map<String, Object> map = new HashMap<>();
		
		List<FriendDTO> dto = friendService.findByUsername(username);
		map.put("result", dto);
		return ResponseEntity.ok().body(map);
	}
	
	@DeleteMapping("/deletefriend/{friendname}")
	public ResponseEntity<?> DeleteFriend(@PathVariable("friendname") String friendname){
		
		FriendEntity entity = friendService.FindByFriendName(friendname);
		if(entity==null) {
			return ResponseEntity.badRequest().body("이미 삭제된 친구이거나 친구가 없습니다.");
		}
		
		friendService.DeleteFriend(entity);
		
		return ResponseEntity.ok().body("친구 삭제가 완료되었습니다.");
	}
}
