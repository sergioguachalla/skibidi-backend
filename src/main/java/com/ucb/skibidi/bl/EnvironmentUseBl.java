package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.*;
import com.ucb.skibidi.dto.EnvironmentDto;
import com.ucb.skibidi.dto.EnvironmentReservationDto;
import com.ucb.skibidi.entity.Environment;
import com.ucb.skibidi.entity.EnvironmentUse;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.entity.UserLibrarian;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.security.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class EnvironmentUseBl {
    private static final Logger log = LoggerFactory.getLogger(EnvironmentUseBl.class);

    @Autowired
    private EnvironmentUseRepository environmentUseRepository;
    @Autowired
    private EnvironmentRepository environmentRepository;
    @Autowired
    private UserClientRepository userClientRepository;

    // create a reservation to be approved by a librarian
    public void createEnvironmentReservation(EnvironmentReservationDto environmentReservationDto) {
        log.info("Creating environment reservation...");
        System.out.println("date1: " + environmentReservationDto.getClockIn());
        System.out.println("dat2: " + environmentReservationDto.getClockOut());
        log.info("Environment reservation: {}", environmentReservationDto.getClientId());
        try {
            Environment environment = new Environment();
            environment.setEnvironmentId(environmentReservationDto.getEnvironmentId());

            EnvironmentUse environmentUse = new EnvironmentUse();
            environmentUse.setEnvironmentId(environment);

            UserClient client = new UserClient();
            client.setClientId(userClientRepository.findClientIdByKcUuid(environmentReservationDto.getClientId()));
            log.info("Client: {}", client);
            environmentUse.setClientId(client);

            environmentUse.setReservationDate(environmentReservationDto.getReservationDate());
            environmentUse.setClockIn(environmentReservationDto.getClockIn());
            environmentUse.setClockOut(environmentReservationDto.getClockOut());

            environmentUse.setPurpose(environmentReservationDto.getPurpose());
            //validateEnvironmentUse(environmentUse);
            environmentUseRepository.save(environmentUse);
            log.info("Environment reservation created");
        } catch (Exception e) {
            log.error("Error creating environment use: {}", e.getMessage());
            throw e;
        }
    }

    public void updateEnvironmentReservation(Integer id,EnvironmentReservationDto environmentReservationDto){
        try {
            Environment environment = new Environment();
            environment.setEnvironmentId(environmentReservationDto.getEnvironmentId());
            EnvironmentUse environmentUse = environmentUseRepository.findById(Long.valueOf(id)).orElseThrow(() -> new RuntimeException("Environment use not found"));
            environmentUse.setEnvironmentId(environment);
            environmentUse.setReservationDate(environmentReservationDto.getReservationDate());
            environmentUse.setClockIn(environmentReservationDto.getClockIn());
            environmentUse.setClockOut(environmentReservationDto.getClockOut());
            environmentUse.setPurpose(environmentReservationDto.getPurpose());
            environmentUseRepository.save(environmentUse);
        } catch (Exception e) {
            log.error("Error updating environment use: {}", e.getMessage());
            throw e;
        }
    }

    public EnvironmentReservationDto getEnvironmentReservationById (Integer id){

        EnvironmentUse environmentUse = environmentUseRepository.findById(Long.valueOf(id)).orElseThrow(() -> new RuntimeException("Environment use not found"));
       log.info("Environment use found: {}", environmentUse);
        EnvironmentReservationDto environmentReservationDto = new EnvironmentReservationDto();
        environmentReservationDto.setClientId(environmentUse.getClientId().getPersonId().getKcUuid());
        environmentReservationDto.setEnvironmentId(environmentUse.getEnvironmentId().getEnvironmentId());
        environmentReservationDto.setReservationId(environmentUse.getEnvironmentUse());
        environmentReservationDto.setReservationDate(environmentUse.getReservationDate());
        environmentReservationDto.setClockIn(environmentUse.getClockIn());
        environmentReservationDto.setClockOut(environmentUse.getClockOut());
        environmentReservationDto.setPurpose(environmentUse.getPurpose());
        environmentReservationDto.setStatus(environmentUse.getStatus());
        return environmentReservationDto;
    }


    public List<EnvironmentReservationDto> findReservationsByClientId(String kcId){
        log.info("Finding reservations by kcId {}", kcId);
        List<EnvironmentUse> environmentUses = environmentUseRepository.findAllByClientIdPersonIdKcUuid(kcId);
        return environmentUses.stream()
                .map(environmentUse -> {
                    EnvironmentReservationDto environmentReservationDto = new EnvironmentReservationDto();
                    environmentReservationDto.setClientId(environmentUse.getClientId().getPersonId().getKcUuid());
                    environmentReservationDto.setEnvironmentId(environmentUse.getEnvironmentId().getEnvironmentId());
                    //reserva
                    environmentReservationDto.setReservationId(environmentUse.getEnvironmentUse());
                    environmentReservationDto.setReservationDate(environmentUse.getReservationDate());
                    environmentReservationDto.setClockIn(environmentUse.getClockIn());
                    environmentReservationDto.setClockOut(environmentUse.getClockOut());
                    environmentReservationDto.setPurpose(environmentUse.getPurpose());
                    environmentReservationDto.setStatus(environmentUse.getStatus());
                    return environmentReservationDto;
                })
                .toList();
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

        if (!environmentUse.getEnvironmentId().getStatus()) {
            throw new RuntimeException("Environment is not available");
        }

        if (environmentUse.getClockIn().withSecond(0).withNano(0).equals(environmentUse.getClockOut().withSecond(0).withNano(0))) {
            throw new RuntimeException("Clock in and clock out can't be the same");
        }

        log.info("Environment use validated successfully");
    }

    public List<EnvironmentDto> getEnvironmentsAvailability(Date from, Date to) {
        log.info("Fetching environments availability...");
        System.out.println("FROM: "+from);
        System.out.println("TO: "+to);
        List<Environment> environments = environmentRepository.findAll();

        for (Environment environment : environments) {
            List<EnvironmentUse> environmentUses = environmentUseRepository.findReservationsBetweenDates(Math.toIntExact(environment.getEnvironmentId()), from, to);
            if (environmentUses.isEmpty()) {
                environment.setStatus(true);
            } else {
                environment.setStatus(false);
            }
        }
        // Convertir la lista de ambientes a una lista de DTOs
        List<EnvironmentDto> environmentDtos = environments.stream()
                .map(environment -> {
                    EnvironmentDto environmentDto = new EnvironmentDto();
                    environmentDto.setEnvironmentId(environment.getEnvironmentId());
                    environmentDto.setName(environment.getName());
                    environmentDto.setCapacity(environment.getCapacity());
                    environmentDto.setIsAvailable(environment.getStatus());
                    return environmentDto;
                })
                .toList();
        return environmentDtos;
    }
    public Page<EnvironmentReservationDto> findAllReservations(Pageable pageable) {
        Page<EnvironmentUse> environmentUses = environmentUseRepository.findAll(pageable);
        Page<EnvironmentReservationDto> environmentReservationDtos = environmentUses.map(environmentUse -> {
            EnvironmentReservationDto environmentReservationDto = new EnvironmentReservationDto();
            environmentReservationDto.setClientId(environmentUse.getClientId().getPersonId().getName() +
                    " "+ environmentUse.getClientId().getPersonId().getLastname());
            environmentReservationDto.setEnvironmentId(environmentUse.getEnvironmentId().getEnvironmentId());
            environmentReservationDto.setReservationId(environmentUse.getEnvironmentUse());
            environmentReservationDto.setReservationDate(environmentUse.getReservationDate());
            environmentReservationDto.setClockIn(environmentUse.getClockIn());
            environmentReservationDto.setClockOut(environmentUse.getClockOut());
            environmentReservationDto.setPurpose(environmentUse.getPurpose());
            environmentReservationDto.setStatus(environmentUse.getStatus());
            return environmentReservationDto;
        });
        return environmentReservationDtos;
    }

    // con esto es posible modificar a cualquiera de los 3 estados de la reserva
    public void updateReservation(Long id, int status) {
        try {
            log.info("Updating reservation status...");
            log.info("Reservation id: {}", id);
            log.info("New status: {}", status);
            EnvironmentUse environmentUse = environmentUseRepository.findByEnvironmentUse(id);
            log.info("Reservation found: {}", environmentUse);
            validateReservationStatusUpdate(environmentUse, status);
            environmentUse.setStatus(status);
            environmentUseRepository.save(environmentUse);
        } catch (Exception e) {
            log.error("Error updating reservation: {}", e.getMessage());
            throw e;
        }
    }

    public void validateReservationStatusUpdate(EnvironmentUse environmentUse, int status) {
        log.info("Validating reservation status update...");
        if (status < 1 || status > 3) {
            throw new RuntimeException("Invalid reservation status");
        }

        if (environmentUse.getClockIn().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("No es posible modificar una reserva cuando ya ha pasado la fecha limite");
        }

        log.info("Reservation status update validated successfully");
    }

}
