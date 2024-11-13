package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.LendBookBl;
import com.ucb.skibidi.dto.LendBookDto;
import com.ucb.skibidi.dto.LendBookLibraryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200")
@RestController
@RequestMapping("/api/v1/lend-books")
public class LendBookApi {
    @Autowired
    private LendBookBl lendBookBl;

    @GetMapping
    public Page<LendBookLibraryDto> getLendBooks(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "lendDate") String sortField,
            @RequestParam(defaultValue = "asc") String sortOrder) {

        return lendBookBl.findLendBooksWithDetails(page, size, sortField, sortOrder);
    }

    @GetMapping("/{kcUuid}")
    public Page<LendBookDto> getLendBooksByKcUuid(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "lendDate") String sortField,
            @RequestParam(defaultValue = "asc") String sortOrder,
            @PathVariable String kcUuid) {

        return lendBookBl.findLendBooksByKcUuid(page, size, kcUuid, sortField, sortOrder);
    }
}