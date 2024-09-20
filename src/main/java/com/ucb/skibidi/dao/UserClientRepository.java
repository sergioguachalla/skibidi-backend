package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.UserClient;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface UserClientRepository extends JpaRepository<UserClient, Long> {
    UserClient findByUsername(String username);
    List<UserClient> findAll();
}