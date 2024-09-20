package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.BookBl;
import com.ucb.skibidi.dto.BookDto;
import com.ucb.skibidi.dto.BookManualDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.PUT;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
@RestController
@RequestMapping("/api/v1/books")
public class BookApi {

    @Autowired
    private BookBl bookBl;

    @PostMapping("/")
    public ResponseDto<String> createBook(@RequestBody BookManualDto bookDto) {
        ResponseDto<String> responseDto = new ResponseDto<>();

        try {
            bookBl.createBookManually(bookDto);
            responseDto.setData("Book created");
            responseDto.setMessage("Success");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error creating book: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;

    }

    @PostMapping("/{isbn}")
    public ResponseDto<BookDto> createBook(@PathVariable String isbn) {
        try {
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            responseDto.setData(bookBl.createBookByISBN(isbn));
            responseDto.setMessage("Book created");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            responseDto.setData(null);
            responseDto.setMessage("Error creating book: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }

    @GetMapping("/{isbn}")
    public ResponseDto<BookDto> getBook(@PathVariable String isbn) {
        try {
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            responseDto.setData(bookBl.getBookByISBN(isbn));
            responseDto.setMessage("Book found");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            responseDto.setData(null);
            responseDto.setMessage("Error getting book: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }

    @GetMapping("/")
    public ResponseDto<Page<BookManualDto>> getAllBooks(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "4") Integer size,
            @RequestParam(required = false) Integer genreId
    ) {
        Pageable pageable = PageRequest.of(page, size);
        ResponseDto<Page<BookManualDto>> responseDto = new ResponseDto<>();
        try {
            Page<BookManualDto> books = bookBl.getAllBooks(pageable, genreId);
            responseDto.setData(books);
            responseDto.setMessage("Books found");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error getting book: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }

    @PutMapping("/{id}")
    public ResponseDto<?> updateBookAvailability(@PathVariable Long id) {
        try {
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            bookBl.updateBookAvailability(id);
            responseDto.setMessage("Book updated");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            responseDto.setData(null);
            responseDto.setMessage("Error updating book: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }
}
