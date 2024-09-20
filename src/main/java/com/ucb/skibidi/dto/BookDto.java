package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BookDto {
    private String title;
    private String isbn;
    private Date registrationDate;
    private Boolean status;
    private String imageUrl;
    private String genre;
    private List<String> authors;

}
