package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.UserClient;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserClientRepository extends JpaRepository<UserClient, Long> {
}
