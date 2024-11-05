package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.LendBookRepository;
import com.ucb.skibidi.dto.LendBookDto;
import com.ucb.skibidi.dto.LendBookLibraryDto;
import jakarta.persistence.Tuple;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class LendBookBl {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(LendBookBl.class);

    @Autowired
    private LendBookRepository lendBookRepository;


    public Page<LendBookDto> findLendBooksByKcUuid(int page, int size, String kcUuid, Sort sort) {
        Pageable pageable = PageRequest.of(page, size, sort);
        log.info("Finding lend books for kcUuid: {}", kcUuid);
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

    public Page<LendBookLibraryDto> findLendBooksWithDetails(int page, int size, Sort sort) {
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


}
