package kr.co.tj.userservice;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.tj.userservicepic.UserPicDTO;
import kr.co.tj.userservicepic.UserPicService;


@RestController
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserPicService userPicService;
	
	@PostMapping("/create")
	public ResponseEntity<?> createUser(@RequestBody UserDTO dto){
		Map<String, Object> map = new HashMap<>();
		
		if(dto.getNickname() == null || dto.getNickname() == "") {
			return null;
		}
		
		if(dto.getPassword()==null || dto.getPassword()=="") {
			return null;
		}
		
		if(dto.getPhoneNumber()==null || dto.getPhoneNumber()=="") {
			return null;
		}
		
		if(dto.getLoginId()==null || dto.getLoginId()=="") {
			return null;
		}
		
		try {
			dto = userService.createUser(dto);
			map.put("result", dto);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "실패!");
		}
		return ResponseEntity.ok().body(map);
	}
	
	@PutMapping("/update")
	public ResponseEntity<?> UpdateUserInfo(MultipartHttpServletRequest request){
		// 이미지 까지 같이 업데이트하려면 MultipartHttpServletRequest 사용해서 formData로 보내야함
		// 송신 보낼때 formData값을 loginId, nickname, phoneNumber, password, file로 보내야함
		Map<String, Object> map = new HashMap<>();
		
		String loginId = request.getParameter("loginId");
		String nickname = request.getParameter("nickname");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");
		
		System.out.println(loginId);
		if(nickname=="" || password=="" || phoneNumber=="") {
			throw new RuntimeException("닉네임, 페스워드, 핸드폰번호가 빈칸입니다");
		}
		
		// 파일 업로드 과정
		MultipartFile picFile = request.getFile("file");
		String picFilename = picFile.getOriginalFilename();
		try {
			byte[] picData = picFile.getBytes();
			UserPicDTO userPicDTO = new UserPicDTO(null, loginId, picFilename, picData);		
			userPicService.insertPic(userPicDTO);
		} catch (IOException e) {
			e.printStackTrace();
			map.put("result", "업로드 실패");
			return ResponseEntity.badRequest().body(map);
		} // 파일 업로드 끝
		
		UserDTO dto = UserDTO.builder()
		.loginId(loginId)
		.nickname(nickname)
		.phoneNumber(phoneNumber)
		.password(password)
		.build();
		
		dto = userService.UpdateUserInfo(dto);
		map.put("result", dto);
		return ResponseEntity.ok().body(map);
	}
	
	// 내정보 보기
	@GetMapping("/userinfo/{id}")
	public ResponseEntity<?> Userinfo(@PathVariable("id") String id){
		Map<String, Object> map = new HashMap<>();
		
		UserDTO dto = userService.findById(id);
		
		map.put("result", dto);
		return ResponseEntity.ok().body(map);
	}
	
	//내 이미지 보기
	@GetMapping("userpicinfo/{loginId}")
	public ResponseEntity<?> UserPicInfo(@PathVariable("loginId") String loginId){
		UserPicDTO dto = userPicService.GetImageFile(loginId);
		if(dto==null) {
			return null;
		}
		String filename = dto.getFilename();
		byte[] picdata = dto.getPicData();
		String fileExtension = filename.substring(filename.lastIndexOf(".")+1);
		MediaType mediaType = MediaType.parseMediaType("image/"+fileExtension);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(mediaType);
		
		return ResponseEntity.ok().headers(headers).body(picdata);
	}
	
	// 회원탈퇴 아직 미구현 (회원삭제시 이미지, 친구창에서 해당 loginID를 모두 삭제해야함)
	@DeleteMapping("/userdelete")
	public ResponseEntity<?> UserDelete(@RequestBody UserDTO dto){
		Map<String, Object> map = new HashMap<>();
		
		dto = userService.DeleteUser(dto);
		map.put("result", dto+"삭제완료!");
		return ResponseEntity.ok().body(map);
	}
}
