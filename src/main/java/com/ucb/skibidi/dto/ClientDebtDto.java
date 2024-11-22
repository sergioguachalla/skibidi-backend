package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;
import java.util.Optional;

@Data
public class ClientDebtDto {
    private Long fineId;
    private String typeFine;
    private Date dueDate;
    private Double amount;
    private Double amountPlusInterest;
    private String status;
    private String username;
    private String userKcId;
    private Optional<?> paidDate;
    private Boolean canBorrowBooks; // Añadido el campo
}
