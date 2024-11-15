package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Template;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TemplateRepository extends JpaRepository<Template, Long> {
}
