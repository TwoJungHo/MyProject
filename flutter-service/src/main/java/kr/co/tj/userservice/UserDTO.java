package kr.co.tj.userservice;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDTO {
	
	private String id;
	
	private String loginId;
	
	private String nickname;
	
	private String phoneNumber;
	
	private String password;
	
	private String statusMSG; //상태메세지
}
