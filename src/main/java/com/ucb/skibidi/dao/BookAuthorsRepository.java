package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.BookAuthors;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookAuthorsRepository extends JpaRepository<BookAuthors, Long> {
}
