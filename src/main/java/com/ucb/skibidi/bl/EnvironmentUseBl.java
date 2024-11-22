package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.*;
import com.ucb.skibidi.dto.*;
import com.ucb.skibidi.entity.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.security.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    @Autowired
    private LendBookRepository lendBookRepository;
    @Autowired
    private PersonRepository personRepository;
    @Autowired
    private NotificationBl notificationBl;

    // create a reservation to be approved by a librarian
    public void createEnvironmentReservation(EnvironmentReservationDto environmentReservationDto) {
        log.info("Creating environment reservation...");
        log.info("date1: " + environmentReservationDto.getClockIn());
        log.info("dat2: " + environmentReservationDto.getClockOut());
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
            environmentUse.setStatus(environmentReservationDto.getStatus());
            environmentUseRepository.save(environmentUse);
            Map<String,String> parameters = createEditNotification(environmentReservationDto);
            notificationBl.sendNotification(parameters, personRepository.findByKcUuid(environmentReservationDto.getClientId()).getPhoneNumber(), 1L);

        } catch (Exception e) {
            log.error("Error updating environment use: {}", e.getMessage());
            throw e;
        }
    }

    private Map<String, String> createEditNotification(EnvironmentReservationDto environmentReservationDto) {
        Person person = personRepository.findByKcUuid(environmentReservationDto.getClientId());
        Map<String, String> parameters = new HashMap<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        String formattedDate = environmentReservationDto.getReservationDate().format(dateFormatter);
        String formattedClockIn = environmentReservationDto.getClockIn().format(timeFormatter);
        String formattedClockOut = environmentReservationDto.getClockOut().format(timeFormatter);
        parameters.put("1", person.getName() + " " + person.getLastname());
        parameters.put("2", formattedDate);
        parameters.put("3", formattedClockIn);
        parameters.put("4", formattedClockOut);
        parameters.put("5", "SALA B-" + environmentReservationDto.getEnvironmentId().toString());
        parameters.put("6", environmentReservationDto.getPurpose());
        return parameters;
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
        log.info("FROM: "+from);
        log.info("TO: "+to);
        List<Environment> environments = environmentRepository.findAll();

        for (Environment environment : environments) {
            List<EnvironmentUse> environmentUses = environmentUseRepository.findReservationsBetweenDates(Math.toIntExact(environment.getEnvironmentId()), from, to);
            if (environmentUses.isEmpty() ) {
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

    public Page<EnvironmentReservationDto> findReservationsByClientId(String kcId, Pageable pageable) {
        log.info("Finding reservations by kcId {}", kcId);
        Page<EnvironmentUse> environmentUses = environmentUseRepository.findAllByClientIdPersonIdKcUuidOrderByReservationDateAsc(kcId, pageable);
        return environmentUses.map(environmentUse -> {
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
        });
    }


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
            Map<String,String> parameters = createStatusNotification(environmentUse);
            notificationBl.sendNotification(parameters, environmentUse.getClientId().getPersonId().getPhoneNumber(), (long) status);

        } catch (Exception e) {
            log.error("Error updating reservation: {}", e.getMessage());
            throw e;
        }
    }

    private Map<String, String> createStatusNotification(EnvironmentUse environmentUse) {
        Person person = personRepository.findByKcUuid(environmentUse.getClientId().getPersonId().getKcUuid());
        Map<String, String> parameters = new HashMap<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        String formattedDate = environmentUse.getReservationDate().format(dateFormatter);
        String formattedClockIn = environmentUse.getClockIn().format(timeFormatter);
        String formattedClockOut = environmentUse.getClockOut().format(timeFormatter);
        parameters.put("1", person.getName() + " " + person.getLastname());
        parameters.put("2", formattedDate);
        parameters.put("3", formattedClockIn);
        parameters.put("4", formattedClockOut);
        parameters.put("5", "SALA B-" + environmentUse.getEnvironmentId().getEnvironmentId().toString());
        return parameters;
    }

    public void validateReservationStatusUpdate(EnvironmentUse environmentUse, int status) {
        log.info("Validating reservation status update...");
        if (status < 1 || status > 4) {
            throw new RuntimeException("Invalid reservation status");
        }

        if (environmentUse.getClockIn().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("No es posible modificar una reserva cuando ya ha pasado la fecha limite");
        }

        log.info("Reservation status update validated successfully");
    }

    @Scheduled(fixedRate = 60000)
    public void updateEnvironmentReservationStatus() {
        log.info("Updating environment reservation status...");
        LocalDateTime now = LocalDateTime.now();
        List<EnvironmentUse> environmentUses = environmentUseRepository.findPast(now);

        for (EnvironmentUse environmentUse : environmentUses) {
            // Si el estado es 2 (aceptada) y la hora actual ha pasado ClockOut, se marca como finalizada (estado 4)
            if (environmentUse.getStatus() == 2 && environmentUse.getClockOut().isBefore(now)) {
                environmentUse.setStatus(4);
                environmentUseRepository.save(environmentUse);
            }
            // Si el estado es 1 (pendiente) y la hora actual es igual o mayor a ClockIn, se marca como rechazada (estado 3)
            else if (environmentUse.getStatus() == 1 && (environmentUse.getClockIn().isBefore(now) || environmentUse.getClockIn().isEqual(now))) {
                environmentUse.setStatus(3);
                environmentUseRepository.save(environmentUse);
            }
        }
    }

    public CalendarDto getCalendar(String kcid) {
        List<CalendarBookDto> calendarBookDtos= getCalendarBook(kcid);
        log.info("Fetching calendar for user with kcId {}", kcid);
        List<CalendarEnvironmentDto> environmentReservationDtos = getCalendarEnvironment(kcid);
        CalendarDto calendarDto = new CalendarDto();
        calendarDto.setEnvironments(environmentReservationDtos);
        calendarDto.setBooks(calendarBookDtos);
        return calendarDto;
    }

    public List<CalendarBookDto> getCalendarBook(String kcid) {
        log.info("Fetching calendar for user with kcId {}", kcid);
        List<LendBook> lendBooks = lendBookRepository.findAllByClientIdPersonIdKcUuid(kcid);
        List<CalendarBookDto> calendarBookDtos = lendBooks.stream()
                .map(lendBook -> {
                    CalendarBookDto calendarBookDto = new CalendarBookDto();
                    calendarBookDto.setBookName(lendBook.getBookId().getTitle());
                    calendarBookDto.setAuthor(lendBook.getBookId().getAuthors().stream().map(Author::getName).collect(Collectors.joining(", ")));
                    calendarBookDto.setDate(lendBook.getReturnDate());
                    calendarBookDto.setGenre(lendBook.getBookId().getGenreId().getName());
                   return calendarBookDto;
                })
                .toList();
        return calendarBookDtos;
    }

    public List<CalendarEnvironmentDto> getCalendarEnvironment(String kcid) {
        log.info("Fetching calendar for user with kcId {}", kcid);
        List<EnvironmentUse> environmentUses = environmentUseRepository.findAllByClientIdPersonIdKcUuid(kcid);
        List<CalendarEnvironmentDto> calendarEnvironmentDtos = environmentUses.stream()
                .map(environmentUse -> {
                    CalendarEnvironmentDto calendarEnvironmentDto = new CalendarEnvironmentDto();
                    calendarEnvironmentDto.setEnvironment(environmentUse.getEnvironmentId().getName());
                    calendarEnvironmentDto.setReservationDate(environmentUse.getReservationDate());
                    calendarEnvironmentDto.setClockIn(environmentUse.getClockIn());
                    calendarEnvironmentDto.setClockOut(environmentUse.getClockOut());
                    return calendarEnvironmentDto;
                })
                .toList();
        return calendarEnvironmentDtos;
    }



}
