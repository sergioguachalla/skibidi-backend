
package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreRepository extends JpaRepository<Genre, Long> {
    //to check if the genre already exists in the database
    Boolean findByName(String name);
}
