package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.BookAuthorsRepository;
import com.ucb.skibidi.entity.Author;
import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.entity.BookAuthors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookAuthorsBl {
    private static final Logger log = LoggerFactory.getLogger(BookAuthorsBl.class);

    @Autowired
    BookAuthorsRepository bookAuthorsRepository;

    public void createBookAuthors(Book book, Author author) {
        log.info("Creating book authors...");
        try {
            BookAuthors bookAuthors = new BookAuthors();
            bookAuthors.setBookId(book);
            bookAuthors.setAuthorId(author);
            bookAuthorsRepository.save(bookAuthors);
            log.info("Book authors created");
        } catch (Exception e) {
            log.error("Error creating book authors: {}", e.getMessage());
            throw e;
        }
    }

    public List<String> getAuthorsByBook(Long bookId) {
        log.info("Getting authors by book...");
        try {
            log.info("Finding authors by bookId: {}", bookId);
            List<String> authors = bookAuthorsRepository.findAuthorsByBookId(bookId);
            log.info("Authors by book found {}", authors);
            return authors;
        } catch (Exception e) {
            log.error("Error getting authors by book: {}", e.getMessage());
            throw e;
        }
    }

}
