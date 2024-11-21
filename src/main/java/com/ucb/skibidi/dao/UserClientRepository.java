package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.UserClient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserClientRepository extends JpaRepository<UserClient, Long>, JpaSpecificationExecutor<UserClient> {
    UserClient findByUsername(String username);
    List<UserClient> findAll();

    UserClient findByPersonIdKcUuid(String kcUuid);

    @Query("SELECT u.clientId FROM UserClient u JOIN u.personId p WHERE p.kcUuid = :kcUuid")
    Long findClientIdByKcUuid(@Param("kcUuid") String kcUuid);

    @Query("SELECT p.kcUuid FROM Person p WHERE p.email = :email")
    String findKcUuidIdByEmail(@Param("email") String email);

    @Query("SELECT u FROM UserClient u JOIN u.personId p WHERE p.kcUuid = :kcId")
    UserClient findByKcId(@Param("kcId") String kcId);
}