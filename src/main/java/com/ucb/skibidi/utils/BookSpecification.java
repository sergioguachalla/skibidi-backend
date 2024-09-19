package com.ucb.skibidi.utils;

import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.entity.Genre;
import jakarta.persistence.criteria.Join;
import org.springframework.data.jpa.domain.Specification;

public class BookSpecification {
    public static Specification<Book> hasGenre(Long genreId) {
        return (root, query, cb) -> cb.equal(root.get("genreId").get("genreId"), genreId);
    }
}
