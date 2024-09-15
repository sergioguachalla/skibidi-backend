package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Environment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EnvironmentRepository extends JpaRepository<Environment, Long> {
    Environment findByName(String name);
    List<Environment> findByIsAvailable(Boolean isAvailable);
}
