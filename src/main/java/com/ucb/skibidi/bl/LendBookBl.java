package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.BookRepository;
import com.ucb.skibidi.dao.LendBookRepository;
import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.LendBookDto;
import com.ucb.skibidi.dto.LendBookLibraryDto;
import com.ucb.skibidi.entity.LendBook;
import com.ucb.skibidi.dto.LendBookResponseDto;
import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.entity.LendBook;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.entity.UserLibrarian;
import jakarta.persistence.Tuple;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.util.Optional;
import com.ucb.skibidi.entity.Book;


import java.util.*;

@Service
public class LendBookBl {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(LendBookBl.class);

    @Autowired
    private LendBookRepository lendBookRepository;
    @Autowired
    private BookRepository bookRepository;


    @Autowired
    private UserClientRepository userClientRepository;

    @Autowired
    private NotificationBl notificationBl;

    public Page<LendBookDto> findLendBooksByKcUuid(int page, int size, String kcUuid, String sortField, String sortOrder) {
        Sort sort = buildSort(sortField, sortOrder);
        Pageable pageable = PageRequest.of(page, size, sort);
        log.info("Finding lend books for kcUuid: {} with sort: {}", kcUuid, sort);
        Page<Tuple> tuples = lendBookRepository.findLendBooksWithDetailsByKcUuid(kcUuid, pageable);
        return tuples.map(tuple -> new LendBookDto(
                tuple.get("lendBookId", Long.class),
                tuple.get("lendDate", Date.class),
                tuple.get("returnDate", Date.class),
                tuple.get("notes", String.class),
                tuple.get("title", String.class),
                tuple.get("authors", String.class),
                tuple.get("status", Integer.class)
        ));
    }

    public Page<LendBookLibraryDto> findLendBooksWithDetails(int page, int size, String sortField, String sortOrder) {
        Sort sort = buildSort(sortField, sortOrder);
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Tuple> tuples = lendBookRepository.findLendBooksWithDetails(pageable);
        return tuples.map(tuple -> new LendBookLibraryDto(
                tuple.get("clientName", String.class),
                tuple.get("lendBookId", Long.class),
                tuple.get("lendDate", Date.class),
                tuple.get("returnDate", Date.class),
                tuple.get("notes", String.class),
                tuple.get("title", String.class),
                tuple.get("authors", String.class),
                tuple.get("status", Integer.class)
        ));
    }

    private Sort buildSort(String sortField, String sortOrder) {
        if (!sortField.equals("lendDate") && !sortField.equals("returnDate")) {
            sortField = "lendDate";
        }
        return sortOrder.equalsIgnoreCase("desc") ? Sort.by(sortField).descending() : Sort.by(sortField).ascending();
    }
    public void updateReturnDate(Long lendBookId, Date newReturnDate) throws Exception {
        Optional<LendBook> optionalLendBook = lendBookRepository.findById(lendBookId);
        if (optionalLendBook.isPresent()) {
            LendBook lendBook = optionalLendBook.get();
            lendBook.setReturnDate(newReturnDate);
            lendBookRepository.save(lendBook);
        } else {
            throw new Exception("El préstamo con ID " + lendBookId + " no existe.");
        }
    }
    public void updateStatusToReturned(Long lendBookId) throws Exception {
        Optional<LendBook> optionalLendBook = lendBookRepository.findById(lendBookId);
        if (optionalLendBook.isPresent()) {
            LendBook lendBook = optionalLendBook.get();
            lendBook.setStatus(2);
            Book book = lendBook.getBookId();
            if (book != null) {
                book.setStatus(true);
                bookRepository.save(book);
            } else {
                throw new Exception("El libro asociado al préstamo no existe.");
            }
            lendBookRepository.save(lendBook);
        } else {
            throw new Exception("El préstamo con ID " + lendBookId + " no existe.");
        }
    }

    public void saveLendBook(LendBookResponseDto lendBookResponseDto){
        LendBook lendBook = new LendBook();
        Book book = new Book();
        UserLibrarian userLibrarian =new UserLibrarian();
        UserClient userClient = userClientRepository.findByPersonIdKcUuid(lendBookResponseDto.getClientKcId());
        userLibrarian.setLibrarianId(1l);
        book.setBookId(Long.valueOf(lendBookResponseDto.getBookId()));
        lendBook.setBookId(book);
        lendBook.setLibrarianId(userLibrarian);
        lendBook.setClientId(userClient);
        lendBook.setNotes(lendBookResponseDto.getNote());
        lendBook.setStatus(1);
        lendBook.setLentDate(new Date());
        lendBook.setReturnDate(lendBookResponseDto.getReturnDate());
        lendBook.setNotification_check(false);
        lendBookRepository.saveAndFlush(lendBook);
    }

    @Scheduled(fixedRate = 60000)
    public void checkDueLendBooks() {
        List<LendBook> dueLendBooks = lendBookRepository.findBooksDueIn24Hours(new Date(), new Date(System.currentTimeMillis() + 24 * 60 * 60 * 1000));
        log.info("Checking due lend books: {}", dueLendBooks.size());
        for (LendBook lendBook : dueLendBooks) {
            log.info("Due lend book: {}", lendBook);
            Map<String, String> parameters = createLendNotification(lendBook);
            notificationBl.sendNotification(parameters, lendBook.getClientId().getPersonId().getPhoneNumber(), 4L);
        }
    }

    private Map<String, String> createLendNotification(LendBook lendBook) {
        Map<String, String> parameters = new HashMap<>();
        parameters.put("1", lendBook.getClientId().getPersonId().getName());
        parameters.put("2", lendBook.getBookId().getTitle());
        parameters.put("3", lendBook.getReturnDate().toString());
        return parameters;
    }

}
