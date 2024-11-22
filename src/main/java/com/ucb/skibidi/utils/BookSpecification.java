package com.ucb.skibidi.utils;
import com.ucb.skibidi.entity.*;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import org.slf4j.Logger;
import org.springframework.data.jpa.domain.Specification;

import java.util.Date;



public class BookSpecification {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(BookSpecification.class);

    public static Specification<Book> hasGenre(Long genreId) {
        return (root, query, cb) -> cb.equal(root.get("genreId").get("genreId"), genreId);
    }

    public static Specification<Book> startDateBetween(Date from, Date to) {

        return (root, query, cb) -> {
            log.info("Filtering books from {} to {}", from, to);
            if (from != null && to != null) {
                return cb.between(root.get("registrationDate"), from, to);
            } else if (from != null) {
                return cb.greaterThanOrEqualTo(root.get("registrationDate"), from);
            } else if (to != null) {
                return cb.lessThanOrEqualTo(root.get("registrationDate"), to);
            }
            return cb.conjunction();
        };
    }


    public static Specification<Book> isAvailable() {
        return (root, query, cb) -> cb.equal(root.get("status"), true);
    }

    public static Specification<Book> isNotAvailable() {
        return (root, query, cb) -> cb.equal(root.get("status"), false);
    }

    public static Specification<Book> hasAuthor(String author) {
        return (root, query, cb) -> {
            Join<Book, Author> join = root.join("authors", JoinType.INNER);
            return cb.equal(join.get("name"), author);
        };
    }
    public static Specification<Book> hasLanguage(Long languageId) {
        return (root, query, cb) -> {
            Join<Book, Language> join = root.join("idLanguage", JoinType.INNER);
            return cb.equal(join.get("languageId"), languageId);
        };
    }

    public static Specification<Book> hasTitle(String title) {
        return (root, query, cb) -> cb.like(root.get("title"), "%" + title + "%");
    }

    public static Specification<Book> hasEditorial(Long editorialId) {
        return (root, query, cb) -> {
            Join<Book, Editorial> join = root.join("editorialId", JoinType.INNER);
            return cb.equal(join.get("editorialId"), editorialId);
        };
        }

    public static Specification<Book> notArchived() {
        return (root, query, criteriaBuilder) ->
                criteriaBuilder.notEqual(root.get("status"), 2);
    }
}
