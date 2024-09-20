package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.AuthorRepository;
import com.ucb.skibidi.entity.Author;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthorBl {
    private static final Logger log = LoggerFactory.getLogger(AuthorBl.class);

    @Autowired
    AuthorRepository authorRepository;

    public void Author(String authorName) {
        log.info("Creating author...");
        try {
            Author author = new Author();
            author.setName(authorName);
            author.setLastname("...");
            author = authorRepository.save(author);
            log.info("Author created");
        } catch (Exception e) {
            log.error("Error creating author: {}", e.getMessage());
            throw e;
        }
    }
}
