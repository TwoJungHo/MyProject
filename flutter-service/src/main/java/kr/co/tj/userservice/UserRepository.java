package kr.co.tj.userservice;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, String> {

	UserEntity findByLoginId(String username);

}
