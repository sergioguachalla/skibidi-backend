package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;

@Data
public class LendBookResponseDto {
    private Integer bookId;
    private Integer librarianId;
    private String  clientKcId;
    private Date returnDate;
    private String note;
}
