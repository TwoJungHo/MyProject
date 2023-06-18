package kr.co.tj.userservice;

public interface UserService {

	UserDTO createUser(UserDTO dto);

	UserDTO findById(String id);

	UserDTO DeleteUser(UserDTO dto);

	UserDTO UpdateUserInfo(UserDTO dto);

}
