package com.ucb.skibidi.dto;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class EnvironmentReservationDto {
    private String clientId;
    // id del ambiente
    private Long environmentId;
    // id de la reserva
    private Long reservationId;
    private LocalDate reservationDate;
    private LocalDateTime clockIn;
    private LocalDateTime clockOut;
    private String purpose;
    // estado de la reserva
    private int status;
}
