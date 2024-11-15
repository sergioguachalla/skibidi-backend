package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;

@Data
public class FineDetailDto {
    private Long fineId;
    private Date dueDate;
    private Double originalAmount;
    private Long delayDays;
    private String status;
    private Double totalAmount;
    private BookDetailsDto book;
    private String username;


}
