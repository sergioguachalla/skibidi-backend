package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;

@Data
public class CalendarBookDto {
    private String bookName;
    private String author;
    private String genre;
    private Date date;

}
