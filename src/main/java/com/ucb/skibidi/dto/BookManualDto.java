package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BookManualDto {
    private Long bookId;
    private String title;
    private String isbn;
    private Date registrationDate;
    private Boolean status;
    private String imageUrl;
    private int genreId;
    private List<String> authors;
    private int languageId;
}
