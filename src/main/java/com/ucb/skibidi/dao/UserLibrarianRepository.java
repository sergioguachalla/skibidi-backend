package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.UserLibrarian;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserLibrarianRepository extends JpaRepository<UserLibrarian, Long> {
    UserLibrarian findByUsername(String username);
}
