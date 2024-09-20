package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.*;
import com.ucb.skibidi.dto.EnvironmentReservationDto;
import com.ucb.skibidi.entity.Environment;
import com.ucb.skibidi.entity.EnvironmentUse;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.entity.UserLibrarian;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class EnvironmentUseBl {
    private static final Logger log = LoggerFactory.getLogger(EnvironmentUseBl.class);

    @Autowired
    private EnvironmentUseRepository environmentUseRepository;

    // create a reservation to be approved by a librarian
    public void createEnvironmentReservation(EnvironmentReservationDto environmentReservationDto) {
        log.info("Creating environment reservation...");
        try {
            Environment environment = new Environment();
            environment.setEnvironmentId(environmentReservationDto.getEnvironmentId());

            EnvironmentUse environmentUse = new EnvironmentUse();
            environmentUse.setEnvironmentId(environment);

            UserClient client = new UserClient();
            client.setClientId(environmentReservationDto.getClientId());

            environmentUse.setClientId(client);

            environmentUse.setReservationDate(environmentReservationDto.getReservationDate());
            environmentUse.setClockIn(environmentReservationDto.getClockIn());
            environmentUse.setClockOut(environmentReservationDto.getClockOut());

            environmentUse.setPurpose(environmentReservationDto.getPurpose());
            validateEnvironmentUse(environmentUse);
            environmentUseRepository.save(environmentUse);
            log.info("Environment reservation created");
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
//    if (environmentUse.getLibrarianId() == null) {
//        throw new RuntimeException("Librarian not found");
//    }
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

        LocalDateTime now = LocalDateTime.now().withSecond(0).withNano(0);

        if (environmentUse.getClockIn() == null) {
            throw new RuntimeException("Clock in is required");
        } else {
            LocalDateTime clockInDateTime = environmentUse.getClockIn().withSecond(0).withNano(0);

            log.info("Clock in (LocalDateTime): " + clockInDateTime);
            log.info("Current time (LocalDateTime): " + now);

            if (clockInDateTime.isBefore(now)) {
                throw new RuntimeException("Clock in must be in the future or today");
            }

            // Validar que clockIn esté en el mismo día que reservationDate
            if (!clockInDateTime.toLocalDate().equals(environmentUse.getReservationDate())) {
                throw new RuntimeException("Clock in must be on the same day as the reservation date");
            }
        }

        if (environmentUse.getClockOut() == null) {
            throw new RuntimeException("Clock out is required");
        } else {
            LocalDateTime clockOutDateTime = environmentUse.getClockOut().withSecond(0).withNano(0);

            if (clockOutDateTime.isBefore(environmentUse.getClockIn().withSecond(0).withNano(0))) {
                throw new RuntimeException("Clock out can't be before clock in");
            }

            // Validar que clockOut esté en el mismo día que reservationDate
            if (!clockOutDateTime.toLocalDate().equals(environmentUse.getReservationDate())) {
                throw new RuntimeException("Clock out must be on the same day as the reservation date");
            }
        }

        if (environmentUse.getPurpose() == null || environmentUse.getPurpose().isEmpty()) {
            throw new RuntimeException("Purpose is required");
        }

        if (!environmentUse.getEnvironmentId().getIsAvailable()) {
            throw new RuntimeException("Environment is not available");
        }

        if (environmentUse.getClockIn().withSecond(0).withNano(0).equals(environmentUse.getClockOut().withSecond(0).withNano(0))) {
            throw new RuntimeException("Clock in and clock out can't be the same");
        }

        log.info("Environment use validated successfully");
    }





}
