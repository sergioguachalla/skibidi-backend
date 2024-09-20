package com.ucb.skibidi.bl;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dao.BookAuthorsRepository;
import com.ucb.skibidi.dao.BookRepository;
import com.ucb.skibidi.dto.BookDto;
import com.ucb.skibidi.dto.BookManualDto;
import com.ucb.skibidi.entity.Author;
import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.entity.BookAuthors;
import com.ucb.skibidi.entity.Genre;
import com.ucb.skibidi.utils.BookSpecification;
import com.ucb.skibidi.utils.ValidationUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class BookBl {

    // bl de google libros
    @Autowired
    GoogleBooksBl googleBooksBl;
    @Autowired
    GenreBl genreBl;
    @Autowired
    AuthorBl authorBl;
    @Autowired
    BookAuthorsBl bookAuthorsBl;

    //dao libros
    @Autowired
    BookRepository bookRepository;


    private static final Logger log = org.slf4j.LoggerFactory.getLogger(BookBl.class);
    @Autowired
    private BookAuthorsRepository bookAuthorsRepository;

    public void createBookManually(BookManualDto bookDto) throws Exception {
        log.info("Creating book...");
        try {
            //validateBook(bookDto);
            saveManually(bookDto);
            log.info("Book created {}", bookDto.toString());
        } catch (Exception e) {
            log.error("Error creating book: {}", e.getMessage());
            throw e;
        }

    }


    public void saveManually(BookManualDto bookManualDto){
        Book book = new Book();
        Genre genre = new Genre();
        genre.setGenreId((long) bookManualDto.getGenreId());
        book.setTitle(bookManualDto.getTitle());
        book.setIsbn(bookManualDto.getIsbn());
        book.setRegistrationDate(new Date());
        book.setStatus(true);
        book.setImageUrl(bookManualDto.getImageUrl());
        book.setGenreId(genre);
        bookRepository.save(book);
        for(String author : bookManualDto.getAuthors()){
            Author authorEntity = authorBl.createAuthor(author);
            BookAuthors bookAuthors = new BookAuthors();
            bookAuthors.setBookId(book);
            bookAuthors.setAuthorId(authorEntity);
            bookAuthorsRepository.save(bookAuthors);
        }
    }

    public BookDto createBookByISBN(String isbn) throws Exception{
        log.info("Creating book...");
        try {
            validateISBN(isbn);
            BookDto bookInfo = new BookDto();
            bookInfo.setIsbn(isbn);
            bookInfo = getBookInfo(bookInfo);
            validateBook(bookInfo);
            saveBook(bookInfo);
            log.info("Book created {}", bookInfo.toString());
            return bookInfo;
        } catch (Exception e) {
            log.error("Error creating book: {}", e.getMessage());
            throw e;
        }

    }


    //////////////////

    public void saveBook(BookDto bookDto) throws Exception {
        log.info("Saving book...");
        try {
            //entidad libro
            Book bookEntity = new Book();
            bookEntity.setTitle(bookDto.getTitle());
            bookEntity.setIsbn(bookDto.getIsbn());
            bookEntity.setImageUrl(bookDto.getImageUrl());

            //genero
            bookEntity.setGenreId(genreBl.createGenre(bookDto.getGenre()));

            //bookEntity.setRegistrationDate(bookDto.getRegistrationDate());
            //bookEntity.setStatus(bookDto.getStatus());
            bookEntity = bookRepository.save(bookEntity);
            saveBookAuthors(bookEntity, bookDto.getAuthors());
            log.info("Book saved {}", bookEntity.toString());
        } catch (Exception e) {
            log.error("Error saving book: {}", e.getMessage());
            throw e;
        }
    }

    public void saveBookAuthors(Book bookToSave, List<String> authors) throws Exception {
        log.info("Saving book authors...");
        for(String author : authors){
            try {
                log.debug("Author to be saved: {}", author);
                //entidad autor
                Author authorToSave = authorBl.createAuthor(author);
                bookAuthorsBl.createBookAuthors(bookToSave, authorToSave);
                log.info("Book author saved {}", author);
            } catch (Exception e) {
                log.error("Error saving book authors: {}", e.getMessage());
                throw e;
            }
        }
    }



    public BookDto getBookByISBN(String isbn) throws Exception {
        log.info("Getting book...");
        try {
            validateISBN(isbn);
            Book bookEntity = new Book();
            BookDto bookDto = new BookDto();
            bookEntity = bookRepository.findByIsbn(isbn);
            if (bookEntity == null) {
                log.error("Book with ISBN {} not found", isbn);
                throw new NullPointerException("Book not found with ISBN: " + isbn);
            }
            bookDto.setTitle(bookEntity.getTitle());
            bookDto.setIsbn(bookEntity.getIsbn());
            bookDto.setRegistrationDate(bookEntity.getRegistrationDate());
            bookDto.setStatus(bookEntity.getStatus());
            log.info("Book found {}",bookEntity.toString());
            return bookDto;
        } catch (Exception e) {
            log.error("Error getting book: {}", e.getMessage());
            throw e;
        }
    }

    public Page<BookManualDto> getAllBooks(Pageable pageable, Integer genreId) throws Exception {
        log.info("Getting all books...");
        Specification<Book> spec = Specification.where(null);
        try {
            if (genreId != null) {
                spec = spec.and(BookSpecification.hasGenre((long) genreId));
            }
            Page<Book> bookEntities = bookRepository.findAll(spec, pageable);
            Page<BookManualDto> booksDto = bookEntities.map(bookEntity -> {
                BookManualDto bookDto = new BookManualDto();
                bookDto.setTitle(bookEntity.getTitle());
                bookDto.setIsbn(bookEntity.getIsbn());
                bookDto.setRegistrationDate(bookEntity.getRegistrationDate());
                bookDto.setStatus(bookEntity.getStatus());
                bookDto.setImageUrl(bookEntity.getImageUrl());
                bookDto.setGenreId(Math.toIntExact(bookEntity.getGenreId().getGenreId()));
                bookDto.setAuthors(bookAuthorsBl.getAuthorsByBook(bookEntity.getBookId()));
                return bookDto;
            });
            return booksDto;
        } catch (Exception e) {
            log.error("Error getting books: {}", e.getMessage());
            throw e;
        }
    }


    public void updateBookAvailability(Long bookId) throws Exception {
        log.info("Updating book availability...");
        try {
            bookRepository.updateBookStatus(bookId);
            log.info("Book availability updated");
        } catch (Exception e) {
            log.error("Error updating book availability: {}", e.getMessage());
            throw e;
        }
    }

    //////////////////


    public void validateISBN(String isbn) throws InvalidInputException {
        ValidationUtils.validateISBN(isbn);
    }

    public void validateBook(BookDto bookDto) throws InvalidInputException {
        ValidationUtils.validateISBN(bookDto.getIsbn());
        ValidationUtils.validateTitle(bookDto.getTitle());
        // deberia validar? o se asigna automaticamente a la fecha actual
        //ValidationUtils.validateRegistrationDate(bookDto.getRegistrationDate());
        //ValidationUtils.validateStatus(bookDto.getStatus());
    }

    public BookDto getBookInfo(BookDto bookDto) {
        log.info("Getting book info...");
        try {
            return googleBooksBl.getBookByIsbn(bookDto.getIsbn());

        } catch (Exception e) {
            log.error("Error getting book info: {}", e.getMessage());
            return bookDto;
        }
    }
}
