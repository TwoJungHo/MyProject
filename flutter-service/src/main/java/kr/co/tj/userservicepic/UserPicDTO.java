package kr.co.tj.userservicepic;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class UserPicDTO {
	private Long id;
	
	private String loginId;
	
	private String filename;
	
	private byte[] picData;
}
