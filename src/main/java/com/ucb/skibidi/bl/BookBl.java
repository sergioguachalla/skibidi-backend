package com.ucb.skibidi.bl;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dao.BookRepository;
import com.ucb.skibidi.dto.BookDto;
import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.utils.ValidationUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class BookBl {

    // bl de google libros
    @Autowired
    GoogleBooksBl googleBooksBl;

    //dao libros
    @Autowired
    BookRepository bookRepository;

    private static final Logger log = org.slf4j.LoggerFactory.getLogger(BookBl.class);

    public void createBookManually(BookDto bookDto) throws Exception {
        log.info("Creating book...");
        try {
            validateBook(bookDto);
            saveBook(bookDto);
            log.info("Book created {}", bookDto.toString());
        } catch (Exception e) {
            log.error("Error creating book: {}", e.getMessage());
            throw e;
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

    public BookDto updateBookAvailability(Long bookId){
        BookDto bookDto = new BookDto();

        return bookDto;
    }

    //////////////////

    public void saveBook(BookDto bookDto) throws Exception {
        log.info("Saving book...");
        try {
            //entidad libro
            Book bookEntity = new Book();
            bookEntity.setTitle(bookDto.getTitle());
            bookEntity.setIsbn(bookDto.getIsbn());
            //bookEntity.setRegistrationDate(bookDto.getRegistrationDate());
            //bookEntity.setStatus(bookDto.getStatus());
            bookRepository.save(bookEntity);
            log.info("Book saved {}", bookEntity.toString());
        } catch (Exception e) {
            log.error("Error saving book: {}", e.getMessage());
            throw e;
        }
    }

    public void updateBookStatus(BookDto bookDto) throws Exception {
        log.info("Updating book status...");
        try {
            Book bookEntity = bookRepository.findByIsbn(bookDto.getIsbn());
            if (bookEntity == null) {
                log.error("Book with ISBN {} not found", bookDto.getIsbn());
                throw new NullPointerException("Book not found with ISBN: " + bookDto.getIsbn());
            }
            bookEntity.setStatus(bookDto.getStatus());
            bookRepository.save(bookEntity);
            log.info("Book status updated {}", bookEntity.toString());
        } catch (Exception e) {
            log.error("Error updating book status: {}", e.getMessage());
            throw e;
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

    public List<BookDto> getAllBooks() throws Exception {
        log.info("Getting all books...");
        try {
            List<Book> bookEntities = bookRepository.findAll();
            List<BookDto> booksDto = new ArrayList<>();
            for (Book bookEntity : bookEntities) {
                BookDto bookDto = new BookDto();
                bookDto.setTitle(bookEntity.getTitle());
                bookDto.setIsbn(bookEntity.getIsbn());
                bookDto.setRegistrationDate(bookEntity.getRegistrationDate());
                bookDto.setStatus(bookEntity.getStatus());
                booksDto.add(bookDto);
            }
            log.info("Books found {}",booksDto.toString());
            return booksDto;
        } catch (Exception e) {
            log.error("Error getting books: {}", e.getMessage());
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
