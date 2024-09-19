package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Genre;
import com.ucb.skibidi.entity.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreRepository extends JpaRepository<Genre, Long> {
}
