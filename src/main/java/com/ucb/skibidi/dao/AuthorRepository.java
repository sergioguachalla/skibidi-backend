package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Author;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorRepository extends JpaRepository<Author, Long> {
}
