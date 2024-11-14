package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.BookRepository;
import com.ucb.skibidi.dao.LendBookRepository;
import com.ucb.skibidi.dto.LendBookDto;
import com.ucb.skibidi.dto.LendBookLibraryDto;
import com.ucb.skibidi.entity.LendBook;
import jakarta.persistence.Tuple;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import java.util.Optional;
import com.ucb.skibidi.entity.Book;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class LendBookBl {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(LendBookBl.class);

    @Autowired
    private LendBookRepository lendBookRepository;
    @Autowired
    private BookRepository bookRepository;


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
}
