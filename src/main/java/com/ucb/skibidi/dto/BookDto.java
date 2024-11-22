package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BookDto {
    private Long bookId;
    private String title;
    private String isbn;
    private Date registrationDate;
    private Integer status;
    private String imageUrl;
    private String genre;
    private List<String> authors;
    private Long editorialId;
    private Long idLanguage;

}
