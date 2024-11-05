package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.LendBookBl;
import com.ucb.skibidi.dto.LendBookDto;
import com.ucb.skibidi.dto.LendBookLibraryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:4200") // Permitir sólo desde localhost:4200
@RestController
@RequestMapping("/api/v1/lend-books")
public class LendBookApi {
    @Autowired
    private LendBookBl lendBookBl;

    @GetMapping
    public Page<LendBookLibraryDto> getLendBooks(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "asc") String sortOrder) {
        Sort sort = sortOrder.equalsIgnoreCase("desc") ? Sort.by("returnDate").descending() : Sort.by("returnDate").ascending();
        return lendBookBl.findLendBooksWithDetails(page, size, sort);
    }


    @GetMapping("/{kcUuid}")
    public Page<LendBookDto> getLendBooksByKcUuid(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "asc") String sortOrder,
            @PathVariable String kcUuid) {
        Sort sort = sortOrder.equalsIgnoreCase("desc") ? Sort.by("returnDate").descending() : Sort.by("returnDate").ascending();
        return lendBookBl.findLendBooksByKcUuid(page, size, kcUuid, sort);
    }


}

