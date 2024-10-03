package com.ucb.skibidi.dto;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class EnvironmentReservationDto {
    private String clientId;
    private Long environmentId;
    private LocalDate reservationDate;
    private LocalDateTime clockIn;
    private LocalDateTime clockOut;
    private String purpose;
}
