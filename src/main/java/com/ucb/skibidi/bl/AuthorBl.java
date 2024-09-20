package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.AuthorRepository;
import com.ucb.skibidi.entity.Author;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorBl {
    private static final Logger log = LoggerFactory.getLogger(AuthorBl.class);

    @Autowired
    AuthorRepository authorRepository;

    public Author createAuthor(String authorName) {
        log.info("Creating author...");
        try {
            Author author = new Author();
            author.setName(authorName);
            author = authorRepository.save(author);
            log.info("Author created");
            return author;
        } catch (Exception e) {
            log.error("Error creating author: {}", e.getMessage());
            throw e;
        }
    }

    public Author findAuthorByName(String authorName) {
        log.info("Finding author...");
        try {
            Author author = authorRepository.findByName(authorName);
            log.info("Author exists already");
            return author;
        } catch (Exception e) {
            log.error("Author doesn't exist: {}", e.getMessage());
            throw e;
        }
    }

}
