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
    private String status;
    private String username;
    private Optional<?> paidDate;
}
