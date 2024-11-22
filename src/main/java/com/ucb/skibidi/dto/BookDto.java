package com.ucb.skibidi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
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
