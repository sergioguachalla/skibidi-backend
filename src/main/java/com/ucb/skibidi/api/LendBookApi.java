package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.LendBookBl;
import com.ucb.skibidi.dto.LendBookDto;
import com.ucb.skibidi.dto.LendBookLibraryDto;
import com.ucb.skibidi.dto.ResponseDto;
import com.ucb.skibidi.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;


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

    @PutMapping("/{id}/return-date")
    public ResponseDto<?> updateReturnDate(@PathVariable Long id, @RequestBody Date newReturnDate) {
        ResponseDto<?> responseDto = new ResponseDto<>();
        try {
            lendBookBl.updateReturnDate(id, newReturnDate);
            responseDto.setMessage("Return date updated successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error updating return date: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }

    @PutMapping("/{id}/status")
    public ResponseDto<?> updateStatusToReturned(@PathVariable Long id) {
        ResponseDto<?> responseDto = new ResponseDto<>();
        try {
            lendBookBl.updateStatusToReturned(id);
            responseDto.setMessage("Book status updated to returned");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error updating book status: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }

    @PostMapping("")
    public ResponseDto<String> saveLendBook(@RequestBody LendBookResponseDto lendBookDto){
        ResponseDto<String> responseDto = new ResponseDto<>();
        try {
            lendBookBl.saveLendBook(lendBookDto);
            responseDto.setData(null);
            responseDto.setMessage("LendBook saved");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error creating lendBook: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }
}
