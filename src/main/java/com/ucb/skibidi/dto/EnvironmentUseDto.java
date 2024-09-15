package com.ucb.skibidi.dto;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class EnvironmentUseDto {
    private String librarianName;
    private String clientName;
    private String environmentName;
    private LocalDate reservationDate;
    private LocalDateTime clockIn;
    private LocalDateTime clockOut;
    private String purpose;
}
