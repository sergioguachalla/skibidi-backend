package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class LendBookDto {
    private Long lendBookId;
    private Date lendDate;
    private Date returnDate;
    private String notes;
    private String title;
    private String authors;  // Cambiado a String
    private int status;

    // Constructor necesario para el query personalizado
    public LendBookDto(Long lendBookId, Date lendDate, Date returnDate, String notes, String title, String authors, int status) {
        this.lendBookId = lendBookId;
        this.lendDate = lendDate;
        this.returnDate = returnDate;
        this.notes = notes;
        this.title = title;
        this.authors = authors;
        this.status = status;
    }
}
