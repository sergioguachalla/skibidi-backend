package com.ucb.skibidi.dto;


import lombok.Data;

import java.util.Date;

@Data
public class LendBookLibraryDto {
    private String clientName;
    private Long lendBookId;
    private Date lendDate;
    private Date returnDate;
    private String notes;
    private String title;
    private String authors;  // Cambiado a String
    private int status;


    public LendBookLibraryDto(String clientName, Long lendBookId, Date lendDate, Date returnDate, String notes, String title, String authors, int status) {
        this.clientName = clientName;
        this.lendBookId = lendBookId;
        this.lendDate = lendDate;
        this.returnDate = returnDate;
        this.notes = notes;
        this.title = title;
        this.authors = authors;
        this.status = status;
    }
}
