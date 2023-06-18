package kr.co.tj.userservicepic;

public interface UserPicService {

	String insertPic(UserPicDTO userPicDTO);

	UserPicDTO GetImageFile(String loginId);

}
