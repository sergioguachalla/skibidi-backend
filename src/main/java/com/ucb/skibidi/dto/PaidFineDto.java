package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PaidFineDto {
    private Long fineId;
    private String username;
    private String bookTitle;
    private String typeFine;
    private Double amount;
    private Date paidDate;
    private boolean isOverdue;
}
