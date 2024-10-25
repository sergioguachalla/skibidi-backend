package com.ucb.skibidi.bl;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dao.BookAuthorsRepository;
import com.ucb.skibidi.dao.BookRepository;
import com.ucb.skibidi.dao.EditorialRepository;
import com.ucb.skibidi.dao.LanguageRepository;
import com.ucb.skibidi.dto.BookDto;
import com.ucb.skibidi.dto.BookManualDto;
import com.ucb.skibidi.entity.*;
import com.ucb.skibidi.utils.BookSpecification;
import com.ucb.skibidi.utils.ValidationUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookBl {

    private static final Logger log = org.slf4j.LoggerFactory.getLogger(BookBl.class);

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
    @Autowired
    private BookAuthorsRepository bookAuthorsRepository;
    @Autowired
    private LanguageRepository languageRepository;
    @Autowired
    private EditorialRepository editorialRepository;


    public void createBookManually(BookManualDto bookDto) throws Exception {
        log.info("Creating book...");
        try {
            BookDto bookInfo = new BookDto();
            bookInfo.setIsbn(bookDto.getIsbn());
            bookInfo.setTitle(bookDto.getTitle());
            bookInfo.setEditorialId(bookDto.getEditorialId());
            bookInfo.setIdLanguage(bookDto.getLanguageId());
            validateBook(bookInfo);
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


    //////////////////

//    public void saveManually(BookManualDto bookManualDto){
//        Book book = new Book();
//        Genre genre = new Genre();
//        genre.setGenreId((long) bookManualDto.getGenreId());
//
//        book.setTitle(bookManualDto.getTitle());
//        book.setIsbn(bookManualDto.getIsbn());
//        book.setRegistrationDate(new Date());
//        book.setStatus(true);
//        book.setImageUrl(bookManualDto.getImageUrl());
//        book.setGenreId(genre);
//
//        BookDto bookDto = new BookDto();
//
//        saveBook(book);
//    }

    //save book manually
    public void saveBook(BookManualDto bookDto) throws Exception {
        log.info("Saving book...");
        log.info("BookDto: {}", bookDto.toString());
        try {
            //entidad libro
            Book bookEntity = new Book();
            bookEntity.setTitle(bookDto.getTitle());
            bookEntity.setIsbn(bookDto.getIsbn());
            bookEntity.setImageUrl(bookDto.getImageUrl());

            //genero
            Genre genre = new Genre();
            //log.info("Genre id: {}", bookDto.getGenreId());
            genre.setGenreId((long) bookDto.getGenreId());
            bookEntity.setGenreId(genre);

            //bookEntity.setRegistrationDate(bookDto.getRegistrationDate());
            //bookEntity.setStatus(bookDto.getStatus());
            //language
            bookEntity.setIdLanguage(
                    languageRepository.findById((long) bookDto.getLanguageId()).orElse(null)
            );
            bookEntity.setEditorialId(
                    editorialRepository.findById(bookDto.getEditorialId()).orElse(null));

            bookEntity = bookRepository.save(bookEntity);
            saveBookAuthors(bookEntity, bookDto.getAuthors());
            log.info("Book saved {}", bookEntity.toString());
        } catch (Exception e) {
            log.error("Error saving book: {}", e.getMessage());
            throw e;
        }
    }


    public void saveBook(BookDto bookDto) throws Exception {
        log.info("Saving book...");
        try {
            //entidad libro
            Book bookEntity = new Book();
            bookEntity.setTitle(bookDto.getTitle());
            bookEntity.setIsbn(bookDto.getIsbn());
            bookEntity.setImageUrl(bookDto.getImageUrl());

            Editorial editorial = this.editorialRepository.findByEditorialId(bookDto.getEditorialId());
            bookEntity.setEditorialId(editorial);
            Language language = this.languageRepository.findByLanguageId(bookDto.getIdLanguage());
            bookEntity.setIdLanguage(language);


            //genero
            //bookEntity.setGenreId(genreBl.createGenre(bookDto.getGenre()));

            try {
                bookEntity.setGenreId(genreBl.findGenreByName(bookDto.getGenre()));
            } catch (Exception e) {
                bookEntity.setGenreId(genreBl.createGenre(bookDto.getGenre()));
            }

            bookEntity = bookRepository.save(bookEntity);
            saveBookAuthors(bookEntity, bookDto.getAuthors());
            log.info("Book saved {}", bookEntity);
        } catch (Exception e) {
            log.error("Error saving book: {}", e.getMessage());
            throw e;
        }
    }


    public void saveBookAuthors(Book bookToSave, List<String> authors) throws Exception {
        log.info("Saving book authors...");
        for(String authorName : authors){
            try {
                log.debug("Author to be saved: {}", authorName);
                //entidad autor
                Author authorToBeFound = authorBl.findAuthorByName(authorName);
                Author author = new Author();
                if(authorToBeFound != null){
                    author = authorToBeFound;
                }else {
                    author = authorBl.createAuthor(authorName);
                }
                bookAuthorsBl.createBookAuthors(bookToSave, author);
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

    public Page<BookManualDto> getAllBooks(Pageable pageable, Integer genreId,
                                           Date from, Date to, Boolean isAvailable,
                                           String author, Long languageId, String title, Long editorialId) throws Exception {
        log.info("Getting all books...");
        log.info("Date from: {}", from);
        log.info("Date to: {}", to);

        Specification<Book> spec = Specification.where(null);
        try {
            if (genreId != null) {
                spec = spec.and(BookSpecification.hasGenre((long) genreId));
            }

            if (from != null && to != null) {
                spec = spec.and(BookSpecification.startDateBetween(from, to));
            }
            if(isAvailable != null){
                if(isAvailable){
                    spec = spec.and(BookSpecification.isAvailable());
                }else{
                    spec = spec.and(BookSpecification.isNotAvailable());
                }
            }
            if(author != null){
                spec = spec.and(BookSpecification.hasAuthor(author));
            }
            if(languageId != null){
                spec = spec.and(BookSpecification.hasLanguage(languageId));
            }
            if(title != null){
                spec = spec.and(BookSpecification.hasTitle(title));
            }
            if(editorialId != null){
                spec = spec.and(BookSpecification.hasEditorial(editorialId));
            }



            Page<Book> bookEntities = bookRepository.findAll(spec, pageable);
            Page<BookManualDto> booksDto = bookEntities.map(bookEntity -> {
                BookManualDto bookDto = new BookManualDto();
                bookDto.setBookId(bookEntity.getBookId());
                bookDto.setTitle(bookEntity.getTitle());
                bookDto.setIsbn(bookEntity.getIsbn());
                bookDto.setRegistrationDate(bookEntity.getRegistrationDate());
                bookDto.setStatus(bookEntity.getStatus());
                bookDto.setImageUrl(bookEntity.getImageUrl());
                bookDto.setGenreId(Math.toIntExact(bookEntity.getGenreId().getGenreId()));
                bookDto.setLanguageId(bookEntity.getIdLanguage().getLanguageId());
                bookDto.setEditorialId(bookEntity.getEditorialId().getEditorialId());
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
    public List<BookDto> searchBooksByTitle(String title) throws Exception {
        log.info("Searching books by title...");
        try {
            List<Book> books = bookRepository.findByTitleContainingIgnoreCase(title);
            if (books.isEmpty()) {
                log.info("No books found with title {}", title);
                return Collections.emptyList();
            }

            // Convertir la entidad Book a BookDto
            List<BookDto> bookDtos = books.stream().map(book -> {
                BookDto bookDto = new BookDto();
                bookDto.setTitle(book.getTitle());
                bookDto.setIsbn(book.getIsbn());
                bookDto.setRegistrationDate(book.getRegistrationDate());
                bookDto.setStatus(book.getStatus());
                bookDto.setImageUrl(book.getImageUrl());
                bookDto.setGenre(book.getGenreId().getName()); // Si Genre tiene el campo name
                return bookDto;
            }).collect(Collectors.toList());

            return bookDtos;
        } catch (Exception e) {
            log.error("Error searching books: {}", e.getMessage());
            throw e;
        }
    }
    public List<BookDto> searchBooksByAuthor(String authorName) {
        // Obtiene los IDs de los libros asociados al autor
        List<Long> bookIds = bookAuthorsRepository.findBooksByAuthorName(authorName);

        // Busca los libros por sus IDs usando findAllById
        List<Book> books = bookRepository.findAllById(bookIds);

        // Convierte a BookDto
        return books.stream().map(this::convertToDto).collect(Collectors.toList());
    }

    // Método para convertir Book a BookDto
    private BookDto convertToDto(Book book) {
        BookDto bookDto = new BookDto();
        bookDto.setBookId(book.getBookId());
        bookDto.setTitle(book.getTitle());
        bookDto.setIsbn(book.getIsbn());
        bookDto.setRegistrationDate(book.getRegistrationDate());
        bookDto.setStatus(book.getStatus());
        bookDto.setImageUrl(book.getImageUrl());
        bookDto.setGenre(book.getGenreId().getName());
        // Añade otros campos según sea necesario
        return bookDto;
    }
}

