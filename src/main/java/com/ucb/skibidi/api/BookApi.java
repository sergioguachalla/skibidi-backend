package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.BookBl;
import com.ucb.skibidi.dto.BookDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/books")
public class BookApi {

    @Autowired
    private BookBl bookBl;

    @PostMapping("/create")
    public ResponseDto<BookDto> createBook(@RequestBody BookDto bookDto) {
        try {
            bookBl.createBookManually(bookDto);
            ResponseDto<BookDto> responseDto = new ResponseDto<>();
            responseDto.setData(bookDto);
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

    @PostMapping("/create/{isbn}")
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

    @GetMapping("/get/{isbn}")
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

    @GetMapping("/get")
    public ResponseDto<List<BookDto>> getAllBooks() {
        try {
            ResponseDto<List<BookDto>> responseDto = new ResponseDto<>();
            responseDto.setData(bookBl.getAllBooks());
            responseDto.setMessage("Books found");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            ResponseDto<List<BookDto>> responseDto = new ResponseDto<>();
            responseDto.setData(null);
            responseDto.setMessage("Error getting book: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }

}
