package com.ucb.skibidi.utils;
import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.entity.Genre;
import jakarta.persistence.criteria.Join;
import org.springframework.data.jpa.domain.Specification;

import java.util.Date;

public class BookSpecification {
    public static Specification<Book> hasGenre(Long genreId) {
        return (root, query, cb) -> cb.equal(root.get("genreId").get("genreId"), genreId);
    }

    public static Specification<Book> startDateBetween(Date from, Date to) {
        return (root, query, cb) -> cb.between(root.get("registrationDate"), from, to);
    }

    public static Specification<Book> isAvailable() {
        return (root, query, cb) -> cb.equal(root.get("isAvailable"), true);
    }

    public static Specification<Book> isNotAvailable() {
        return (root, query, cb) -> cb.equal(root.get("isAvailable"), false);
    }

}