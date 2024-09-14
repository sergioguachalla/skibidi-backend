package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;

@Data
public class BookDto {
    private String title;
    private String isbn;
    private Date registrationDate;
    private Boolean status;
    private String image_url;

}
