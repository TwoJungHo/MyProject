package kr.co.tj.chatservice;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatDTO {

	private String roomTitle;

	private Date sendAt;

	private String sender;

	private String receiver;

	private String message;
}
