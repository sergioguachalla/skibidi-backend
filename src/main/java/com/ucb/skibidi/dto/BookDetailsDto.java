package com.ucb.skibidi.dto;
import lombok.Data;
import java.util.Date;
import java.util.List;

@Data
public class BookDetailsDto {
    private Long bookId;
    private String title;
    private String isbn;
    private Date registrationDate;
    private Integer status;
    private String imageUrl;
    private String genre;
    private List<String> authors;
    private String editorialName;
    private String languageName;

}


