package kr.co.tj.userservicepic;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserPicRepository extends JpaRepository<UserPicEntity, Long> {

	UserPicEntity findByLoginId(String loginId);

}
