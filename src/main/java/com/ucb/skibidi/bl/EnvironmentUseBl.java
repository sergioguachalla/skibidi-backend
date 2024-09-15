package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.*;
import com.ucb.skibidi.dto.EnvironmentUseDto;
import com.ucb.skibidi.entity.Environment;
import com.ucb.skibidi.entity.EnvironmentUse;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.entity.UserLibrarian;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Service
public class EnvironmentUseBl {
    private static final Logger log = LoggerFactory.getLogger(EnvironmentUseBl.class);

    @Autowired
    private EnvironmentUseRepository environmentUseRepository;
    @Autowired
    private EnvironmentRepository environmentRepository;
    @Autowired
    private UserClientRepository userClientRepository;
    @Autowired
    private UserLibrarianRepository userLibrarianRepository;

    public void createEnvironmentUse(EnvironmentUseDto environmentUseDto) {
        log.info("Creating environment use...");
        try {
            Environment environment = environmentRepository.findByName(environmentUseDto.getEnvironmentName());
            UserClient client = userClientRepository.findByUsername(environmentUseDto.getClientName());
            UserLibrarian librarian = userLibrarianRepository.findByUsername(environmentUseDto.getLibrarianName());
            EnvironmentUse environmentUse = new EnvironmentUse();
            environmentUse.setEnvironmentId(environment);
            environmentUse.setClientId(client);
            environmentUse.setLibrarianId(librarian);
            environmentUse.setReservationDate(environmentUseDto.getReservationDate());
            environmentUse.setClockIn(environmentUseDto.getClockIn());
            environmentUse.setClockOut(environmentUseDto.getClockOut());
            environmentUse.setPurpose(environmentUseDto.getPurpose());
            validateEnvironmentUse(environmentUse);
            environmentUseRepository.save(environmentUse);
            log.info("Environment use created");
        } catch (Exception e) {
            log.error("Error creating environment use: {}", e.getMessage());
            throw e;
        }
    }


    private void validateEnvironmentUse(EnvironmentUse environmentUse) {
        log.info("Validating environment use...");

        if (environmentUse.getEnvironmentId() == null) {
            throw new RuntimeException("Environment not found");
        }
        if (environmentUse.getClientId() == null) {
            throw new RuntimeException("Client not found");
        }
        if (environmentUse.getLibrarianId() == null) {
            throw new RuntimeException("Librarian not found");
        }
        if (environmentUse.getReservationDate() == null) {
            throw new RuntimeException("Reservation date is required");
        } else {
            LocalDate reservationLocalDate = environmentUse.getReservationDate();
            LocalDate today = LocalDate.now();

            log.info("Reservation date (LocalDate): " + reservationLocalDate);
            log.info("Today's date (LocalDate): " + today);

            if (reservationLocalDate.isBefore(today)) {
                log.error("Validation failed: Reservation date is before today");
                throw new RuntimeException("Reservation date must be today or in the future");
            }
        }

        if (environmentUse.getClockIn() == null) {
            throw new RuntimeException("Clock in is required");
        } else {
            LocalDateTime now = LocalDateTime.now();

            log.info("Clock in (LocalDateTime): " + environmentUse.getClockIn());
            log.info("Current time (LocalDateTime): " + now);

            if (environmentUse.getClockIn().toLocalDate().isBefore(now.toLocalDate())) {
                throw new RuntimeException("Clock in must be in the future or today");
            }
        }

        if (environmentUse.getClockOut() == null) {
            throw new RuntimeException("Clock out is required");
        } else if (environmentUse.getClockOut().isBefore(environmentUse.getClockIn())) {
            throw new RuntimeException("Clock out can't be before clock in");
        }

        if (environmentUse.getPurpose() == null || environmentUse.getPurpose().isEmpty()) {
            throw new RuntimeException("Purpose is required");
        }

        if (!environmentUse.getEnvironmentId().getIsAvailable()) {
            throw new RuntimeException("Environment is not available");
        }


        log.info("Environment use validated successfully");
    }





}
