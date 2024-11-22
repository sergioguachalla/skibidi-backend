package com.ucb.skibidi.dto;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class CalendarEnvironmentDto {
    private String environment;
    private LocalDate reservationDate;
    private LocalDateTime clockIn;
    private LocalDateTime clockOut;}
