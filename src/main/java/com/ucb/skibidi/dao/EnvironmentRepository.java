package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Environment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnvironmentRepository extends JpaRepository<Environment, Long> {
}
